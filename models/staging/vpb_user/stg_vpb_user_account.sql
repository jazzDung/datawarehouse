{{
    config(
    materialized = 'incremental',
    unique_key = 'account_id',
    sort = [
        'account_id',
        'pin',
        'cvv',
        'account_branch'
    ],
    sort_type = 'interleaved'
    )
}}

with source as (
      select * from {{ source('vpb_user', 'vpb_user_account') }}
),

renamed as (
    select
        {{ adapter.quote("account_id") }}::text,
        {{ adapter.quote("customer_id") }}::text ,
        {{ adapter.quote("account_number") }}::text,
        {{ adapter.quote("account_type") }}:text,
        {{ adapter.quote("pin") }}::int ,
        {{ adapter.quote("cvv") }}:int ,
        {{ adapter.quote("date_opened") }}::date ,
        {{ adapter.quote("date_closed") }}::date ,
        {{ adapter.quote("account_status") }}::text ,
        {{ adapter.quote("branch") }}::text

    from source
)
select * from renamed
  