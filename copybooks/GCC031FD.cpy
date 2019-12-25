      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos
      *    AUTHOR......: Leo Ribeiro e Silva Santos
      *    DATA........: 18/12/2019
      *    OBJETIVO ...: Arquivo importacao
      *================================================================*
       FD  ARQ-DIST.
       01  REG-ARQ-DIST.
           05 REG-DIST-CLIENTE.
               10 DIST-CLIE-CODIGO     PIC  9(007).
               10 DIST-CLIE-CNPJ       PIC  9(014).
               10 DIST-CLIE-RAZAO-SOCIAL
                                       PIC  X(040).
               10 DIST-CLIE-LATITUDE   PIC S9(003)V9(008).
               10 DIST-CLIE-LONGITUDE  PIC S9(003)V9(008).
           05 REG-DIST-VENDEDOR.
               10 DIST-VEND-CODIGO     PIC  9(007).
               10 DIST-VEND-CPF        PIC  9(011).
               10 DIST-VEND-RAZAO-SOCIAL
                                       PIC  X(040).
               10 DIST-VEND-LATITUDE   PIC S9(003)V9(008).
               10 DIST-VEND-LONGITUDE  PIC S9(003)V9(008).
           05 DIST-DISTANCIA           PIC  9(010)V9(008).
