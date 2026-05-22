{{
    config(
        materialized='incremental',
        incremental_strategy='merge',
         pre_hook=[
          "TRUNCATE TABLE IF EXISTS {{ this }}"
        ]
    )
}}

SELECT
    order_id,
    customer_id,
    product_id,
    order_dat,
    net_sales as sales_amount,
    CURRENT_TIMESTAMP AS etl_loaded_time

FROM {{ ref('int_sales') }}

{% if is_incremental() %}

WHERE order_date >
(
    SELECT COALESCE(MAX(order_date), '1900-01-01')
    FROM {{ this }}
)

{% endif %}