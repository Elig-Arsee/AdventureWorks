with motivo_venda as (
    select
        salesreasonid as id_motivo_venda
        , case
            when name = 'Review'
                then 'Análise'
            when name = 'Manufacturer'
                then 'Fabricante'
            when name = 'Other'
                then 'Outro'
            when name = 'Quality'
                then 'Qualidade'
            when name = 'Price'
                then 'Preço'
            when name = 'Television Advertisement'
                then 'Anúncio de televisão'
            when name = 'Demo Event'
                then 'Evento de demonstração'
            when name = 'Magazine Advertisement'
                then 'Anúncio de revista'
            when name = 'Sponsorship'
                then 'Patrocínio'
            when name = 'On Promotion'
                then 'Promoção'
            else 'Sem informação'
        end as motivo_venda
        , case
            when reasontype = 'Other'
                then 'Outro'
            when reasontype = 'Marketing'
                then 'Marketing'
            when reasontype = 'Promotion'
                then 'Promoção'
            else 'Sem informação'
        end as tipo_motivo_venda
    from {{ source('sales', 'salesreason') }}
)
    , source_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['id_motivo_venda']) }} as sk_id_motivo_venda
            , id_motivo_venda
            , motivo_venda
            , tipo_motivo_venda
        from motivo_venda
    )
select *
from source_with_sk
