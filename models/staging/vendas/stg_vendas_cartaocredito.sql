with vendas_cartao_credito as (
    select
        creditcardid as id_cartao_credito
        , cardtype as tipo_cartao_credito
        , cardnumber as numero_cartao_credito
        , expmonth as mes_vencimento_cartao_credito
        , expyear as ano_validade_cartao_credito
    from {{ source('sales', 'creditcard') }}
)
    , source_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['id_cartao_credito']) }} as sk_id_cartao_credito
        , id_cartao_credito
        , tipo_cartao_credito
        , numero_cartao_credito
        , mes_vencimento_cartao_credito
        , ano_validade_cartao_credito
        from vendas_cartao_credito
    )
select *
from source_with_sk