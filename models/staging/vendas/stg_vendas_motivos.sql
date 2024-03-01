with motivo_venda as (
    select
        salesreasonid as id_motivo_venda
        , case
            when reasontype = 'Other'
                then 'Outro'
            when reasontype = 'Marketing'
                then 'Marketing'
            when reasontype = 'Promotion'
                then 'Promoção'
            else 'Sem informação'
        end as tipo_motivo_venda
        , cast(salesreason.name as string) as motivo_vendas
    from {{ source('sales', 'salesreason') }}
)
    , source_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['id_motivo_venda']) }} as sk_id_motivo_venda
            , id_motivo_venda
            , case
            when motivo_vendas = 'Review'
                then 'Análise'
            when motivo_vendas = 'Manufacturer'
                then 'Fabricante'
            when motivo_vendas =  'Other'
                then 'Outro'
            when motivo_vendas =  'Quality'
                then 'Qualidade'
            when motivo_vendas =  'Price'
                then 'Preço'
            when motivo_vendas =  'Television Advertisement'
                then 'Anúncio de televisão'
            when motivo_vendas =  'Demo Event'
                then 'Evento de demonstração'
            when motivo_vendas =  'Magazine Advertisement'
                then 'Anúncio de revista'
            when motivo_vendas =  'Sponsorship'
                then 'Patrocínio'
            when motivo_vendas =  'On Promotion'
                then 'Promoção'
            else 'Sem informação'
        end as motivo_venda
            , tipo_motivo_venda
        from motivo_venda
    )
select *
from source_with_sk
