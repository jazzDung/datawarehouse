with source as (
      select * from {{ source('vpb_loan', 'loan_payment') }}
),
renamed as (
    select
        {{ adapter.quote("scheduled_payment_date") }},
        {{ adapter.quote("payment_amount") }},
        {{ adapter.quote("principal_amount") }},
        {{ adapter.quote("interest_amount") }},
        {{ adapter.quote("paid_amount") }},
        {{ adapter.quote("paid_date") }}

    from source
)
select * from renamed
  