with source as (
      select * from {{ source('vpb_savings', 'savings_account_transaction') }}
),
renamed as (
    select
        {{ adapter.quote("transaction_id") }},
        {{ adapter.quote("savings_account_id") }},
        {{ adapter.quote("transaction_date") }},
        {{ adapter.quote("transaction_type") }},
        {{ adapter.quote("transaction_amount") }},
        {{ adapter.quote("balance_after") }},
        {{ adapter.quote("created_at") }},
        {{ adapter.quote("updated_at") }},
        {{ adapter.quote("description") }},
        {{ adapter.quote("teller_id") }},
        {{ adapter.quote("channel") }}

    from source
)
select * from renamed
  