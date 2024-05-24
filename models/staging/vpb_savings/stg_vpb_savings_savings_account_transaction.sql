/* Mô tả: Một dòng là 1 thông tin giao dịch gửi/rút
 */
{{
    config(
    materialized = 'incremental',
    unique_key = 'savings_account_id',
    sort = [
        'savings_account_id',
        'transaction_type',
        'channel',
        'description'
    ],
    sort_type = 'interleaved'
    )
}}

with source as (
      select * from {{ source('vpb_savings', 'savings_account_transaction') }}
),

renamed as (
    select
        {{ adapter.quote("transaction_id") }}::text ,
        {{ adapter.quote("savings_account_id") }}::text ,
        {{ adapter.quote("transaction_date") }}::date ,
        {{ adapter.quote("transaction_type") }}::text ,
        {{ adapter.quote("transaction_amount") }}::float ,
        {{ adapter.quote("balance_after") }}::float ,
        {{ adapter.quote("created_at") }}::timestamp ,
        {{ adapter.quote("updated_at") }}::timestamp ,
        {{ adapter.quote("description") }}::text ,
        {{ adapter.quote("teller_id") }}::text ,
        {{ adapter.quote("channel") }}::text

    from source
)
select * from renamed
  