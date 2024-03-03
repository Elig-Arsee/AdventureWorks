with cabecalho_pedido_vendas as (
    select
        salesorderid as id_pedido
        , revisionnumber as numero_rastreamento_alteracao_pedido
        , cast(orderdate as timestamp) as data_pedido_venda
        , cast(duedate as timestamp) as data_pedido_devido_cliente
        , cast(shipdate as timestamp) as data_envio_pedido
        , case 
            when status = 1
                then 'Em processo'
            when status = 2
                then 'Aprovado'
            when status = 3
                then 'Pedido em espera'
            when status = 4
                then 'Rejeitado'
            when status = 5
                then 'Enviado'
            when status = 6
                then 'Cancelado'
            else 'Status desconhecido'
        end as status_pedido
        , case
            when onlineorderflag = true
                then 'Pedido feito pelo vendedor'
            when onlineorderflag = false
                then 'Pedido feito online pelo cliente'
            else 'Sem informação'
        end as pedido_online
        , purchaseordernumber as ref_numero_pedido_compra
        , accountnumber as ref_numero_contabilidade_financeira
        , customerid as id_cliente
        , salespersonid as id_vendedor
        , territoryid as id_territorio
        , billtoaddressid as id_endereco_cobranca_cliente
        , shiptoaddressid as id_endereco_entrega_cliente
        , shipmethodid as id_metodo_envio
        , creditcardid as id_cartao_credito
        , creditcardapprovalcode as codigo_aprovacao_cartao_credito
        , currencyrateid as id_taxa_cambio
        , cast(subtotal as float64) as subtotal_vendas
        , cast(taxamt as float64) as valor_imposto
        , cast(freight as float64) as valor_frete
        , totaldue as total_devido_cliente
    from {{ source('sales', 'salesorderheader') }}
)
    , source_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['id_pedido']) }} as sk_id_pedido
            , {{ dbt_utils.generate_surrogate_key(['id_cliente']) }} as sk_id_cliente
            , {{ dbt_utils.generate_surrogate_key(['id_vendedor']) }} as sk_id_vendedor
            , {{ dbt_utils.generate_surrogate_key(['id_territorio']) }} as sk_id_territorio
            , {{ dbt_utils.generate_surrogate_key(['id_endereco_cobranca_cliente']) }} as sk_id_endereco_cobranca_cliente
            , {{ dbt_utils.generate_surrogate_key(['id_endereco_entrega_cliente']) }} as sk_id_endereco_entrega_cliente
            , {{ dbt_utils.generate_surrogate_key(['id_metodo_envio']) }} as sk_id_metodo_envio
            , {{ dbt_utils.generate_surrogate_key(['id_cartao_credito']) }} as sk_id_cartao_credito
            , {{ dbt_utils.generate_surrogate_key(['id_taxa_cambio']) }} as sk_id_taxa_cambio
            , id_pedido
            , data_pedido_venda
            , data_pedido_devido_cliente
            , data_envio_pedido
            , status_pedido
            , pedido_online
            , ref_numero_pedido_compra
            , ref_numero_contabilidade_financeira
            , id_cliente
            , id_vendedor
            , id_territorio
            , id_endereco_cobranca_cliente
            , id_endereco_entrega_cliente
            , id_metodo_envio
            , id_cartao_credito
            , codigo_aprovacao_cartao_credito
            , id_taxa_cambio
            , subtotal_vendas
            , valor_imposto
            , valor_frete
            , total_devido_cliente
        from cabecalho_pedido_vendas
    )
select *
from source_with_sk
