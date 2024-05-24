with source as (
      select * from {{ source('vpb_user', 'customer') }}
),
renamed as (
    select
        {{ adapter.quote("customer_id") }},
        {{ adapter.quote("identity_id") }},
        {{ adapter.quote("last_name") }},
        {{ adapter.quote("first_name") }},
        {{ adapter.quote("date_of_birth") }},
        {{ adapter.quote("age") }},
        {{ adapter.quote("gender") }},
        {{ adapter.quote("address") }},
        {{ adapter.quote("status") }},
        {{ adapter.quote("hometown") }},
        {{ adapter.quote("phone") }},
        {{ adapter.quote("email") }},
        {{ adapter.quote("register_date") }},
        {{ adapter.quote("customer_type") }}

    from source
)
select * from renamed
  