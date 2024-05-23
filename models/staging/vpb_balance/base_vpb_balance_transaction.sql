with source as (
      select * from {{ source('vpb_balance', 'transaction') }}
),
renamed as (
    select
        {{ adapter.quote("transaction_id") }},
        {{ adapter.quote("sender_account_no") }},
        {{ adapter.quote("sender_bank") }},
        {{ adapter.quote("transaction_date") }},
        {{ adapter.quote("transaction_time") }},
        {{ adapter.quote("transaction_type") }},
        {{ adapter.quote("status") }},
        {{ adapter.quote("amount") }},
        {{ adapter.quote("fee") }},
        {{ adapter.quote("currency") }},
        {{ adapter.quote("description") }},
        {{ adapter.quote("rate") }}

    from source
)
select * from renamed
  