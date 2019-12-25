      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos
      *    AUTHOR......: Leo Ribeiro e Silva Santos
      *    DATA........: 18/12/2019
      *    OBJETIVO ...: File Control relatorio / importacao
      *================================================================*
           SELECT ARQ-RELATO           ASSIGN TO  W-ARQ-RELATO
               ORGANIZATION            IS LINE SEQUENTIAL
               FILE STATUS             IS WS-RESULTADO-ACESSO.

           SELECT ARQ-IMPORTA          ASSIGN TO  W-ARQ-IMPORTA
               ORGANIZATION            IS LINE SEQUENTIAL
               FILE STATUS             IS WS-RESULTADO-ACESSO.
