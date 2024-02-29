with producao_produto_subcategoria as (
    select
        productsubcategoryid as id_subcategoria_produto
        , productcategoryid as id_categoria_produto
        , case 
            when name = 'Mountain Bikes'
                then 'Mountain Bikes'
            when name = 'Touring Bikes'
                then 'Bicicletas de Turismo'
            when name = 'Road Bikes'
                then 'Bicicletas de Estrada'
            when name = 'Cranksets'
                then 'Pedivelas'
            when name = 'Pedals'
                then 'Pedais'
            when name = 'Touring Frames'
                then 'Quadros de Turismo'
            when name = 'Wheels'
                then 'Rodas'
            when name = 'Derailleurs'
                then 'Câmbios'
            when name = 'Headsets'
                then 'Caixas de Direção'
            when name = 'Forks'
                then 'Garfos'
            when name = 'Bottom Brackets'
                then 'Movimentos Centrais'
            when name = 'Saddles'
                then 'Selins'
            when name = 'Mountain Frames'
                then 'Quadros de Mountain Bike'
            when name = 'Brakes'
                then 'Freios'
            when name = 'Road Frames'
                then 'Quadros de Bicicleta de Estrada'
            when name = 'Handlebars'
                then 'Guidões'
            when name = 'Chains'
                then 'Correntes'
            when name = 'Vests'
                then 'Coletes'
            when name = 'Socks'
                then 'Meias'
            when name = 'Jerseys'
                then 'Camisas'
            when name = 'Bib-Shorts'
                then 'Bermudas com Alças'
            when name = 'Tights'
                then 'Calças Justas'
            when name = 'Shorts'
                then 'Bermudas'
            when name = 'Gloves'
                then 'Luvas'
            when name = 'Caps'
                then 'Bonés'
            when name = 'Panniers'
                then 'Alforjes'
            when name = 'Bike Stands'
                then 'Suportes de Bicicleta'
            when name = 'Pumps'
                then 'Bombas de Ar'
            when name = 'Bottles and Cages'
                then 'Garrafas e Suportes'
            when name = 'Lights'
                then 'Faróis'
            when name = 'Hydration Packs'
                then 'Mochilas de Hidratação'
            when name = 'Fenders'
                then 'Paralamas'
            when name = 'Tires and Tubes'
                then 'Pneus e Câmaras de Ar'
            when name = 'Bike Racks'
                then 'Suportes de Bicicleta'
            when name = 'Helmets'
                then 'Capacetes'
            when name = 'Locks'
                then 'Travas'
            when name = 'Cleaners'
                then 'Limpadores'
            else 'Categoria desconhecida'
        end as nome_subcategoria_produto
    from {{ source('production', 'productsubcategory') }}
)
    , source_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['id_subcategoria_produto']) }} as sk_id_subcategoria_produto
            , {{ dbt_utils.generate_surrogate_key(['id_categoria_produto']) }} as sk_id_categoria_produto
            , id_subcategoria_produto
            , id_categoria_produto
            , nome_subcategoria_produto
        from producao_produto_subcategoria
    )
select *
from source_with_sk
