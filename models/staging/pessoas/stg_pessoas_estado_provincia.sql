with estado_provincia as (
    select
        stateprovinceid as id_estado_provincia
        , stateprovincecode as codigo_iso_estado_provincia
        , countryregioncode as codigo_iso_pais_regiao
        , case
            when isonlystateprovinceflag = 
                true then 'StateProvinceCode existe'
            when isonlystateprovinceflag =
                false then 'StateProvinceCode indisponível'
        end as status_codigo_estado_provincia
        , name as nome_estado_provincia
        , territoryid as id_territorio
    from {{ source('person', 'stateprovince') }}
)
    , source_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['id_estado_provincia']) }} as sk_id_estado_provincia
            , {{ dbt_utils.generate_surrogate_key(['id_territorio']) }} as sk_id_territorio
            , {{ dbt_utils.generate_surrogate_key(['codigo_iso_estado_provincia']) }} as sk_codigo_iso_estado_provincia
            , {{ dbt_utils.generate_surrogate_key(['codigo_iso_pais_regiao']) }} as sk_codigo_iso_pais_regiao
            , id_estado_provincia
            , id_territorio
            , codigo_iso_estado_provincia
            , codigo_iso_pais_regiao
            , status_codigo_estado_provincia
            , nome_estado_provincia
        from estado_provincia
    )
select *
from source_with_sk