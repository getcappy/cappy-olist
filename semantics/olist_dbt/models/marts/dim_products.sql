with products as (
    select * from {{ ref('stg_products') }}
),

first_sale as (
    select product_id, min(purchase_ts) as first_seen_ts
    from {{ ref('fct_order_items') }}
    group by 1
)

select
    p.product_id,
    p.category_pt,
    p.category_en,
    p.name_length,
    p.description_length,
    p.photos_qty,
    p.weight_g,
    p.volume_cm3,
    f.first_seen_ts,
    case
        when p.weight_g < 500 then '< 500 g'
        when p.weight_g < 2000 then '500 g - 2 kg'
        when p.weight_g < 10000 then '2 - 10 kg'
        else '10 kg +'
    end as weight_band
from products as p
left join first_sale as f on p.product_id = f.product_id
