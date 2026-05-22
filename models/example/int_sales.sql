{{
    config(
        materialized='table'
    )
}}

SELECT

    o.order_id,
    o.customer_id,
    o.store_id,
    oi.product_id,

    o.order_date,
    o.payment_method,
    o.order_status,

    oi.quantity,
    oi.unit_price,
    oi.discount,

    (oi.quantity * oi.unit_price) AS gross_sales,

    ((oi.quantity * oi.unit_price) - oi.discount)
        AS net_sales,

    CURRENT_TIMESTAMP AS etl_loaded_time

FROM {{ ref('stg_orders') }} o

INNER JOIN {{ ref('stg_order_items') }} oi
    ON o.order_id = oi.order_id