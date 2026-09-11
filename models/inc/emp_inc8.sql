{{ config(
    materialized='incremental',
    schema='inc_load',
    transient=false,
    event_time='JOIN_DATE',
    begin="2025-01-01",
    batch_size = 'year', 
    incremental_strategy='microbatch'
) }}

select *
from {{ source('movies','employees') }}

{% if is_incremental() %}
where JOIN_DATE > (select max(JOIN_DATE) from {{ this }})
{% endif %}
