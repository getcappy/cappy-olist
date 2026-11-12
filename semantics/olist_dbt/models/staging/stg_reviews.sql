with ranked as (
    select
        *,
        row_number() over (
            partition by order_id
            order by review_answer_timestamp desc nulls last, review_creation_date desc
        ) as rn
    from {{ source('olist_raw', 'raw_reviews') }}
)

select
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date as review_creation_ts,
    review_answer_timestamp as review_answer_ts,
    date_diff('hour', review_creation_date, review_answer_timestamp) as response_hours
from ranked
where rn = 1
