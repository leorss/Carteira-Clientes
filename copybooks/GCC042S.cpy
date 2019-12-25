      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos
      *    AUTHOR......: Leo Ribeiro e Silva Santos
      *    DATA........: 18/12/2019
      *    OBJETIVO ...: Telas importacao arquivo de clientes
      *================================================================*

      *----------------------------------------------------------------*
       01  S-TELA-IMPORTA.
      *----------------------------------------------------------------*
           05  FOREGROUND-COLOR 7.
               10  VALUE  "Arquivo ........: "
                                       LINE 08 COL 10.
               10  S-ARQ-IMP-VEND
                   FOREGROUND-COLOR 0 BACKGROUND-COLOR 7
                                       LINE 08 COL 28
                                       PIC X(40) TO WID-ARQ-IMP-VEND.

      *----------------------------------------------------------------*
       01  S-TELA-CONTADOR.
      *----------------------------------------------------------------*
           05  FOREGROUND-COLOR 7.
               10  VALUE  "Lidos ..........: "
                                       LINE 10 COL 10.
               10  S-LIDOS
                   FOREGROUND-COLOR 0  BACKGROUND-COLOR 7
                                       LINE 10 COL 28
                                       PIC Z.ZZZ.ZZZ.ZZ9 TO W-LIDOS.
               10  VALUE  "Gravados .......: "
                                       LINE 12 COL 10.
               10  S-GRAVADOS
                   FOREGROUND-COLOR 0  BACKGROUND-COLOR 7
                                       LINE 12 COL 28
                                       PIC Z.ZZZ.ZZZ.ZZ9 TO W-GRAVADOS.
               10  VALUE  "Erros...........: "
                                       LINE 14 COL 10.
               10  S-ERROS
                   FOREGROUND-COLOR 0  BACKGROUND-COLOR 7
                                       LINE 14 COL 28
                                       PIC Z.ZZZ.ZZZ.ZZ9 TO W-ERROS.
