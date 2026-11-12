select
    order_id,
    payment_sequential,
    payment_type,
    payment_installments as installments,
    payment_value
from {{ source('olist_raw', 'raw_payments') }}
