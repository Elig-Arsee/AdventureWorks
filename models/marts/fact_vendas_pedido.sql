with
    dim_pagamento_cartao_credito as (
        select
            dim_cartao_credito.sk_id_cartao_credito
            , dim_cartao_credito.id_cartao_credito
            , dim_cartao_credito.tipo_cartao_credito
            , dim_cartao_credito.numero_cartao_credito
        from {{ ref('dim_cartao_credito') }}
    )
    , dim_cliente as (
        select
            dim_cliente.sk_id_entidade_empresarial
            , dim_cliente.sk_id_cliente as dim_cliente_sk_id_cliente
            , dim_cliente.sk_id_pessoa
            , dim_cliente.sk_id_loja
            , dim_cliente.id_entidade_empresarial
            , dim_cliente.id_cliente as dim_cliente_id_cliente
            , dim_cliente.id_pessoa
            , dim_cliente.id_loja
            , dim_cliente.nome_completo_pessoa
            , dim_cliente.nome_loja
            , dim_cliente.tipo_pessoa
            , dim_cliente.email_promocao_pessoa
        from {{ ref('dim_cliente') }}
    )
    , dim_endereco as (
        select
            dim_endereco.sk_id_endereco_entrega_cliente
            , dim_endereco.sk_id_territorio
            , dim_endereco.sk_codigo_iso_estado_provincia
            , dim_endereco.sk_codigo_iso_pais_regiao
            , dim_endereco.id_endereco_entrega_cliente
            , dim_endereco.id_territorio
            , dim_endereco.codigo_iso_pais_regiao
            , dim_endereco.nome_pais_regiao
            , dim_endereco.codigo_iso_estado_provincia
            , dim_endereco.nome_estado_provincia
            , dim_endereco.nome_territorio
            , dim_endereco.codigo_postal_endereco
            , dim_endereco.cidade_endereco
        from {{ ref('dim_endereco') }}
    )
    , dim_motivo_venda as (
        select
            dim_motivo_venda.sk_id_pedido
            , dim_motivo_venda.sk_id_motivo_venda
            , dim_motivo_venda.id_pedido
            , dim_motivo_venda.id_motivo_venda
            , dim_motivo_venda.motivo_venda
            , dim_motivo_venda.tipo_motivo_venda
        from {{ ref('dim_motivo_venda') }}
    )
    , tabela_final as (
        select
            dim_pagamento_cartao_credito.tipo_cartao_credito
            , dim_pagamento_cartao_credito.numero_cartao_credito
            , dim_cliente.sk_id_pessoa
            , dim_cliente.sk_id_loja
            , dim_cliente.id_entidade_empresarial
            , dim_cliente.dim_cliente_id_cliente
            , dim_cliente.id_pessoa
            , dim_cliente.id_loja
            , dim_cliente.nome_completo_pessoa
            , dim_cliente.nome_loja
            , dim_cliente.tipo_pessoa
            , dim_cliente.email_promocao_pessoa
            , stg_vendas_cabecalho_pedido.sk_id_pedido
            , stg_vendas_cabecalho_pedido.sk_id_cliente as stg_vendas_cabecalho_pedido_sk_id_cliente
            , stg_vendas_cabecalho_pedido.sk_id_vendedor
            , stg_vendas_cabecalho_pedido.sk_id_territorio
            , stg_vendas_cabecalho_pedido.sk_id_endereco_cobranca_cliente
            , stg_vendas_cabecalho_pedido.sk_id_endereco_entrega_cliente
            , stg_vendas_cabecalho_pedido.sk_id_metodo_envio
            , stg_vendas_cabecalho_pedido.sk_id_cartao_credito
            , stg_vendas_cabecalho_pedido.id_pedido
            , stg_vendas_cabecalho_pedido.data_pedido_venda
            , stg_vendas_cabecalho_pedido.data_envio_pedido
            , stg_vendas_cabecalho_pedido.status_pedido
            , stg_vendas_cabecalho_pedido.pedido_online
            , stg_vendas_cabecalho_pedido.id_vendedor
            , stg_vendas_cabecalho_pedido.id_territorio
            , stg_vendas_cabecalho_pedido.id_endereco_cobranca_cliente
            , stg_vendas_cabecalho_pedido.id_endereco_entrega_cliente
            , stg_vendas_cabecalho_pedido.id_metodo_envio
            , stg_vendas_cabecalho_pedido.id_cartao_credito
            , stg_vendas_cabecalho_pedido.subtotal_vendas
            , stg_vendas_cabecalho_pedido.valor_imposto
            , stg_vendas_cabecalho_pedido.valor_frete
            , stg_vendas_cabecalho_pedido.total_devido_cliente
        from {{ ref('stg_vendas_cabecalho_pedido') }}
        inner join dim_pagamento_cartao_credito
            on stg_vendas_cabecalho_pedido.id_cartao_credito = dim_pagamento_cartao_credito.id_cartao_credito
            and stg_vendas_cabecalho_pedido.sk_id_cartao_credito = dim_pagamento_cartao_credito.sk_id_cartao_credito
        inner join dim_cliente
            on stg_vendas_cabecalho_pedido.id_cliente = dim_cliente.dim_cliente_id_cliente
            and stg_vendas_cabecalho_pedido.sk_id_cliente = dim_cliente.dim_cliente_sk_id_cliente
        inner join dim_endereco
            on stg_vendas_cabecalho_pedido.id_endereco_entrega_cliente = dim_endereco.id_endereco_entrega_cliente
            and stg_vendas_cabecalho_pedido.sk_id_endereco_entrega_cliente = dim_endereco.sk_id_endereco_entrega_cliente
        inner join dim_motivo_venda
            on stg_vendas_cabecalho_pedido.id_pedido = dim_motivo_venda.id_pedido
            and stg_vendas_cabecalho_pedido.sk_id_pedido = dim_motivo_venda.sk_id_pedido
    )
select *
from tabela_final
