{{
    config(
        materialized = 'view',
        unique_key = 'transaction_id',
        sort = [
            'customer_id'
            , 'transaction_id'
        ]
    )
}}

with
    rename as (
        select 
        -- id
            transaction_id::text as transaction_id
            , customer_id::text as customer_id
        -- numeric and float
            , round(balance::numeric, 2) as balance
            , round(amount::numeric, 2) as transaction_amount
        -- timestamp
            , transaction_time::timestamp as txn_time
        from {{ source('bank_data', 'transactions') }}
    )

select * 
from rename 