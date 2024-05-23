/* Mô tả: Môt dòng là 1 giao chuyển tiền của KH
 */

{{
    config(
    materialized = 'table',
    unique_key = 'txn_date',
    sort = [
        'txn_date',
        'transaction_amount'
    ]
    )
}}


with source as (
    select
        *
    from   {{ ref('int_period_bank_metric_daily') }}
)
    select * from source