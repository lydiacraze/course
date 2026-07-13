with source as (
    select * from {{ source('ecommerce', 'raw_customers') }}
),

renamed as (
    select
        customer_id,
        first_name,
        last_name,
        first_name || ' ' || last_name as customer_name,
        lower(email)                    as email,
        plan_tier,
        cast(signup_date as date)       as signup_date,
        country_code
    from source
)

select * from renamed
