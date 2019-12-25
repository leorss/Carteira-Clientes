      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos
      *    AUTHOR......: Leo Ribeiro e Silva Santos
      *    DATA........: 18/12/2019
      *    OBJETIVO ...: File Control arquivo clientes
      *================================================================*
           SELECT ARQ-CLIENTE          ASSIGN TO  WID-ARQ-CLIENTE
               ORGANIZATION            IS INDEXED
               ACCESS MODE             IS DYNAMIC
               RECORD KEY              IS CLIE-CODIGO
               ALTERNATE KEY           IS CLIE-CNPJ
               ALTERNATE KEY           IS CLIE-RAZAO-SOCIAL
                                       WITH DUPLICATES
               LOCK MODE               IS MANUAL
               FILE STATUS             IS WS-RESULTADO-ACESSO.
