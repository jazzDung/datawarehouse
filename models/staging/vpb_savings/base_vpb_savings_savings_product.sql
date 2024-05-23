with source as (
      select * from {{ source('vpb_savings', 'savings_product') }}
),
renamed as (
    select
        {{ adapter.quote("product_id") }},
        {{ adapter.quote("product_name") }},
        {{ adapter.quote("min_term") }},
        {{ adapter.quote("max_term") }},
        {{ adapter.quote("interest_rate") }},
        {{ adapter.quote("min_deposit") }},
        {{ adapter.quote("deposit_method") }},
        {{ adapter.quote("interest_payment") }},
        {{ adapter.quote("promotion") }},
        {{ adapter.quote("created_at") }},
        {{ adapter.quote("updated_at") }}

    from source
)
select * from renamed
  