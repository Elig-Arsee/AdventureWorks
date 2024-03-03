with funcionarios as (
    select
        businessentityid as id_entidade_empresarial
        , loginid as id_login_funcionario
        , jobtitle as cargo_funcionario
        , gender as genero_funcionario
        , cast(hiredate as timestamp) as data_contratacao_funcionario
        , case
            when salariedflag = true
                 then 'Sim'
            when salariedflag = false
                 then 'Não'
        end as funcionario_assalariado
        , vacationhours as horas_ferias_disponiveis
        , sickleavehours as horas_licenca_medica_disponiveis
        , case
            when currentflag =
                true then 'Sim'
            when currentflag =
                false then 'Não'
        end as funcionario_atual
    from {{ source('humanresources', 'employee') }}
)
    , source_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['id_entidade_empresarial']) }} as sk_id_entidade_empresarial
            , {{ dbt_utils.generate_surrogate_key(['id_login_funcionario']) }} as sk_id_login_funcionario
            , id_entidade_empresarial
            , id_login_funcionario
            , cargo_funcionario
            , genero_funcionario
            , data_contratacao_funcionario
            , funcionario_assalariado
            , horas_ferias_disponiveis
            , horas_licenca_medica_disponiveis
            , funcionario_atual
        from funcionarios
    )
select *
from source_with_sk
