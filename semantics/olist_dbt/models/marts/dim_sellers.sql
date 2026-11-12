with sellers as (
    select * from {{ ref('stg_sellers') }}
),

first_sale as (
    select seller_id, min(purchase_ts) as first_seen_ts
    from {{ ref('fct_order_items') }}
    group by 1
)

select
    s.seller_id,
    s.seller_state,
    s.seller_city,
    s.zip_code_prefix,
    f.first_seen_ts
from sellers as s
left join first_sale as f on s.seller_id = f.seller_id
