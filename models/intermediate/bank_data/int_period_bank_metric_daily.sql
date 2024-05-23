{{
    config(
        materialized = 'view',
        unique_key = 'txn_date',
        sort = [
            'txn_date'
            , 'transaction_amount'
        ]
    )
}}

select
    txn_time::date as txn_date
    , sum(transaction_amount) as transaction_amount
    , count(distinct customer_id) as daily_active_customer_count
    , round(avg(balance), 2) as avg_balance
from
    {{ ref('stg_bank_data__transactions') }}
group by
    txn_date
order by txn_date desc