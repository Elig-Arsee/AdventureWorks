classDiagram
    class FACT_VENDAS_PEDIDO {
        sales.salesorderheader
    }
    class FACT_VENDAS_PRODUTO {
        sales.salesorderheader
        sales.salesorderdetail

    }
    class DIM_CARTAO_CREDITO {
        sales.creditcard
        sales.salesorderheader
    }
    class DIM_CLIENTE {
        sales.customer
        person.person
        sales.store
    }
    class DIM_ENDERECO {
        sales.salesorderheader
        person.address
        person.stateprovince
        sales.salesterritory
        person.countryregion
    }
    class DIM_MOTIVO_VENDA {
        sales.salesorderheadersalesreason
        sales.salesreason
    }
    class DIM_PRODUTO {
        sales.salesorderdetail

    }

    FACT_VENDAS_PEDIDO --> DIM_CLIENTE
    FACT_VENDAS_PEDIDO --> DIM_ENDERECO
    FACT_VENDAS_PEDIDO --> DIM_CARTAO_CREDITO
    FACT_VENDAS_PEDIDO --> DIM_MOTIVO_VENDA
    FACT_VENDAS_PRODUTO --> DIM_MOTIVO_VENDA
    FACT_VENDAS_PRODUTO --> DIM_ENDERECO
    FACT_VENDAS_PRODUTO --> DIM_CARTAO_CREDITO
    FACT_VENDAS_PRODUTO --> DIM_PRODUTO
