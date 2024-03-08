with 
    tabela_ds as (
        select distinct
            nome_categoria_produto
            , nome_subcategoria_produto
            , nome_produto
            , quantidade_encomendada_produto
            , data_pedido_venda
            , nome_completo_pessoa
            , nome_loja
            , tipo_pessoa
            , nome_pais_regiao
            , nome_estado_provincia
        from {{ ref('fact_vendas_produto') }}
    )
select *
from tabela_ds
