with 
    stg_vendas_detalhe_pedido as (
        select
            sk_id_produto
            , id_produto
            , quantidade_encomendada_produto
        from {{ ref('stg_vendas_detalhe_pedido') }}
    )
    , stg_producao_produto as (
        select
            sk_id_produto
            , sk_id_subcategoria_produto
            , id_produto
            , id_subcategoria_produto
            , nome_produto
            , custo_padrao_produto
            , preco_venda
            , data_produto_disponivel_venda
            , data_produto_indisponivel
            , classe_produto
            , estilo_produto
            , origem_produto
        from {{ ref('stg_producao_produto') }}
    )
    , stg_producao_produto_categoria as (
        select
            sk_id_categoria_produto
            , id_categoria_produto
            , nome_categoria_produto
        from {{ ref('stg_producao_produto_categoria') }}
    )
    , stg_producao_produto_subcategoria as (
        select
            sk_id_subcategoria_produto
            , sk_id_categoria_produto
            , id_subcategoria_produto
            , id_categoria_produto
            , nome_subcategoria_produto
        from {{ ref('stg_producao_produto_subcategoria') }}
    )
    , tabela_final as (
        select
            stg_vendas_detalhe_pedido.sk_id_produto
            , stg_vendas_detalhe_pedido.quantidade_encomendada_produto
            , stg_producao_produto_categoria.sk_id_categoria_produto
            , stg_producao_produto.sk_id_subcategoria_produto
            , stg_vendas_detalhe_pedido.id_produto
            , stg_producao_produto_categoria.id_categoria_produto
            , stg_producao_produto.id_subcategoria_produto
            , stg_producao_produto_categoria.nome_categoria_produto
            , stg_producao_produto_subcategoria.nome_subcategoria_produto
            , stg_producao_produto.nome_produto
            , stg_producao_produto.classe_produto
            , stg_producao_produto.origem_produto
            , stg_producao_produto.custo_padrao_produto
            , stg_producao_produto.preco_venda
            , stg_producao_produto.data_produto_disponivel_venda
            , stg_producao_produto.data_produto_indisponivel
        from stg_vendas_detalhe_pedido 
        left join stg_producao_produto 
            on stg_vendas_detalhe_pedido.id_produto = stg_producao_produto.id_produto
        left join stg_producao_produto_subcategoria 
            on stg_producao_produto.id_subcategoria_produto = stg_producao_produto_subcategoria.id_subcategoria_produto
        left join stg_producao_produto_categoria
            on stg_producao_produto_subcategoria.id_categoria_produto = stg_producao_produto_categoria.id_categoria_produto    
    )
select *
from tabela_final