with
    stg_vendas_cartaocredito as (
        select
            sk_id_cartao_credito
            , id_cartao_credito
            , tipo_cartao_credito
            , numero_cartao_credito
            , mes_vencimento_cartao_credito
            , ano_validade_cartao_credito
        from {{ ref('stg_vendas_cartaocredito')}}
    )
    , stg_vendas_cabecalho_pedido as (
        select distinct
            sk_id_cartao_credito
            , id_cartao_credito
        from {{ ref('stg_vendas_cabecalho_pedido') }}
    )
    , tabela_final as (
        select
            stg_vendas_cartaocredito.sk_id_cartao_credito
            , stg_vendas_cartaocredito.id_cartao_credito
            , stg_vendas_cartaocredito.tipo_cartao_credito
            , stg_vendas_cartaocredito.numero_cartao_credito
            , stg_vendas_cartaocredito.mes_vencimento_cartao_credito
            , stg_vendas_cartaocredito.ano_validade_cartao_credito 
        from stg_vendas_cartaocredito
        left join stg_vendas_cabecalho_pedido 
            on stg_vendas_cabecalho_pedido.id_cartao_credito = stg_vendas_cartaocredito.id_cartao_credito
    )   
select *
from tabela_final
