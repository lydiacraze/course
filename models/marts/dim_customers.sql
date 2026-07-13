with customers as (
    select * from {{ ref('stg_ecommerce__customers') }}
),

orders as (
    select * from {{ ref('int_orders_joined_payments') }}
),

customers_orders as (
    select
        customer_id,
        count(distinct order_id)                                                      as lifetime_orders,
        sum(case when payment_status = 'success' then payment_amount_usd else 0 end)   as lifetime_successful_revenue_usd,
        min(order_date)                                                                as first_order_date,
        max(order_date)                                                                as most_recent_order_date
    from orders
    group by 1
),

final as (
    select
        c.customer_id,
        c.customer_name,
        c.email,
        c.plan_tier,
        c.signup_date,
        c.country_code,
        coalesce(co.lifetime_orders, 0)                   as lifetime_orders,
        coalesce(co.lifetime_successful_revenue_usd, 0)    as lifetime_successful_revenue_usd,
        co.first_order_date,
        co.most_recent_order_date
    from customers c
    left join customers_orders co on c.customer_id = co.customer_id
)

select * from final
