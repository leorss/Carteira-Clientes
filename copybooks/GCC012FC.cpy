      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos
      *    AUTHOR......: Leo Ribeiro e Silva Santos
      *    DATA........: 18/12/2019
      *    OBJETIVO ...: File Control arquivo vendedores
      *================================================================*
           SELECT ARQ-VENDEDOR         ASSIGN TO  WID-ARQ-VENDEDOR
               ORGANIZATION            IS INDEXED
               ACCESS MODE             IS DYNAMIC
               RECORD KEY              IS VEND-CODIGO
               ALTERNATE KEY           IS VEND-CPF
                                       WITH DUPLICATES
               LOCK MODE               IS MANUAL
               FILE STATUS             IS WS-RESULTADO-ACESSO.
