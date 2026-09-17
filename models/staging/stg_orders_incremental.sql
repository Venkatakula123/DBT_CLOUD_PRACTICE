{{ config(
    materialized = 'incremental',
    unique_key = 'order_id',
    incremental_strategy = 'merge',
    on_schema_change = 'fail',
    schema = 'STG'
) }}

{% set lookback_days = var('orders_lookback_days', 3) %}

with source_data as (

    select
        order_id,
        customer_id,
        order_status,
        order_amount,
        created_at,
        updated_at,
        source_loaded_at,
        is_deleted
    from {{ source('movies', 'ORDERS_STG') }}

    {% if is_incremental() %}
    where updated_at >= (
        select dateadd(
            day,
            -{{ lookback_days }},
            coalesce(max(updated_at), '1900-01-01'::timestamp_ntz)
        )
        from {{ this }}
    )
    {% endif %}
    ),

deduplicated_source as (

    select
        order_id,
        customer_id,
        order_status,
        order_amount,
        created_at,
        updated_at,
        source_loaded_at,
        is_deleted
    from source_data
    qualify row_number() over (
        partition by order_id
        order by updated_at desc, source_loaded_at desc
    ) = 1

)

select
    order_id,
    customer_id,
    order_status,
    order_amount,
    created_at,
    updated_at,
    source_loaded_at,
    is_deleted
from deduplicated_source
where is_deleted = false
