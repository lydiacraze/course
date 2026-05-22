{{
    config(
        materialized='view'
    )
}}

SELECT

    CAST(order_item_id AS INTEGER)          AS order_item_id,
    CAST(order_id AS INTEGER)               AS order_id,
    CAST(product_id AS INTEGER)             AS product_id,

    CAST(quantity AS INTEGER)               AS quantity,

    CAST(unit_price AS NUMBER(10,2))
                                            AS unit_price,

    CAST(discount AS NUMBER(10,2))
                                            AS discount,

    (quantity * unit_price)                 AS gross_amount,

    ((quantity * unit_price) - discount)
                                            AS net_amount,

    CURRENT_TIMESTAMP                       AS etl_loaded_time

FROM {{ source('raw', 'raw_order_items') }}

WHERE order_item_id IS NOT NULL

