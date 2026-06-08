
{{
    config(
        tags =  ['my_tag']
    )
}}

SELECT
 *
FROM
 {{ ref('dim_listings_cleansed') }}
WHERE minimum_nights < 1
LIMIT 10