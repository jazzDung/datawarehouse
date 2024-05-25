/* mô tả: Một dòng là thông tin chi tiết về 1 khách hàng, các metric cập nhật nhát
 */
{{
    config(
        materialized = 'table',
        unique_key = 'customer_id',
        sort = [
            'customer_id',
            'identity_id',
            'customer_register_date'
        ]
    )
}}

with customer as (
    select
        *
    from
        {{ ref('int_dim_custormers') }} as ac
    ),
loan as ( --- Tính toán các metric khi KH dùng sản phẩm tín dụng
    select
         customer_id,
         count( distinct loan_id) as loan_count,
         sum(loan_amount) as origin_principal,  --- Tổng tiền gốc giải ngân
         coalesce(sum(unpaid_interest), 0) + coalesce(sum(paid_interest), 0) as total_interest, --- doanh thu lãi dự kiến
         coalesce(sum(paid_interest), 0) as paid_interest, --- doanh thu lãi thực thu
         count(distinct case when status = 'UNPAID' then loan_id end ) unpaid_loan_count,
         sum(case when status = 'UNPAID' then loan_amount end )  unpaid_loan_amount-- Tổng khoản nợ chưa trả
    from {{ ref('int_fact_loans') }} as ac
    {{ dbt_utils.group_by(1) }}
),
saving as ( ----- Các metric KH khi dùng sản phẩm tiết kiệm
     select
         customer_id,
         count( distinct savings_id) as savings_count,
         sum(deposit_amount) as origin_deposit_amount,  --- Tổng tiền gốc giải ngân
         sum(case when status = 'MATURED' then deposit_amount end )  matured_deposit_amount
    from {{ ref('int_fact_savings') }} as ac
    {{ dbt_utils.group_by(1) }}
),
customer_metric as (
    select
        ac.*,
        loan.loan_count,
        loan.origin_principal,
        loan.total_interest,
        loan.paid_interest,
        loan.unpaid_loan_amount,
        loan.unpaid_loan_count,
        saving.savings_count,
        saving.origin_deposit_amount,
        saving.matured_deposit_amount
    from customer as ac
    left join loan  on loan.customer_id = ac.customer_id
    left join saving  on saving.customer_id = ac.customer_id
),
customer_segment as ( --- Dài hạn sẽ dùng mô hình của DS để phân nhóm KH
    select
        customer_metric.*,
        case when customer_id = 'C143' then 'Gold'
             when customer_id = 'C157' then 'Silver'
             when customer_id = 'C200' then 'Copper'
             when (loan_count > 4 and origin_principal > 3000000000) or (savings_count > 3 and origin_deposit_amount > 3000000000) then 'Gold'
             when (loan_count > 2 and origin_principal > 2000000000) or (savings_count > 3 and origin_deposit_amount > 200000000) then 'Silver'
        else 'Copper' end customer_segment
    from customer_metric
)
select
    *
from customer_segment
