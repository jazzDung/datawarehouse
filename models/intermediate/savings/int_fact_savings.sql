/* Mô tả: Một dòng là 1 thông tin về khoản gửi tiết kiệm của KH 1 một ngày
 */
{{
    config(
    materialized = 'view',
    unique_key = 'savings_id',
    sort = [
        'savings_id',
        'account_id',
        'created_at',
        'customer_id'
    ]
    )
}}

with source as (
    select
        *
    from
        {{ ref('stg_vpb_savings_savings_account') }} as ac
)
select
    ac.savings_id,
    ac.product_id,
    pr.product_name,
    pr.interest_rate,
    pr.promotion,
    ac.customer_id,
    dc.full_name,
    dc.age,
    dc.gender,
    ac.deposit_amount ,
    ac.opening_date,
    ac.maturity_date,
    ac.status,
    ac.created_at,
    ac.updated_at
from source ac
left join {{ ref('int_dim_custormers') }} as dc  on ac.customer_id = dc.customer_id
left join {{ ref('stg_vpb_savings_savings_product') }} as  pr on  pr.product_id = ac.product_id