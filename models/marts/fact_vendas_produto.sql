WITH
    dim_cartao_credito AS (
        SELECT
            sk_id_cartao_credito,
            id_cartao_credito,
            tipo_cartao_credito,
            numero_cartao_credito,
            mes_vencimento_cartao_credito,
            ano_validade_cartao_credito
        FROM {{ ref('dim_cartao_credito') }}
    ),
    dim_cliente AS (
        SELECT
            sk_id_cliente,
            sk_id_entidade_empresarial,
            sk_id_pessoa,
            sk_id_loja,
            id_cliente,
            id_entidade_empresarial,
            id_pessoa,
            id_loja,
            nome_completo_pessoa,
            nome_loja,
            tipo_pessoa,
            email_promocao_pessoa
        FROM {{ ref('dim_cliente') }}
    ),
    dim_endereco AS (
        SELECT
            sk_id_territorio,
            sk_id_endereco_entrega_cliente,
            id_endereco_entrega_cliente,
            id_territorio,
            codigo_iso_pais_regiao,
            nome_pais_regiao,
            codigo_iso_estado_provincia,
            nome_estado_provincia,
            nome_territorio,
            codigo_postal_endereco,
            cidade_endereco
        FROM {{ ref('dim_endereco') }}
    ),
    dim_motivo_venda AS (
        SELECT
            sk_id_pedido,
            id_pedido,
            sk_id_motivo_venda,
            id_motivo_venda,
            motivo_venda,
            tipo_motivo_venda
        FROM {{ ref('dim_motivo_venda') }}
    ),
    dim_produto AS (
        SELECT
            sk_id_produto,
            sk_id_categoria_produto,
            sk_id_subcategoria_produto,
            id_produto,
            id_categoria_produto,
            id_subcategoria_produto,
            origem_produto,
            nome_categoria_produto,
            nome_subcategoria_produto,
            nome_produto,
            classe_produto,
            custo_padrao_produto,
            preco_venda,
            quantidade_encomendada_produto
        FROM {{ ref('dim_produto') }}
    ),
    stg_vendas_cabecalho_pedido AS (
    SELECT
        vc.sk_id_cartao_credito,
        vc.id_cartao_credito,
        vc.sk_id_cliente,
        vc.id_cliente,
        vc.sk_id_endereco_entrega_cliente,
        vc.id_endereco_entrega_cliente,
        vc.sk_id_pedido,
        vc.id_pedido,
        vc.sk_id_territorio,
        vc.id_territorio,
        dp.sk_id_produto,
        dp.id_produto,
        vc.data_pedido_venda
    FROM {{ ref('stg_vendas_cabecalho_pedido') }} vc
    JOIN {{ ref('stg_vendas_detalhe_pedido') }} dp ON vc.id_pedido = dp.id_pedido
),
fact_vendas_produto AS (
    SELECT
        dim_produto.sk_id_produto,
        dim_produto.id_produto,
        dim_produto.id_categoria_produto,
        dim_produto.id_subcategoria_produto,
        dim_produto.origem_produto,
        dim_produto.nome_categoria_produto,
        dim_produto.nome_subcategoria_produto,
        dim_produto.nome_produto,
        dim_produto.classe_produto,
        dim_produto.custo_padrao_produto,
        dim_produto.preco_venda,
        dim_produto.quantidade_encomendada_produto,
        stg_vendas_cabecalho_pedido.sk_id_cartao_credito,
        stg_vendas_cabecalho_pedido.id_cartao_credito,
        stg_vendas_cabecalho_pedido.sk_id_cliente,
        stg_vendas_cabecalho_pedido.id_cliente,
        stg_vendas_cabecalho_pedido.sk_id_endereco_entrega_cliente,
        stg_vendas_cabecalho_pedido.id_endereco_entrega_cliente,
        stg_vendas_cabecalho_pedido.sk_id_pedido,
        stg_vendas_cabecalho_pedido.id_pedido,
        stg_vendas_cabecalho_pedido.sk_id_territorio,
        stg_vendas_cabecalho_pedido.id_territorio,
        stg_vendas_cabecalho_pedido.data_pedido_venda,
        dim_cliente.nome_completo_pessoa,
        dim_cliente.nome_loja,
        dim_cliente.tipo_pessoa,
        dim_cliente.email_promocao_pessoa,
        dim_endereco.codigo_iso_pais_regiao,
        dim_endereco.nome_pais_regiao,
        dim_endereco.codigo_iso_estado_provincia,
        dim_endereco.nome_estado_provincia,
        dim_endereco.nome_territorio,
        dim_endereco.codigo_postal_endereco,
        dim_endereco.cidade_endereco,
        dim_motivo_venda.sk_id_motivo_venda,
        dim_motivo_venda.id_motivo_venda,
        dim_motivo_venda.motivo_venda,
        dim_motivo_venda.tipo_motivo_venda
    FROM stg_vendas_cabecalho_pedido
    LEFT JOIN dim_produto ON stg_vendas_cabecalho_pedido.id_produto = dim_produto.id_produto
    LEFT JOIN dim_cliente ON stg_vendas_cabecalho_pedido.id_cliente = dim_cliente.id_cliente
    LEFT JOIN dim_endereco ON stg_vendas_cabecalho_pedido.id_endereco_entrega_cliente = dim_endereco.id_endereco_entrega_cliente
    LEFT JOIN dim_motivo_venda ON stg_vendas_cabecalho_pedido.id_pedido = dim_motivo_venda.id_pedido
)
select *
from fact_vendas_produto
