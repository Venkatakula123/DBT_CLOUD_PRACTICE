{{
    config(
        materialized='table'
    )
}}

Select 
    customer_id,
    customer_name,
    country,
    CASE    WHEN country  = 'India' then '+91'
            WHEN country = 'USA' then '+1'
            when country = 'UK' then '+92'
            when country = 'Canada' then '+93' end as Country_code
from {{ source('movies', 'RAW_CUSTOMERS') }}
