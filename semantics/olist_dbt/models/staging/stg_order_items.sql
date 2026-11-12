select
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date as shipping_limit_ts,
    price as item_price,
    freight_value as freight_value
from {{ source('olist_raw', 'raw_order_items') }}
