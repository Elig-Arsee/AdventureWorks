with cabecalho_pedido_vendas_motivo_vendas as (
    select
        salesorderid as id_pedido
        , salesreasonid as id_motivo_venda
    from {{ source('sales', 'salesorderheadersalesreason') }}
)
    , source_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['id_pedido']) }} as sk_id_pedido
            , {{ dbt_utils.generate_surrogate_key(['id_motivo_venda']) }} as sk_id_motivo_venda
            , id_pedido
            , id_motivo_venda
        from cabecalho_pedido_vendas_motivo_vendas
    )
select *
from source_with_sk
