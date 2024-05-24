/* Mô tả: Một dòng là 1 thông tin về mỗi khoản vay của khách hàng
 */

{{
    config(
    materialized = 'view',
    unique_key = 'loan_id',
    sort = [
        'loan_id',
        'customer_id',
        'created_at'
    ]
    )
}}

with source as (
    select
        loan_id,
        customer_id,
        loan_service,
        loan_type,
        loan_amount,
        interest_rate,
        term,
        created_date,
        start_date,
        end_date,
        status,
        due_principal,
        due_interest ,
        paid_principal ,
        paid_interest ,
        undue_principal,
        undue_interest ,
        overdue_principal ,
        overdue_interest ,
        to_collect_principal ,
        to_collect_interest,
        interest_on_overdue_loan,
        unpaid_principal ,
        unpaid_interest,
        description ,
        created_time ,
        release_time ,
        overdue_date ,
        disbursement_date ,
        modified_time
    from
        {{ ref('stg_vpb_loan_loan') }} as ac
)
select
    ac.*,
    dc.full_name,
    dc.age as customer_age,
    dc.gender ,
    dc.address ,
    dc.customer_register_date,
    dc.customer_type
from source ac
left join {{ ref('int_dim_custormers') }} as dc  on ac.customer_id = dc.customer_id