int_customer_orders.sql
WITH CUSTOMER_ORDERS AS (

    SELECT
        C.CUSTOMER_ID,
        C.FIRST_NAME,
        C.LAST_NAME,
        O.ORDER_ID,
        O.ORDER_DATE,
        O.ORDER_STATUS,
        O.TOTAL_AMOUNT

    FROM {{ ref('stg_customers') }} C

    INNER JOIN {{ ref('stg_orders') }} O
        ON C.CUSTOMER_ID = O.CUSTOMER_ID

)

SELECT *
FROM CUSTOMER_ORDERS 