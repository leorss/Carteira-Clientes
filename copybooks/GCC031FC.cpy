      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos
      *    AUTHOR......: Leo Ribeiro e Silva Santos
      *    DATA........: 18/12/2019
      *    OBJETIVO ...: File Control arquivo work
      *================================================================*
           SELECT ARQ-DIST          ASSIGN TO  WID-ARQ-DIST
               ORGANIZATION            IS INDEXED
               ACCESS MODE             IS DYNAMIC
               RECORD KEY              IS DIST-CLIE-CODIGO
               LOCK MODE               IS MANUAL
               FILE STATUS             IS WS-RESULTADO-ACESSO.
