with cartao_credito_vendedor as (
    select
        businessentityid as id_entidade_empresarial
        , creditcardid as id_cartao_credito
    from {{ source('sales', 'personcreditcard') }}
)
    , source_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['id_entidade_empresarial']) }} as sk_id_entidade_empresarial
            , {{ dbt_utils.generate_surrogate_key(['id_cartao_credito']) }} as sk_id_cartao_credito
            , id_entidade_empresarial
            , id_cartao_credito
        from cartao_credito_vendedor
    )
select *
from source_with_sk
