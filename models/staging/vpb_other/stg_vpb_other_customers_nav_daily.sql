with source as (
      select * from {{ source('vpb_other', 'customers_nav_daily') }}
),
renamed as (
    select
        {{ adapter.quote("gen_date") }},
        {{ adapter.quote("customer_id") }},
        {{ adapter.quote("nav") }},
        {{ adapter.quote("total_balance") }},
        {{ adapter.quote("deposit") }},
        {{ adapter.quote("withdraw") }},
        {{ adapter.quote("total_loan") }},
        {{ adapter.quote("new_loan") }},
        {{ adapter.quote("total_saving") }},
        {{ adapter.quote("new_saving") }},
        {{ adapter.quote("customer_segment") }},
        {{ adapter.quote("is_recommended_loan") }},
        {{ adapter.quote("recommended_loan_type") }},
        {{ adapter.quote("is_recommended_savings") }},
        {{ adapter.quote("is_recommended_savings_2") }},
        {{ adapter.quote("is_recommended_credit_card") }},
        {{ adapter.quote("recommended_credit_card_type") }}

    from source
)
select * from renamed
  