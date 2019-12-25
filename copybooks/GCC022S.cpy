      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos
      *    AUTHOR......: Leo Ribeiro e Silva Santos
      *    DATA........: 18/12/2019
      *    OBJETIVO ...: Tela arquivo relatorio e importacao
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

               10  VALUE  "Ordenacao.......: "
                                       LINE 11 COL 10.
               10  S-ORDENACAO
                   FOREGROUND-COLOR 0 BACKGROUND-COLOR 7
                                       LINE 11 COL 28
                                       PIC X(1) TO W-ORDENACAO.
               10  S-ORDENACAO-DESC
                                       PIC X(30) TO S-ORDENACAO-DESC
                                       LINE 11 COL 30.
               10  VALUE  "Classificacao...: "
                                       LINE 13 COL 10.
               10  S-CLASSIFICACAO
                   FOREGROUND-COLOR 0 BACKGROUND-COLOR 7
                                       LINE 13 COL 28
                                       PIC X(01) TO W-CLASSIFICACAO.
               10  S-CLASSIFICACAO-DESC
                                       PIC X(30) TO S-CLASSIFICACAO-DESC
                                       LINE 13 COL 30.
               10  VALUE  "Codigo Cliente..: "
                                       LINE 15 COL 10.
               10  S-CODIGO
                   FOREGROUND-COLOR 0 BACKGROUND-COLOR 7
                   BLANK WHEN ZEROS    LINE 15 COL 28
                                       PIC 9(07) TO W-CODIGO.
               10  S-CODIGO-DESC       PIC X(20) TO S-CODIGO-DESC
                                       LINE 15 COL 37.
               10  VALUE  "Razao Social...: "
                                       LINE 17 COL 10.
               10  S-RAZAO-SOCIAL
                   FOREGROUND-COLOR 0 BACKGROUND-COLOR 7
                                       LINE 17 COL 28
                                       PIC X(40) TO W-RAZAO-SOCIAL.
.
