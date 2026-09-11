{{
    config(
        materialized='table'
    )
}}

select
    order_id,
    customer_id,
    order_date,
    amount as old_prices,
    amount + 50 as new_prices
from {{ source('movies', 'RAW_ORDERS') }}