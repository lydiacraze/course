{% snapshot scd_raw_hosts %}

{{
   config(
       target_schema='DEV',
       unique_key='id',
       strategy='timestamp',
       updated_at='updated_at',
       dbt_valid_to_current="to_date('9999-12-31')"
   )
}}

select * FROM {{ source('airbnb', 'hosts') }}

{% endsnapshot %}