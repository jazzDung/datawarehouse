with source as (
      select * from {{ source('vpb_user', 'account') }}
),
renamed as (
    select
        {{ adapter.quote("account_id") }},
        {{ adapter.quote("customer_id") }},
        {{ adapter.quote("account_number") }},
        {{ adapter.quote("account_type") }},
        {{ adapter.quote("pin") }},
        {{ adapter.quote("cvv") }},
        {{ adapter.quote("date_opened") }},
        {{ adapter.quote("date_closed") }},
        {{ adapter.quote("account_status") }},
        {{ adapter.quote("branch") }}

    from source
)
select * from renamed
  