classDiagram
    class FACT_VENDAS_PEDIDO {
        sk_id_pedido       
        sk_id_loja
        sk_id_territorio
        sk_id_vendedor
        sk_id_pessoa
        sk_id_endereco_cobranca_cliente
        sk_id_endereco_entrega_cliente
        sk_id_metodo_envio
        sk_id_cartao_credito
        id_pedido
        id_loja
        id_territorio
        id_vendedor
        id_pessoa
        id_endereco_cobranca_cliente
        id_endereco_entrega_cliente
        id_metodo_envio
        id_cartao_credito
        id_entidade_empresarial
        dim_cliente_id_cliente
        stg_vendas_cabecalho_pedido_sk_id_cliente
        pedido_online
        status_pedido
        nome_loja
        tipo_cartao_credito
        numero_cartao_credito
        nome_completo_pessoa
        tipo_pessoa
        email_promocao_pessoa
        data_pedido_venda
        data_envio_pedido
        subtotal_vendas
        valor_imposto
        valor_frete
        total_devido_cliente
    }
    class FACT_VENDAS_PRODUTO {
        sk_id_produto
        sk_id_pedido
        sk_id_territorio
        sk_id_cliente
        sk_id_endereco_entrega_cliente
        sk_id_cartao_credito
        sk_id_motivo_venda
        id_produto
        id_pedido
        id_territorio
        id_cliente
        id_endereco_entrega_cliente
        id_cartao_credito
        id_motivo_venda
        id_categoria_produto
        id_subcategoria_produto
        nome_produto
        nome_categoria_produto
        nome_subcategoria_produto
        origem_produto
        classe_produto
        custo_padrao_produto
        preco_venda
        nome_pais_regiao
        codigo_iso_pais_regiao
        nome_estado_provincia
        codigo_iso_estado_provincia
        cidade_endereco
        codigo_postal_endereco
        nome_territorio
        nome_loja
        nome_completo_pessoa
        tipo_pessoa
        email_promocao_pessoa
        motivo_venda
        tipo_motivo_venda
    }
    class DIM_CARTAO_CREDITO {
        sk_id_cartao_credito
        id_cartao_credito
        tipo_cartao_credito
        numero_cartao_credito
        mes_vencimento_cartao_credito
        ano_validade_cartao_credito
    }
    class DIM_CLIENTE {
        sk_id_entidade_empresarial
        sk_id_cliente
        sk_id_vendedor
        sk_id_loja
        sk_id_pessoa
        id_entidade_empresarial
        id_cliente
        id_loja
        id_pessoa
        nome_completo_pessoa
        nome_loja
        tipo_pessoa
        email_promocao_pessoa
    }
    class DIM_ENDERECO {
        sk_id_territorio
        sk_codigo_iso_pais_regiao
        sk_codigo_iso_estado_provincia
        sk_id_endereco_entrega_cliente
        id_territorio
        id_endereco_entrega_cliente
        nome_territorio
        nome_pais_regiao
        codigo_iso_pais_regiao
        nome_estado_provincia
        codigo_iso_estado_provincia
        codigo_postal_endereco
        cidade_endereco
    }
    class DIM_MOTIVO_VENDA {
        sk_id_pedido
        sk_id_motivo_venda
        id_pedido
        id_motivo_venda
        motivo_venda
        tipo_motivo_venda
    }
    class DIM_PRODUTO {
        sk_id_produto
        sk_id_categoria_produto
        sk_id_subcategoria_produto
        id_produto
        id_categoria_produto
        id_subcategoria_produto
        nome_produto
        nome_categoria_produto
        nome_subcategoria_produto    
        classe_produto
        origem_produto
        custo_padrao_produto
        preco_venda
        data_produto_disponivel_venda
        data_produto_indisponivel
    }

    FACT_VENDAS_PEDIDO --> DIM_CLIENTE
    FACT_VENDAS_PEDIDO --> DIM_ENDERECO
    FACT_VENDAS_PEDIDO --> DIM_CARTAO_CREDITO
    FACT_VENDAS_PEDIDO --> DIM_MOTIVO_VENDA
    FACT_VENDAS_PRODUTO --> DIM_MOTIVO_VENDA
    FACT_VENDAS_PRODUTO --> DIM_ENDERECO
    FACT_VENDAS_PRODUTO --> DIM_CARTAO_CREDITO
    FACT_VENDAS_PRODUTO --> DIM_PRODUTO
