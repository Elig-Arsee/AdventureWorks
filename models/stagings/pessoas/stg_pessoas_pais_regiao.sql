with pais_regiao as (
    select
        countryregioncode as codigo_iso_pais_regiao
        , name as nome_pais_regiao
    from {{ source('person', 'countryregion') }}
)
    , source_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['codigo_iso_pais_regiao']) }} as sk_codigo_iso_pais_regiao
            , codigo_iso_pais_regiao
            , nome_pais_regiao
        from pais_regiao
    )
select *
from source_with_sk
