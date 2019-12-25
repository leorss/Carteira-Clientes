      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos
      *    AUTHOR......: Leo Ribeiro e Silva Santos
      *    DATA........: 18/12/2019
      *    OBJETIVO ...: Tela arquivo distribuicao
      *================================================================*
      *----------------------------------------------------------------*
       01  S-TELA-ACC-ARQ.
      *----------------------------------------------------------------*
           05  FOREGROUND-COLOR 7.
               10  VALUE  "Arquivo ........: "
                                       LINE 08 COL 10.
               10  S-NOME-ARQ
                   FOREGROUND-COLOR 0 BACKGROUND-COLOR 7
                                       LINE 08 COL 28
                                       PIC X(40) TO W-ARQ-RELATO.
