with pessoas as (
    select
        businessentityid as id_entidade_empresarial
        , case 
            when persontype = 'SC'
                then 'Contato da loja'
            when persontype = 'IN'
                then 'Cliente individual (varejo)'
            when persontype = 'SP'
                then 'Vendedor'
            when persontype = 'EM'
                then 'Funcionário (não relacionado a vendas)'
            when persontype = 'VC'
                then 'Contato do fornecedor'
            when persontype = 'GC'
                then 'Contato geral'
            else 'Tipo de pessoa desconhecido'
        end as tipo_pessoa
        , case 
            when namestyle = true
                then 'Ordem estilo ocidental (nome, sobrenome)'
            when namestyle = false
                then 'Ordem de estilo oriental (sobrenome, nome)'
            else 'Valor desconhecido'
        end as estilo_nome_pessoa
        , title as titulo_cortesia_pessoa
        , firstname as primeiro_nome_pessoa
        , middlename as nome_meio_pessoa
        , lastname as ultimo_nome_pessoa
        , concat(
            coalesce(firstname, ''), 
            case when firstname is not null and (middlename is not null or lastname is not null) then ' ' else '' end,
            coalesce(middlename, ''), 
            case when middlename is not null and lastname is not null then ' ' else '' end,
            coalesce(lastname, '')
        ) as nome_completo_pessoa
        , suffix as sufixo_sobrenome_pessoa
        , emailpromotion as email_promocao_pessoa
    from {{ source('person', 'person') }}
)
    , source_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['id_entidade_empresarial']) }} as sk_id_entidade_empresarial
            , id_entidade_empresarial
            , tipo_pessoa
            , estilo_nome_pessoa
            , titulo_cortesia_pessoa
            , primeiro_nome_pessoa
            , ultimo_nome_pessoa
            , nome_completo_pessoa
            , sufixo_sobrenome_pessoa
            , email_promocao_pessoa
        from pessoas
    )
select *
from source_with_sk