with endereco_pessoas as (
    select
        addressid as id_endereco
        , addressline1 as primeira_linha_endereco
        , addressline2 as segunda_linha_endereco
        , city as cidade_endereco
        , stateprovinceid as id_estado_provincia
        , postalcode as codigo_postal_endereco
        , spatiallocation as latitude_longitude_endereco
    from {{ source('person', 'address') }}
)
    , source_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['id_endereco']) }} as sk_id_endereco
            , {{ dbt_utils.generate_surrogate_key(['id_estado_provincia']) }} as sk_id_estado_provincia
            , id_endereco
            , id_estado_provincia
            , primeira_linha_endereco
            , segunda_linha_endereco
            , cidade_endereco
            , codigo_postal_endereco
            , latitude_longitude_endereco
        from endereco_pessoas
    )
select *
from source_with_sk
