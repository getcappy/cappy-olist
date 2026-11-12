with orders as (
    select * from {{ ref('stg_orders') }}
),

items as (
    select
        order_id,
        count(*) as item_count,
        count(distinct seller_id) as seller_count,
        sum(item_price) as merchandise_value,
        sum(freight_value) as freight_value
    from {{ ref('stg_order_items') }}
    group by 1
),

payments as (
    select
        order_id,
        sum(payment_value) as payment_value,
        max(installments) as max_installments
    from {{ ref('stg_payments') }}
    group by 1
),

reviews as (
    select order_id, review_score from {{ ref('stg_reviews') }}
),

customers as (
    select
        customer_id,
        any_value(customer_unique_id) as customer_unique_id,
        any_value(customer_state) as customer_state,
        any_value(customer_city) as customer_city
    from {{ ref('stg_customers') }}
    group by 1
)

select
    o.order_id,
    c.customer_unique_id,
    o.order_status,
    c.customer_state,
    c.customer_city,
    o.purchase_ts,
    o.approved_ts,
    o.delivered_customer_ts,
    o.estimated_delivery_ts,
    coalesce(i.item_count, 0) as item_count,
    coalesce(i.seller_count, 0) as seller_count,
    coalesce(i.merchandise_value, 0) as merchandise_value,
    coalesce(i.freight_value, 0) as freight_value,
    coalesce(i.merchandise_value, 0) + coalesce(i.freight_value, 0) as gmv,
    coalesce(p.payment_value, 0) as payment_value,
    p.max_installments,
    r.review_score,
    case
        when o.order_status = 'delivered' and o.delivered_customer_ts is not null
            then date_diff('day', o.purchase_ts, o.delivered_customer_ts)
    end as delivery_days,
    case
        when o.order_status = 'delivered'
            and o.delivered_customer_ts is not null
            and o.delivered_customer_ts > o.estimated_delivery_ts
            then true
        else false
    end as is_late,
    o.order_status = 'delivered' as is_delivered,
    o.order_status = 'canceled' as is_canceled,
    coalesce(i.item_count, 0) > 0 as has_items
from orders as o
left join items as i on o.order_id = i.order_id
left join payments as p on o.order_id = p.order_id
left join reviews as r on o.order_id = r.order_id
left join customers as c on o.customer_id = c.customer_id
