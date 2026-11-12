select
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp as purchase_ts,
    order_approved_at as approved_ts,
    order_delivered_carrier_date as delivered_carrier_ts,
    order_delivered_customer_date as delivered_customer_ts,
    order_estimated_delivery_date as estimated_delivery_ts
from {{ source('olist_raw', 'raw_orders') }}
