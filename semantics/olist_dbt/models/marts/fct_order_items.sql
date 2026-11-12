with order_items as (
    select * from {{ ref('stg_order_items') }}
),

orders as (
    select
        order_id,
        customer_unique_id,
        customer_state,
        purchase_ts,
        order_status
    from {{ ref('fct_orders') }}
),

products as (
    select * from {{ ref('stg_products') }}
),

sellers as (
    select * from {{ ref('stg_sellers') }}
)

select
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
    i.item_price + i.freight_value as item_total
from order_items as i
left join orders as o on i.order_id = o.order_id
left join products as p on i.product_id = p.product_id
left join sellers as s on i.seller_id = s.seller_id
