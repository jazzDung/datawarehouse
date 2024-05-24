with source as (
      select * from {{ source('vpb_branch', 'branch') }}
),
renamed as (
    select
        {{ adapter.quote("region") }},
        {{ adapter.quote("province") }},
        {{ adapter.quote("branch_name") }},
        {{ adapter.quote("branch_id") }},
        {{ adapter.quote("address") }}

    from source
)
select * from renamed
  