with territorio_vendas as (
    select
        territoryid as id_territorio
        , name as nome_territorio
        , countryregioncode as codigo_iso_pais_regiao
        , cast(salesytd as float64) as vendas_territorio_acumulado_ano
        , cast(saleslastyear as float64) as vendas_territorio_ano_anterior
        , cast(costytd as float64) as custos_comerciais_territorio_acumulado_ano
        , cast(costlastyear as float64) as custos_comerciais_territorio_ano_anterior
    from {{ source('sales', 'salesterritory') }}
)
    , source_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['id_territorio']) }} as sk_id_territorio
            , {{ dbt_utils.generate_surrogate_key(['codigo_iso_pais_regiao']) }} as sk_codigo_iso_pais_regiao
            , id_territorio
            , codigo_iso_pais_regiao
            , nome_territorio
            , vendas_territorio_acumulado_ano
            , vendas_territorio_ano_anterior
            , custos_comerciais_territorio_acumulado_ano
            , custos_comerciais_territorio_ano_anterior
        from territorio_vendas
    )
select *
from source_with_sk
