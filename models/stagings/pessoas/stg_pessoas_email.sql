with pessoas_endereco_email as (
    select
        businessentityid as id_entidade_empresarial
        , emailaddressid as id_endereco_email
        , cast(emailaddress.emailaddress as string) as endereco_email
    from {{ source('person', 'emailaddress') }}
)
    , source_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['id_entidade_empresarial']) }} as sk_id_entidade_empresarial
            , {{ dbt_utils.generate_surrogate_key(['id_endereco_email']) }} as sk_id_endereco_email
            , id_entidade_empresarial
            , id_endereco_email
            , endereco_email
        from pessoas_endereco_email
    )
select *
from source_with_sk