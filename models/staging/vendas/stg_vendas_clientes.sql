with vendas_clientes as (
    select
        customerid as id_cliente
        , personid as id_pessoa
        , storeid as id_loja
        , territoryid as id_territorio
    from {{ source('sales', 'customer') }}
)
    , source_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['id_cliente']) }} as sk_id_cliente
            , {{ dbt_utils.generate_surrogate_key(['id_pessoa']) }} as sk_id_pessoa
            , {{ dbt_utils.generate_surrogate_key(['id_loja']) }} as sk_id_loja
            , {{ dbt_utils.generate_surrogate_key(['id_territorio']) }} as sk_id_territorio
            , id_cliente
            , id_pessoa
            , id_loja
            , id_territorio
        from vendas_clientes
    )
select *
from source_with_sk