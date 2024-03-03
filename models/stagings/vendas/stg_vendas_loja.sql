with loja as (
    select
        businessentityid as id_entidade_empresarial
        , name as nome_loja
        , salespersonid as id_vendedor
    from {{ source('sales', 'store') }}
)
    , source_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['id_entidade_empresarial']) }} as sk_id_entidade_empresarial
            , {{ dbt_utils.generate_surrogate_key(['id_vendedor']) }} as sk_id_vendedor
            , id_entidade_empresarial
            , id_vendedor
            , nome_loja
        from loja
    )
select *
from source_with_sk