-- Build the analytics layer for the Olist warehouse.
-- Run with: python scripts/build_marts.py
--
-- raw_*  → stg_*  → fct_* / dim_*
-- Views (not tables) keep the 177 MB CSV import as the only large artifact.

-- ---------------------------------------------------------------------------
-- Staging
-- ---------------------------------------------------------------------------

CREATE OR REPLACE VIEW stg_orders AS
SELECT
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp AS purchase_ts,
    order_approved_at AS approved_ts,
    order_delivered_carrier_date AS delivered_carrier_ts,
    order_delivered_customer_date AS delivered_customer_ts,
    order_estimated_delivery_date AS estimated_delivery_ts
FROM raw_orders;

CREATE OR REPLACE VIEW stg_customers AS
SELECT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix AS zip_code_prefix,
    customer_city,
    customer_state
FROM raw_customers;

CREATE OR REPLACE VIEW stg_order_items AS
SELECT
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date AS shipping_limit_ts,
    price AS item_price,
    freight_value
FROM raw_order_items;

CREATE OR REPLACE VIEW stg_payments AS
SELECT
    order_id,
    payment_sequential,
    payment_type,
    payment_installments AS installments,
    payment_value
FROM raw_payments;

CREATE OR REPLACE VIEW stg_reviews AS
WITH ranked AS (
    SELECT
        *,
        row_number() OVER (
            PARTITION BY order_id
            ORDER BY review_answer_timestamp DESC NULLS LAST, review_creation_date DESC
        ) AS rn
    FROM raw_reviews
)
SELECT
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date AS review_creation_ts,
    review_answer_timestamp AS review_answer_ts,
    date_diff('hour', review_creation_date, review_answer_timestamp) AS response_hours
FROM ranked
WHERE rn = 1;

CREATE OR REPLACE VIEW stg_products AS
SELECT
    p.product_id,
    coalesce(p.product_category_name, 'unknown') AS category_pt,
    coalesce(nullif(t.product_category_name_english, ''), p.product_category_name, 'unknown') AS category_en,
    p.product_name_lenght AS name_length,
    p.product_description_lenght AS description_length,
    p.product_photos_qty AS photos_qty,
    coalesce(p.product_weight_g, 0) AS weight_g,
    coalesce(p.product_length_cm, 0)
        * coalesce(p.product_height_cm, 0)
        * coalesce(p.product_width_cm, 0) AS volume_cm3
FROM raw_products AS p
LEFT JOIN raw_category_translation AS t
    ON p.product_category_name = t.product_category_name;

CREATE OR REPLACE VIEW stg_sellers AS
SELECT
    seller_id,
    seller_zip_code_prefix AS zip_code_prefix,
    seller_city,
    seller_state
FROM raw_sellers;

CREATE OR REPLACE VIEW stg_geolocation AS
SELECT
    geolocation_zip_code_prefix AS zip_code_prefix,
    avg(geolocation_lat) AS lat,
    avg(geolocation_lng) AS lng,
    any_value(geolocation_city) AS city,
    any_value(geolocation_state) AS state
FROM raw_geolocation
GROUP BY 1;

-- ---------------------------------------------------------------------------
-- Marts
-- ---------------------------------------------------------------------------

CREATE OR REPLACE VIEW fct_orders AS
WITH items AS (
    SELECT
        order_id,
        count(*) AS item_count,
        count(DISTINCT seller_id) AS seller_count,
        sum(item_price) AS merchandise_value,
        sum(freight_value) AS freight_value
    FROM stg_order_items
    GROUP BY 1
),
payments AS (
    SELECT
        order_id,
        sum(payment_value) AS payment_value,
        max(installments) AS max_installments
    FROM stg_payments
    GROUP BY 1
),
customers AS (
    SELECT
        customer_id,
        any_value(customer_unique_id) AS customer_unique_id,
        any_value(customer_state) AS customer_state,
        any_value(customer_city) AS customer_city
    FROM stg_customers
    GROUP BY 1
)
SELECT
    o.order_id,
    c.customer_unique_id,
    o.order_status,
    c.customer_state,
    c.customer_city,
    o.purchase_ts,
    o.approved_ts,
    o.delivered_customer_ts,
    o.estimated_delivery_ts,
    coalesce(i.item_count, 0) AS item_count,
    coalesce(i.seller_count, 0) AS seller_count,
    coalesce(i.merchandise_value, 0) AS merchandise_value,
    coalesce(i.freight_value, 0) AS freight_value,
    coalesce(i.merchandise_value, 0) + coalesce(i.freight_value, 0) AS gmv,
    coalesce(p.payment_value, 0) AS payment_value,
    p.max_installments,
    r.review_score,
    CASE
        WHEN o.order_status = 'delivered' AND o.delivered_customer_ts IS NOT NULL
            THEN date_diff('day', o.purchase_ts, o.delivered_customer_ts)
    END AS delivery_days,
    CASE
        WHEN o.order_status = 'delivered'
            AND o.delivered_customer_ts IS NOT NULL
            AND o.delivered_customer_ts > o.estimated_delivery_ts
            THEN true
        ELSE false
    END AS is_late,
    o.order_status = 'delivered' AS is_delivered,
    o.order_status = 'canceled' AS is_canceled,
    coalesce(i.item_count, 0) > 0 AS has_items
FROM stg_orders AS o
LEFT JOIN items AS i ON o.order_id = i.order_id
LEFT JOIN payments AS p ON o.order_id = p.order_id
LEFT JOIN stg_reviews AS r ON o.order_id = r.order_id
LEFT JOIN customers AS c ON o.customer_id = c.customer_id;

CREATE OR REPLACE VIEW fct_order_items AS
SELECT
    i.order_id,
    i.order_item_id,
    i.product_id,
    i.seller_id,
    o.customer_unique_id,
    o.customer_state,
    o.purchase_ts,
    o.order_status,
    p.category_pt,
    p.category_en,
    s.seller_state,
    i.shipping_limit_ts,
    i.item_price,
    i.freight_value,
    i.item_price + i.freight_value AS item_total
FROM stg_order_items AS i
LEFT JOIN fct_orders AS o ON i.order_id = o.order_id
LEFT JOIN stg_products AS p ON i.product_id = p.product_id
LEFT JOIN stg_sellers AS s ON i.seller_id = s.seller_id;

CREATE OR REPLACE VIEW fct_payments AS
SELECT
    p.order_id,
    p.payment_sequential,
    p.payment_type,
    p.installments,
    p.payment_value,
    o.customer_unique_id,
    o.customer_state,
    o.purchase_ts,
    o.order_status,
    CASE
        WHEN p.installments <= 1 THEN '1 (single payment)'
        WHEN p.installments <= 3 THEN '2-3'
        WHEN p.installments <= 6 THEN '4-6'
        WHEN p.installments <= 12 THEN '7-12'
        ELSE '13+'
    END AS installment_band
FROM stg_payments AS p
LEFT JOIN fct_orders AS o ON p.order_id = o.order_id;

CREATE OR REPLACE VIEW fct_reviews AS
SELECT
    r.review_id,
    r.order_id,
    r.review_score,
    r.review_comment_title,
    r.review_comment_message,
    r.review_creation_ts,
    r.review_answer_ts,
    r.response_hours,
    o.customer_unique_id,
    o.customer_state,
    o.purchase_ts,
    o.order_status
FROM stg_reviews AS r
LEFT JOIN fct_orders AS o ON r.order_id = o.order_id;

CREATE OR REPLACE VIEW dim_customers AS
WITH customer_orders AS (
    SELECT
        customer_unique_id,
        min(purchase_ts) AS first_order_ts,
        max(purchase_ts) AS last_order_ts,
        count(*) AS order_count,
        sum(CASE WHEN order_status = 'delivered' THEN 1 ELSE 0 END) AS delivered_order_count,
        sum(gmv) AS total_gmv,
        avg(review_score) AS avg_review_score
    FROM fct_orders
    WHERE customer_unique_id IS NOT NULL
    GROUP BY 1
),
customer_places AS (
    SELECT
        customer_unique_id,
        any_value(customer_state) AS customer_state,
        any_value(customer_city) AS customer_city
    FROM stg_customers
    GROUP BY 1
)
SELECT
    c.customer_unique_id,
    p.customer_state,
    p.customer_city,
    c.first_order_ts,
    c.last_order_ts,
    c.order_count,
    c.delivered_order_count,
    c.total_gmv,
    c.avg_review_score,
    c.order_count > 1 AS is_repeat_customer
FROM customer_orders AS c
LEFT JOIN customer_places AS p ON c.customer_unique_id = p.customer_unique_id;

CREATE OR REPLACE VIEW dim_products AS
WITH first_sale AS (
    SELECT product_id, min(purchase_ts) AS first_seen_ts
    FROM fct_order_items
    GROUP BY 1
)
SELECT
    p.product_id,
    p.category_pt,
    p.category_en,
    p.name_length,
    p.description_length,
    p.photos_qty,
    p.weight_g,
    p.volume_cm3,
    f.first_seen_ts,
    CASE
        WHEN p.weight_g < 500 THEN '< 500 g'
        WHEN p.weight_g < 2000 THEN '500 g - 2 kg'
        WHEN p.weight_g < 10000 THEN '2 - 10 kg'
        ELSE '10 kg +'
    END AS weight_band
FROM stg_products AS p
LEFT JOIN first_sale AS f ON p.product_id = f.product_id;

CREATE OR REPLACE VIEW dim_sellers AS
WITH first_sale AS (
    SELECT seller_id, min(purchase_ts) AS first_seen_ts
    FROM fct_order_items
    GROUP BY 1
)
SELECT
    s.seller_id,
    s.seller_state,
    s.seller_city,
    s.zip_code_prefix,
    f.first_seen_ts
FROM stg_sellers AS s
LEFT JOIN first_sale AS f ON s.seller_id = f.seller_id;

CREATE OR REPLACE VIEW dim_geolocation AS
SELECT
    zip_code_prefix,
    city,
    state,
    lat,
    lng
FROM stg_geolocation;

-- dbt time spine is not needed without MetricFlow.
DROP VIEW IF EXISTS time_spine;
