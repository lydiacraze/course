with source as (
    select * from {{ source('ecommerce', 'raw_orders') }}
),

renamed as (
    select
        order_id,
        customer_id,
        cast(order_date as date) as order_date,
        order_status,
        amount::number(10,2)     as order_amount_usd
    from source
)

select * from renamed
