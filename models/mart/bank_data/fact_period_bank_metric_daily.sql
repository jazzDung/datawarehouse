{{
    config(
        materialized = 'table',
        unique_key = 'txn_date',
        sort = [
            'txn_date'
            , 'transaction_amount'
        ]
    )
}}

select *
from {{ ref('int_period_bank_metric_daily') }}