with payments as (
    select * from {{ ref('stg_payments') }}
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
    p.order_id,
    p.payment_sequential,
    p.payment_type,
    p.installments,
    p.payment_value,
    o.customer_unique_id,
    o.customer_state,
    o.purchase_ts,
    o.order_status,
    case
        when p.installments <= 1 then '1 (single payment)'
        when p.installments <= 3 then '2-3'
        when p.installments <= 6 then '4-6'
        when p.installments <= 12 then '7-12'
        else '13+'
    end as installment_band
from payments as p
left join orders as o on p.order_id = o.order_id
