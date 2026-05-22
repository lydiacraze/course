
{{
    config(
        materialized='view'
    )
}}

SELECT

    CAST(order_id AS INTEGER)               AS order_id,
    CAST(customer_id AS INTEGER)            AS customer_id,
    CAST(store_id AS INTEGER)               AS store_id,

    CAST(order_date AS DATE)                AS order_date,

    TRIM(UPPER(payment_method))             AS payment_method,
    TRIM(UPPER(order_status))               AS order_status,

    CURRENT_TIMESTAMP                       AS etl_loaded_time

FROM {{ source('raw', 'raw_orders') }}

WHERE order_id IS NOT NULL