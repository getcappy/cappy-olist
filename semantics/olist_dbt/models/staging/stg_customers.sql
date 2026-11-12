select
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix as zip_code_prefix,
    customer_city as customer_city,
    customer_state as customer_state
from {{ source('olist_raw', 'raw_customers') }}
