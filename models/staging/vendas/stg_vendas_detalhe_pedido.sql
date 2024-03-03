with detalhe_pedido as (
    select
        salesorderdetailid as id_detalhe_pedido
        , salesorderid as id_pedido
        , carriertrackingnumber as numero_rastreamento_remessa
        , orderqty as quantidade_encomendada_produto
        , productid as id_produto
        , specialofferid as codigo_promocional
        , cast(unitprice as float64) as preco_unitario_produto
        , cast(unitpricediscount as float64) as desconto_produto
    from {{ source('sales', 'salesorderdetail') }}
)
    , source_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['id_detalhe_pedido']) }} as sk_id_detalhe_pedido
            , {{ dbt_utils.generate_surrogate_key(['id_pedido']) }} as sk_id_pedido
            , {{ dbt_utils.generate_surrogate_key(['id_produto']) }} as sk_id_produto
            , id_detalhe_pedido
            , id_pedido
            , id_produto
            , numero_rastreamento_remessa
            , quantidade_encomendada_produto
            , codigo_promocional
            , preco_unitario_produto
            , desconto_produto
        from detalhe_pedido
    )
select *
from source_with_sk