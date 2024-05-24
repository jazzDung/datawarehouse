/* Mô tả: Một dòng là 1 thông tin về khách hàng gửi tiết kiệm
 */
{{
    config(
    materialized = 'incremental',
    unique_key = 'savings_account_id',
    sort = [
        'savings_account_id',
        'deposit_amount',
        'status',
        'seller_id'
    ],
    sort_type = 'interleaved'
    )
}}

with source as (
      select * from {{ source('vpb_savings','savings_account') }}
),

renamed as (
    select
        {{ adapter.quote("savings_account_id") }}::text ,
        {{ adapter.quote("product_id") }}::text ,
        {{ adapter.quote("customer_id") }}::text ,
        {{ adapter.quote("account_number") }}::text ,
        {{ adapter.quote("deposit_amount") }}::float ,
        {{ adapter.quote("opening_date") }}::date ,
        {{ adapter.quote("maturity_date") }}::date ,
        {{ adapter.quote("status") }}::text ,
        {{ adapter.quote("created_at") }}::timestamp ,
        {{ adapter.quote("updated_at") }}::timestamp ,
        {{ adapter.quote("seller_id") }}::text

    from source
)
select * from renamed
  