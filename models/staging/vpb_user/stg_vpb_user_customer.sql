{{
    config(
    materialized = 'incremental',
    unique_key = 'customer_id',
    sort = [
        'customer_id',
        'identity_id',
        'customer_type'
    ],
    sort_type = 'interleaved'
    )
}}

with source as (
      select * from {{ source('vpb_user', 'vpb_user_customer') }}
),

renamed as (
    select
        {{ adapter.quote("customer_id") }}::text,
        {{ adapter.quote("identity_id") }}::text,
        {{ adapter.quote("last_name") }}::text,
        {{ adapter.quote("first_name") }}::text,
        {{ adapter.quote("date_of_birth") }}::date ,
        {{ adapter.quote("age") }}::int ,
        {{ adapter.quote("gender") }}::text ,
        {{ adapter.quote("address") }}::text ,
        {{ adapter.quote("status") }}::text ,
        {{ adapter.quote("hometown") }}::text ,
        {{ adapter.quote("phone") }}::text ,
        {{ adapter.quote("email") }}::text ,
        {{ adapter.quote("register_date") }}::date ,
        {{ adapter.quote("customer_type") }}::text

    from source
)
select * from renamed
  