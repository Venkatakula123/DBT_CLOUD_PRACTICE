{{
    config(
        materialized='incremental',
        unique_key = 'customer_id',
        incremental_strategy = 'merge'

    )
}}

select
    customer_id,
    customer_name,
    email,
    city,
    updated_at,
    ingestion_ts
from {{ source('movies', 'raw_cust') }}

{% if is_incremental() %}
    where updated_at > (select max(updated_at) from {{ this }} 
    
{% endif %}