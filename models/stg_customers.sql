SELECT
    CUSTOMER_ID,
    TRIM(FIRST_NAME) AS FIRST_NAME,
    TRIM(LAST_NAME) AS LAST_NAME,
    LOWER(EMAIL) AS EMAIL,
    CITY,
    COUNTRY,
    CREATED_AT

FROM {{ source('raw', 'raw_customers') }}