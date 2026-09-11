{{ config(
    materialized='incremental',
    schema='inc_load',
    transient=false,
    event_time='updated_at',
    begin="2026-01-01",
    batch_size = 'year',
    incremental_strategy='microbatch'
) }}

select *
from {{ source('movies','raw_emp') }}

{% if is_incremental() %}
where updated_at > (select max(updated_at) from {{ this }})
{% endif %}
