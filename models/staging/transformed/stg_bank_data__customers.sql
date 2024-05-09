{{
    config(
        materialized = 'view',
        unique_key = 'customer_id',
        sort = ['customer_id']
    )
}}

with
    rename as (
        select 
        -- id
            customer_id::text as customer_id
        -- text
            , gender::text as gender
            , location::text as customer_location
        -- timestamp
            , customer_dob::date as customer_dob
        from {{ source('bank_data', 'customers') }}
    )

select * 
from rename 