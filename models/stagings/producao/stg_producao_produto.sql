with producao_produto as (
    select
        productid as id_produto
        , name as nome_produto
        , productnumber as identificacao_exclusiva_produto
        , case 
            when makeflag = true
                then 'O produto é adquirido'
            when makeflag = false
                then 'O produto é fabricado'
            else 'Valor desconhecido'
        end as origem_produto
        , case 
            when finishedgoodsflag = true
                then 'Sim'
            when finishedgoodsflag = false
                then 'Não'
            else 'Valor desconhecido'
        end as produto_vendavel
        , color as cor_produto
        , safetystocklevel as quantidade_minima_estoque
        , reorderpoint as nivel_estoque_aciona_compra_servico
        , cast(standardcost as float64) as custo_padrao_produto
        , cast(listprice as float64) as preco_venda
        , size as tamanho_produto
        , daystomanufacture as dias_producao_produto
        , case
            when productline = 'R'
                then 'Estrada'
            when productline = 'M'
                then 'Montanha'
            when productline = 'T'
                then 'Touring'
            when productline = 'S'
                then 'Padrão'
            else 'Sem informação'
        end as linha_produto
        , case
            when class = 'H'
                then 'Alta'
            when class = 'M'
                then 'Média'
            when class = 'L'
                then 'Baixa'
            else 'Sem informação'
        end as classe_produto
        , case
            when style = 'W'
                then 'Feminino'
            when style = 'M'
                then 'Masculino'
            when style = 'U'
                then 'Universal'
            else 'Sem informação'
        end as estilo_produto
        , productsubcategoryid as id_subcategoria_produto
        , productmodelid as id_modelo_produto
        , cast(sellstartdate as timestamp) as data_produto_disponivel_venda
        , cast(sellenddate as timestamp) as data_produto_indisponivel
    from {{ source('production', 'product') }}
)
    , source_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['id_produto']) }} as sk_id_produto
            , {{ dbt_utils.generate_surrogate_key(['id_subcategoria_produto']) }} as sk_id_subcategoria_produto
            , {{ dbt_utils.generate_surrogate_key(['id_modelo_produto']) }} as sk_id_modelo_produto
            , id_produto
            , id_subcategoria_produto
            , id_modelo_produto
            , nome_produto
            , identificacao_exclusiva_produto
            , origem_produto
            , produto_vendavel
            , cor_produto
            , quantidade_minima_estoque
            , nivel_estoque_aciona_compra_servico
            , custo_padrao_produto
            , preco_venda
            , tamanho_produto
            , dias_producao_produto
            , linha_produto
            , classe_produto
            , estilo_produto
            , data_produto_disponivel_venda
            , data_produto_indisponivel
            from producao_produto
    )   
select *
from source_with_sk