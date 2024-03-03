with producao_produto_categoria as (
    select
        productcategoryid as id_categoria_produto
        , case 
            when name = 'Components'
                then 'Componentes'
            when name = 'Clothing'
                then 'Vestuário'
            when name = 'Accessories'
                then 'Acessórios'
            when name = 'Bikes'
                then 'Bicicletas'
            else 'Categoria desconhecida'
        end as nome_categoria_produto
    from {{ source('production', 'productcategory') }}
)
    , source_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['id_categoria_produto']) }} as sk_id_categoria_produto
            , id_categoria_produto
            , nome_categoria_produto
        from producao_produto_categoria
    )
select *
from source_with_sk
