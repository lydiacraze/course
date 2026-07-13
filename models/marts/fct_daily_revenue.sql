-- Replaces the legacy sp_build_daily_revenue() stored procedure.
-- Grain: one row per order_date.

{{
    config(
        materialized='incremental',
        unique_key='order_date',
        incremental_strategy='delete+insert',
        on_schema_change='append_new_columns',
        tags=['finance', 'daily']
    )
}}

with joined as (
    select * from {{ ref('int_orders_joined_payments') }}

    {% if is_incremental() %}
    -- only reprocess days that could still be changing (e.g. late-arriving refunds),
    -- mirrors the "run_date" parameter the old procedure took
    where order_date >= dateadd('day', -3, (select max(order_date) from {{ this }}))
    {% endif %}
),

daily as (
    select
        order_date,
        count(distinct order_id)  as total_orders,
        sum(case when payment_status = 'success'  then payment_amount_usd else 0 end) as successful_revenue_usd,
        sum(case when payment_status = 'failure'  then payment_amount_usd else 0 end) as failed_amount_usd,
        sum(case when payment_status = 'refunded' then payment_amount_usd else 0 end) as refunded_amount_usd
    from joined
    group by 1
)

select * from daily
