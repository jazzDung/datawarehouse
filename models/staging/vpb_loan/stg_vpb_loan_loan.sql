{{
    config(
    materialized = 'incremental',
    unique_key = 'loan_id',
    sort = [
        'loan_id',
        'loan_type',
        'status',
        'description'
    ],
    sort_type = 'interleaved'
    )
}}

with source as (
      select * from {{ source('vpb_loan','vpb_loan_loan') }}
),

renamed as (
    select
        {{ adapter.quote("customer_id") }}::text ,
        {{ adapter.quote("loan_id") }}::text ,
        {{ adapter.quote("loan_service") }}::text ,
        {{ adapter.quote("loan_type") }}::text ,
        {{ adapter.quote("loan_amount") }}::float ,
        {{ adapter.quote("interest_rate") }}::float ,
        {{ adapter.quote("term") }}::int ,
        {{ adapter.quote("created_date") }}::date ,
        {{ adapter.quote("start_date") }}::date ,
        {{ adapter.quote("end_date") }}::date ,
        {{ adapter.quote("status") }}::text,
        {{ adapter.quote("due_principal") }}::decimal ,
        {{ adapter.quote("due_interest") }}::decimal ,
        {{ adapter.quote("paid_principal") }}::decimal ,
        {{ adapter.quote("paid_interest") }}::decimal ,
        {{ adapter.quote("undue_principal") }}::decimal ,
        {{ adapter.quote("undue_interest") }}::decimal ,
        {{ adapter.quote("overdue_principal") }}::decimal ,
        {{ adapter.quote("overdue_interest") }}::decimal ,
        {{ adapter.quote("to_collect_principal") }}::decimal ,
        {{ adapter.quote("to_collect_interest") }}::decimal ,
        {{ adapter.quote("interest_on_overdue_loan") }}::decimal ,
        {{ adapter.quote("unpaid_principal") }}::decimal ,
        {{ adapter.quote("unpaid_interest") }}::decimal ,
        {{ adapter.quote("description") }}::text ,
        {{ adapter.quote("created_time") }}::timestamp ,
        {{ adapter.quote("release_time") }}::timestamp ,
        {{ adapter.quote("overdue_date") }}::date ,
        {{ adapter.quote("disbursement_date") }}::date ,
        {{ adapter.quote("modified_time") }}::timestamp

    from source
)
select * from renamed
  