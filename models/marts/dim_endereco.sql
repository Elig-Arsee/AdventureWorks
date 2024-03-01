with 
    stg_vendas_cabecalho_pedido as (
        select distinct
            sk_id_endereco_entrega_cliente
            , sk_id_territorio
            , id_endereco_entrega_cliente
            , id_territorio
        from {{ ref('stg_vendas_cabecalho_pedido') }}
    )
    , stg_pessoas_endereco as (
        select
            sk_id_endereco
            , sk_id_estado_provincia
            , id_endereco
            , id_estado_provincia
            , cidade_endereco
            , codigo_postal_endereco
            , latitude_longitude_endereco
        from {{ ref('stg_pessoas_endereco') }}
    )
    , stg_pessoas_estado_provincia as (
        select
            sk_id_estado_provincia
            , sk_codigo_iso_estado_provincia
            , sk_codigo_iso_pais_regiao
            , id_estado_provincia
            , codigo_iso_estado_provincia
            , codigo_iso_pais_regiao
            , nome_estado_provincia
        from {{ ref('stg_pessoas_estado_provincia') }}
    )
    , stg_vendas_territorio as (
        select
            sk_id_territorio
            , sk_codigo_iso_pais_regiao
            , id_territorio
            , codigo_iso_pais_regiao
            , nome_territorio
        from {{ ref('stg_vendas_territorio') }}
    )
    , stg_pessoas_pais_regiao as (
        select
            sk_codigo_iso_pais_regiao
            , codigo_iso_pais_regiao
            , nome_pais_regiao
        from {{ ref('stg_pessoas_pais_regiao') }}
    )
    , tabela_final as (
        select
            stg_vendas_cabecalho_pedido.sk_id_endereco_entrega_cliente
            , stg_vendas_cabecalho_pedido.sk_id_territorio
            , stg_pessoas_estado_provincia.sk_codigo_iso_estado_provincia
            , stg_pessoas_pais_regiao.sk_codigo_iso_pais_regiao
            , stg_vendas_cabecalho_pedido.id_endereco_entrega_cliente
            , stg_vendas_cabecalho_pedido.id_territorio
            , stg_pessoas_pais_regiao.codigo_iso_pais_regiao
            , stg_pessoas_pais_regiao.nome_pais_regiao
            , stg_pessoas_estado_provincia.codigo_iso_estado_provincia
            , stg_pessoas_estado_provincia.nome_estado_provincia
            , stg_vendas_territorio.nome_territorio
            , stg_pessoas_endereco.codigo_postal_endereco
            , stg_pessoas_endereco.cidade_endereco
        from stg_vendas_cabecalho_pedido 
        left join stg_pessoas_endereco 
            on stg_vendas_cabecalho_pedido.id_endereco_entrega_cliente = stg_pessoas_endereco.id_endereco
        left join stg_pessoas_estado_provincia
            on stg_pessoas_endereco.id_estado_provincia = stg_pessoas_estado_provincia.id_estado_provincia
        left join stg_vendas_territorio
            on stg_vendas_cabecalho_pedido.sk_id_territorio = stg_vendas_territorio.sk_id_territorio
        left join stg_pessoas_pais_regiao
            on  stg_vendas_territorio.sk_codigo_iso_pais_regiao = stg_pessoas_pais_regiao.sk_codigo_iso_pais_regiao
    )
select *
from tabela_final