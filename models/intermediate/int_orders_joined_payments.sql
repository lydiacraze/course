with orders as (
    select * from {{ ref("stg_ecommerce__orders") }}
),

payments as (
    select * from {{ ref("stg_ecommerce__payments")}}
),

joined as (
    select
        o.order_id,
        o.customer_id,
        o.order_date,
        o.order_status,
        o.order_amount_usd,
        p.payment_id,
        p.status as payment_status,
        p.amount_usd  as payment_amount_usd,
        p.created_at_utc as payment_created_at_utc
    from orders o
    left join payments p on o.order_id = p.order_id

)

select * from joined 





