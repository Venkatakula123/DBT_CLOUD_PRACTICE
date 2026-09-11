{{
    config(
        materialized='incremental',
        schema = 'inc_load'
    )
}}

Select * from {{source('movies','raw_emp')}}

{% if is_incremental() %}

    where updated_at > (select max(updated_at) from {{this}})

{% endif %}