with reviews as (
    select * from {{ ref('stg_reviews') }}
),

orders as (
    select
        order_id,
        customer_unique_id,
        customer_state,
        purchase_ts,
        order_status
    from {{ ref('fct_orders') }}
)

select
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
from reviews as r
left join orders as o on r.order_id = o.order_id
