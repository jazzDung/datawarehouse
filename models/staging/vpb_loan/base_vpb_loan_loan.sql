with source as (
      select * from {{ source('vpb_loan', 'loan') }}
),
renamed as (
    select
        {{ adapter.quote("customer_id") }},
        {{ adapter.quote("loan_id") }},
        {{ adapter.quote("loan_service") }},
        {{ adapter.quote("loan_type") }},
        {{ adapter.quote("loan_amount") }},
        {{ adapter.quote("interest_rate") }},
        {{ adapter.quote("term") }},
        {{ adapter.quote("created_date") }},
        {{ adapter.quote("start_date") }},
        {{ adapter.quote("end_date") }},
        {{ adapter.quote("status") }},
        {{ adapter.quote("due_principal") }},
        {{ adapter.quote("due_interest") }},
        {{ adapter.quote("paid_principal") }},
        {{ adapter.quote("paid_interest") }},
        {{ adapter.quote("undue_principal") }},
        {{ adapter.quote("undue_interest") }},
        {{ adapter.quote("overdue_principal") }},
        {{ adapter.quote("overdue_interest") }},
        {{ adapter.quote("to_collect_principal") }},
        {{ adapter.quote("to_collect_interest") }},
        {{ adapter.quote("interest_on_overdue_loan") }},
        {{ adapter.quote("unpaid_principal") }},
        {{ adapter.quote("unpaid_interest") }},
        {{ adapter.quote("description") }},
        {{ adapter.quote("created_time") }},
        {{ adapter.quote("release_time") }},
        {{ adapter.quote("overdue_date") }},
        {{ adapter.quote("disbursement_date") }},
        {{ adapter.quote("modified_time") }}

    from source
)
select * from renamed
  