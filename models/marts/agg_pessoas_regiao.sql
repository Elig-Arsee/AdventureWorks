with 
    stg_vendas_cabecalho_pedido as (
        select distinct
            sk_id_pedido
            , id_pedido
            , id_vendedor
            , id_territorio
        from {{ ref('stg_vendas_cabecalho_pedido') }}
    )
    , stg_vendas_vendas_pessoas as (
        select 
            id_entidade_empresarial
        from {{ ref('stg_vendas_vendas_pessoas') }}
    )
    , stg_funcionarios as (
        select 
            id_entidade_empresarial
            , id_login_funcionario
            , cargo_funcionario
            , genero_funcionario
            , funcionario_atual
            , funcionario_assalariado
            , horas_ferias_disponiveis
            , horas_licenca_medica_disponiveis
        from {{ ref('stg_funcionarios') }}
    )
    , stg_vendas_territorio as (
        select 
            id_territorio
            , nome_territorio
            , vendas_territorio_acumulado_ano
            , vendas_territorio_ano_anterior
            , custos_comerciais_territorio_acumulado_ano
            , custos_comerciais_territorio_ano_anterior
            , codigo_iso_pais_regiao
        from {{ ref('stg_vendas_territorio') }}
    )
    , stg_pessoas_pais_regiao as (
        select 
            codigo_iso_pais_regiao
            , nome_pais_regiao
        from {{ ref('stg_pessoas_pais_regiao') }}
    )
    , tabela_final as (
        select
            stg_vendas_cabecalho_pedido.sk_id_pedido
            , stg_vendas_cabecalho_pedido.id_pedido
            , stg_vendas_cabecalho_pedido.id_vendedor
            , stg_funcionarios.id_login_funcionario
            , stg_funcionarios.cargo_funcionario
            , stg_funcionarios.genero_funcionario
            , stg_funcionarios.funcionario_atual
            , stg_funcionarios.funcionario_assalariado
            , stg_funcionarios.horas_ferias_disponiveis
            , stg_funcionarios.horas_licenca_medica_disponiveis
            , stg_vendas_cabecalho_pedido.id_territorio
            , stg_vendas_territorio.nome_territorio
            , stg_vendas_territorio.vendas_territorio_acumulado_ano
            , stg_vendas_territorio.vendas_territorio_ano_anterior
            , stg_vendas_territorio.custos_comerciais_territorio_acumulado_ano
            , stg_vendas_territorio.custos_comerciais_territorio_ano_anterior
            , stg_vendas_territorio.codigo_iso_pais_regiao
            , stg_pessoas_pais_regiao.nome_pais_regiao
        from stg_vendas_cabecalho_pedido
        left join stg_vendas_vendas_pessoas
            on stg_vendas_cabecalho_pedido.id_vendedor = stg_vendas_vendas_pessoas.id_entidade_empresarial
        left join stg_funcionarios
            on stg_vendas_vendas_pessoas.id_entidade_empresarial = stg_funcionarios.id_entidade_empresarial
        left join stg_vendas_territorio
            on stg_vendas_cabecalho_pedido.id_territorio = stg_vendas_territorio.id_territorio
        left join stg_pessoas_pais_regiao
            on  stg_vendas_territorio.codigo_iso_pais_regiao = stg_pessoas_pais_regiao.codigo_iso_pais_regiao
        where stg_vendas_cabecalho_pedido.id_vendedor is not null
    )

select *
from tabela_final
