with recursos_humanos as (
    select
        departmentid as id_departamento
        , name as nome_departamento
        , groupname as grupo_departamento
    from {{ source('humanresources', 'department') }}
)
    , source_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['id_departamento']) }} as sk_id_departamento
            , id_departamento
            , nome_departamento
            , grupo_departamento
        from recursos_humanos
    )
select *
from source_with_sk
