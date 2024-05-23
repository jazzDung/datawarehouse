/* Mô tả: Một dòng là 1 chi nhánh VP bank
 */

{{
    config(
        materialized = 'view',
        unique_key = 'atm_id',
        sort = [
            'atm_id',
            'phone_number'
        ]
    )
}}

with source as (
      select * from {{ source('vpb_branch', 'atm') }}
),
renamed as (
    select
        {{ adapter.quote("atm_id") }}::text ,
        {{ adapter.quote("name") }}::text ,
        {{ adapter.quote("is_branch") }}::boolean ,
        {{ adapter.quote("is_atm") }},
        {{ adapter.quote("is_cdm") }},
        {{ adapter.quote("is_atm_247") }},
        {{ adapter.quote("atm_247_label") }},
        {{ adapter.quote("is_household") }},
        {{ adapter.quote("is_sme") }},
        {{ adapter.quote("address") }},
        {{ adapter.quote("latitude") }},
        {{ adapter.quote("longitude") }},
        {{ adapter.quote("phone_number") }}

    from source
)
select * from renamed
  