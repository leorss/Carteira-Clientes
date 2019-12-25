      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos
      *    AUTHOR......: Leo Ribeiro e Silva Santos
      *    DATA........: 18/12/2019
      *    OBJETIVO ...: Rotina menu cadstro clientes
      *================================================================*

      *----------------------------------------------------------------*
       01  S-TELA-CAPTURA.
      *----------------------------------------------------------------*
           05  FOREGROUND-COLOR 7.
               10  VALUE  "Codigo ........: "
                                       LINE 08 COL 10.
               10  S-CLIE-CODIGO       BLANK WHEN ZERO
                   FOREGROUND-COLOR 0 BACKGROUND-COLOR 7
                                       LINE 08 COL 28
                                       PIC 9(7) TO CLIE-CODIGO.
               10  VALUE  "CNPJ...........: "
                                       LINE 10 COL 10.
               10  S-CLIE-CNPJ         BLANK WHEN ZERO
                   FOREGROUND-COLOR 0 BACKGROUND-COLOR 7
                                       LINE 10 COL 28
                                       PIC 99.999.999/9999B99
                                                TO CLIE-CNPJ.
               10  VALUE  "Razao Social...: "
                                       LINE 12 COL 10.
               10  S-CLIE-RAZAO-SOCIAL LINE 12 COL 28
                   FOREGROUND-COLOR 0 BACKGROUND-COLOR 7
                                       PIC X(40) TO CLIE-RAZAO-SOCIAL.

               10  VALUE  "Latitude.......: "
                                       LINE 14 COL 10.
               10  S-CLIE-LATITUDE
                   BLANK WHEN ZEROS
                   FOREGROUND-COLOR 0 BACKGROUND-COLOR 7
                                       LINE 14 COL 28
                                       PIC -999,99999999
                                                     TO CLIE-LATITUDE.

               10  VALUE  "Longitude......: "
                                       LINE 16 COL 10.
               10  S-CLIE-LONGITUDE
                   BLANK WHEN ZEROS
                   FOREGROUND-COLOR 0 BACKGROUND-COLOR 7
                                       LINE 16 COL 28
                                       PIC -999,99999999
                                                    TO CLIE-LONGITUDE.
