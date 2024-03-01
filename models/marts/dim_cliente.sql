with 
    stg_vendas_cabecalho_pedido as (
        select distinct
          , sk_id_cliente
          id_cliente
        from {{ ref('stg_vendas_cabecalho_pedido') }}
    )
    , stg_vendas_clientes as (
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
            , person_type
            , email_promocao_pessoa
        from {{ ref('stg_pessoas_pessoas') }}
    )
    , stg_vendas_loja as (
        select 
            sk_id_entidade_empresarial
            , sk_id_vendedor
            , id_entidade_empresarial
            , id_vendedor
            , name_store
        from {{ ref('stg_vendas_loja') }}
    )
    , tabela_final as (--preciso ajustar essa tabela toda, mas daqui pra frente principalmente
        select
            stg_vendas_cabecalho_pedido.sk_id_cliente --daqui pra frente é só pra trás
            , stg_vendas_clientes.id_cliente
            , stg_pessoas_pessoas.nome_completo_pessoa
            , stg_pessoas_pessoas.tipo_pessoa
            , stg_pessoas_pessoas.sk_id_pessoa
            , stg_pessoas_pessoas.sk_id_loja
            , stg_pessoas_pessoas.id_cliente
            , stg_pessoas_pessoas.id_pessoa
            , stg_pessoas_pessoas.id_loja
        from stg_vendas_cabecalho_pedido 
        left join stg_vendas_clientes 
            on stg_vendas_cabecalho_pedido.id_cliente = stg_vendas_clientes.id_cliente
         left join stg_pessoas_pessoas
            on stg_vendas_clientes.id_cliente = stg_pessoas_pessoas.id_entidade_empresarial
        left join stg_vendas_loja
            on stg_vendas_clientes.id_loja = stg_vendas_loja.id_entidade_empresarial    
    )
select *
from tabela_final