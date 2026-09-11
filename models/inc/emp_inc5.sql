{{
    config(
        materialized='incremental',
        schema = 'inc_load',
        transient = 'false',
        unique_key = 'updated_at',
        incremental_strategy = 'delete+insert'
    )
}}

Select * from {{source('movies','raw_emp')}}

{% if is_incremental() %}

    where updated_at > (select max(updated_at) from {{this}})

{% endif %}