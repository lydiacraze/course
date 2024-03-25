{{
    config(
        materialized='incremental',
        on_schema_change='sync_all_columns',
        unique_key='listing_id',
        incremental_strategy= 'delete+insert'
    )
}}

with fct_reviews as (

    select * from {{ ref('src_reviews') }}
)

select  
*
 from fct_reviews

where review_text is not null

{% if is_incremental() %} and review_date > (select max(review_date) from {{this}})
{% endif %}