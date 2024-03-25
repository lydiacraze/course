
{{
    config(
        materialized='view'
    )
}}

with final as (
    select * from {{ ref('src_hosts') }}
)

select 
    host_id,
        NVL(
        host_name,
        'Anonymous'
    ) AS host_name,
    is_superhost,
    created_at,
    updated_at

from final