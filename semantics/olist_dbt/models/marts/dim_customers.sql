with orders as (
    select
        customer_unique_id,
        purchase_ts,
        order_status,
        gmv,
        review_score
    from {{ ref('fct_orders') }}
    where customer_unique_id is not null
),

customer_orders as (
    select
        customer_unique_id,
        min(purchase_ts) as first_order_ts,
        max(purchase_ts) as last_order_ts,
        count(*) as order_count,
        sum(case when order_status = 'delivered' then 1 else 0 end) as delivered_order_count,
        sum(gmv) as total_gmv,
        avg(review_score) as avg_review_score
    from orders
    group by 1
),

customer_places as (
    select
        customer_unique_id,
        any_value(customer_state) as customer_state,
        any_value(customer_city) as customer_city
    from {{ ref('stg_customers') }}
    group by 1
)

select
    c.customer_unique_id,
    p.customer_state,
    p.customer_city,
    c.first_order_ts,
    c.last_order_ts,
    c.order_count,
    c.delivered_order_count,
    c.total_gmv,
    c.avg_review_score,
    c.order_count > 1 as is_repeat_customer
from customer_orders as c
left join customer_places as p on c.customer_unique_id = p.customer_unique_id
