{{
    config(
    materialized = 'incremental',
    unique_key = 'branch_id',
    sort = [
        'branch_id',
        'branch_name'
    ],
    sort_type = 'interleaved'
    )
}}

with source as (
      select * from {{ source('vpb_branch', 'branch') }}
),

renamed as (
    select
        {{ adapter.quote("region") }}::text ,
        {{ adapter.quote("province") }}::text ,
        {{ adapter.quote("branch_name") }}::text ,
        {{ adapter.quote("branch_id") }}::text ,
        {{ adapter.quote("address") }}::text

    from source
)
select * from renamed
  