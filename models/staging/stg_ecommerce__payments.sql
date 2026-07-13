with source as (
    select * from {{ source('ecommerce', 'raw_payments') }}
),

renamed as (
    select
        payment_id,
        order_id,
        customer_id,
        {{ cents_to_dollars('amount_cents') }} as amount_usd,
        status,
        cast(created_at_utc as timestamp)      as created_at_utc,
        {{ to_ist('created_at_utc') }}          as created_at_ist
    from source
)


select * from renamed





