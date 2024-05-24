with source as (
      select * from {{ source('vpb_savings', 'savings_account') }}
),
renamed as (
    select
        {{ adapter.quote("savings_account_id") }},
        {{ adapter.quote("product_id") }},
        {{ adapter.quote("customer_id") }},
        {{ adapter.quote("account_number") }},
        {{ adapter.quote("deposit_amount") }},
        {{ adapter.quote("opening_date") }},
        {{ adapter.quote("maturity_date") }},
        {{ adapter.quote("status") }},
        {{ adapter.quote("created_at") }},
        {{ adapter.quote("updated_at") }},
        {{ adapter.quote("seller_id") }}

    from source
)
select * from renamed
  