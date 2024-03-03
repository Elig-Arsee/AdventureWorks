with 
    stg_vendas_cabecalho_pedido_motivo_venda as (
        select
            sk_id_pedido
            , sk_id_motivo_venda
            , id_pedido
            , id_motivo_venda
        from {{ ref('stg_vendas_cabecalho_pedido_motivo_venda') }}
    )
    , stg_vendas_motivos as (
        select
            sk_id_motivo_venda
            , id_motivo_venda
            , motivo_venda
            , tipo_motivo_venda
        from {{ ref('stg_vendas_motivos') }}
    )
    , tabela_final as (
        select
            stg_vendas_cabecalho_pedido_motivo_venda.sk_id_pedido
            , stg_vendas_cabecalho_pedido_motivo_venda.sk_id_motivo_venda
            , stg_vendas_cabecalho_pedido_motivo_venda.id_pedido
            , stg_vendas_cabecalho_pedido_motivo_venda.id_motivo_venda
            , stg_vendas_motivos.motivo_venda
            , stg_vendas_motivos.tipo_motivo_venda
        from stg_vendas_cabecalho_pedido_motivo_venda 
        left join stg_vendas_motivos 
            on stg_vendas_cabecalho_pedido_motivo_venda.sk_id_motivo_venda = stg_vendas_motivos.sk_id_motivo_venda
    )
select *
from tabela_final