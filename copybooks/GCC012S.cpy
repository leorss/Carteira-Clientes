      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos
      *    AUTHOR......: Leo Ribeiro e Silva Santos
      *    DATA........: 18/12/2019
      *    OBJETIVO ...: Rotinas menu cadastro vendedores
      *================================================================*

      *----------------------------------------------------------------*
       01  S-TELA-CAPTURA.
      *----------------------------------------------------------------*
           05  FOREGROUND-COLOR 7.
               10  VALUE  "Codigo ........: "
                                       LINE 08 COL 10.
               10  S-VEND-CODIGO       BLANK WHEN ZERO
                   FOREGROUND-COLOR 0 BACKGROUND-COLOR 7
                                       LINE 08 COL 28
                                       PIC 9(7) TO VEND-CODIGO.
               10  VALUE  "CPF............: "
                                       LINE 10 COL 10.
               10  S-VEND-CPF          BLANK WHEN ZERO
                   FOREGROUND-COLOR 0 BACKGROUND-COLOR 7
                                       LINE 10 COL 28
                                       PIC 999.999.999B99
                                                TO VEND-CPF.
               10  VALUE  "Razao Social...: "
                                       LINE 12 COL 10.
               10  S-VEND-RAZAO-SOCIAL LINE 12 COL 28
                   FOREGROUND-COLOR 0 BACKGROUND-COLOR 7
                                       PIC X(40) TO VEND-RAZAO-SOCIAL.
               10  VALUE  "Latitude.......: "
                                       LINE 14 COL 10.
               10  S-VEND-LATITUDE     BLANK WHEN ZERO
                   FOREGROUND-COLOR 0 BACKGROUND-COLOR 7
                                       LINE 14 COL 28
                                       PIC -999,99999999
                                                     TO VEND-LATITUDE.
               10  VALUE  "Longitude......: "
                                       LINE 16 COL 10.
               10  S-VEND-LONGITUDE    BLANK WHEN ZERO
                   FOREGROUND-COLOR 0 BACKGROUND-COLOR 7
                                       LINE 16 COL 28
                                       PIC -999,99999999
                                                    TO VEND-LONGITUDE.
