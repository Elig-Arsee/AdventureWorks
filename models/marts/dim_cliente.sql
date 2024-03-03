with 
    stg_vendas_clientes as (
        select
            sk_id_cliente
            , sk_id_pessoa
            , sk_id_loja
            , id_cliente
            , id_pessoa
            , id_loja
        from {{ ref('stg_vendas_clientes') }}
    )
    , stg_pessoas_pessoas as (
        select
            sk_id_entidade_empresarial
            , id_entidade_empresarial
            , nome_completo_pessoa
            , tipo_pessoa
            , email_promocao_pessoa
        from {{ ref('stg_pessoas_pessoas') }}
    )
    , stg_vendas_loja as (
        select 
            sk_id_entidade_empresarial
            , sk_id_vendedor
            , id_entidade_empresarial
            , nome_loja
        from {{ ref('stg_vendas_loja') }}
    )
    , tabela_final as (
        select
            stg_pessoas_pessoas.sk_id_entidade_empresarial
            , stg_vendas_clientes.sk_id_pessoa
            , stg_vendas_clientes.sk_id_loja
            , stg_vendas_clientes.sk_id_cliente
            , stg_vendas_clientes.id_cliente
            , stg_vendas_loja.sk_id_vendedor
            , stg_pessoas_pessoas.id_entidade_empresarial
            , stg_vendas_clientes.id_pessoa
            , stg_vendas_clientes.id_loja
            , stg_pessoas_pessoas.nome_completo_pessoa            
            , stg_vendas_loja.nome_loja
            , stg_pessoas_pessoas.tipo_pessoa
            , stg_pessoas_pessoas.email_promocao_pessoa
        from stg_vendas_clientes 
        left join stg_pessoas_pessoas
            on stg_vendas_clientes.id_pessoa = stg_pessoas_pessoas.id_entidade_empresarial
        left join stg_vendas_loja
            on stg_vendas_clientes.id_loja = stg_vendas_loja.id_entidade_empresarial
    )
select *
from tabela_final