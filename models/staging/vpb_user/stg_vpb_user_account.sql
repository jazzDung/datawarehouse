with source as (
      select
          *
      from {{ source('vpb_user', 'account') }}
),
renamed as (
    select
        {{ adapter.quote("account_id") }}::text ,
        {{ adapter.quote("customer_id") }}::text,
        {{ adapter.quote("account_number") }}::text,  --- Thông tin nhạy cảm
        {{ adapter.quote("account_type") }}::text,
        {{ adapter.quote("pin") }}, --- Thông tin nhạy cảm
        {{ adapter.quote("cvv") }},
        {{ adapter.quote("date_opened") }},
        {{ adapter.quote("date_closed") }},
        {{ adapter.quote("account_status") }},
        {{ adapter.quote("branch") }}

    from source
)
select * from renamed
  