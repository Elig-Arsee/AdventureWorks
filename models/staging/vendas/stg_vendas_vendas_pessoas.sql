with vendedor_vendas as (
    select
        businessentityid as id_entidade_empresarial
        , territoryid as id_territorio
        , cast(salesquota as float64) as projecao_vendas_anuais
        , cast(bonus as float64) as bonus_quando_meta_atingida
        , commissionpct as porcentagem_comissao_recebida
        , cast(salesytd as float64) as total_vendas_ano
        , cast(saleslastyear as float64) as total_vendas_ano_anterior
    from {{ source('sales', 'salesperson') }}
)
    , source_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['id_entidade_empresarial']) }} as sk_id_entidade_empresarial
            , {{ dbt_utils.generate_surrogate_key(['id_territorio']) }} as sk_id_territorio
            , id_entidade_empresarial
            , id_territorio
            , projecao_vendas_anuais
            , bonus_quando_meta_atingida
            , porcentagem_comissao_recebida
            , total_vendas_ano
            , total_vendas_ano_anterior
        from vendedor_vendas
    )
select *
from source_with_sk