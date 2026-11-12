select
    p.product_id,
    coalesce(p.product_category_name, 'unknown') as category_pt,
    coalesce(nullif(t.product_category_name_english, ''), p.product_category_name, 'unknown') as category_en,
    p.product_name_lenght as name_length,
    p.product_description_lenght as description_length,
    p.product_photos_qty as photos_qty,
    coalesce(p.product_weight_g, 0) as weight_g,
    coalesce(p.product_length_cm, 0)
        * coalesce(p.product_height_cm, 0)
        * coalesce(p.product_width_cm, 0) as volume_cm3
from {{ source('olist_raw', 'raw_products') }} as p
left join {{ source('olist_raw', 'raw_category_translation') }} as t
    on p.product_category_name = t.product_category_name
