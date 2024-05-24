/* mô tả: Một dòng là thông tin chi tiết về 1 tiểu khoản của KH, và các metric cập nhật mới nhất về tiểu khoản
 */
{{
    config(
        materialized = 'table',
        unique_key = 'account_id',
        sort = [
            'account_id',
            'date_opened'
        ]
    )
}}

select
    *
from {{ ref('int_dim_accounts') }} as ac
