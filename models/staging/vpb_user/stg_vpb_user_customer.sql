with source as (
      select
            *
      from {{ source('vpb_user', 'customer') }}
),
renamed as (
    select
        {{ adapter.quote("customer_id") }},
        {{ adapter.quote("identity_id") }}, -- Cột thông tin nhạy cảm
        {{ adapter.quote("last_name") }},
        {{ adapter.quote("first_name") }},
        {{ adapter.quote("date_of_birth") }},
        {{ adapter.quote("age") }},
        {{ adapter.quote("gender") }},
        {{ adapter.quote("address") }}, -- Cột thông tin nhạy cảm
        {{ adapter.quote("status") }},
        {{ adapter.quote("hometown") }},
        {{ adapter.quote("phone") }}, -- Cột thông tin nhạy cảm
        {{ adapter.quote("email") }}, -- Cột thông tin nhạy cảm
        {{ adapter.quote("register_date") }},
        {{ adapter.quote("customer_type") }}

    from source
)
select * from renamed
  