with 
    stg_vendas_detalhe_pedido as (
        select distinct
            sk_id_produto
            , id_produto
        from {{ ref('stg_vendas_detalhe_pedido') }}
    )
    , stg_producao_produto as (
        select
            sk_id_produto
            , sk_id_subcategoria_produto
            , nome_produto
            , custo_padrao_produto
            , preco_venda
            , data_produto_disponivel_venda
            , data_produto_indisponivel
        from {{ ref('stg_producao_produto') }}
    )
    , tabela_final as (
        select
            stg_vendas_detalhe_pedido.sk_id_produto
            , stg_vendas_detalhe_pedido.id_produto
            , stg_producao_produto.nome_produto
            , stg_producao_produto.custo_padrao_produto
            , stg_producao_produto.preco_venda
        from stg_vendas_detalhe_pedido 
        left join stg_producao_produto on stg_vendas_detalhe_pedido.sk_id_produto = stg_producao_produto.sk_id_produto
    )
select *
from tabela_final