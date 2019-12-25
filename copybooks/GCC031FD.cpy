      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos
      *    AUTHOR......: Leo Ribeiro e Silva Santos
      *    DATA........: 18/12/2019
      *    OBJETIVO ...: Arquivo importacao
      *================================================================*
       FD  ARQ-DIST.
       01  REG-ARQ-DIST.
           05 DIST-CLIE-CODIG               PIC 9(007).
           05 DIST-CLIE-CODIGO              PIC  9(007).
           05 DIST-CLIE-CNPJ                PIC  9(014).
           05 DIST-CLIE-RAZAO-SOCIAL        PIC  X(040).
           05 DIST-CLIE-LATITUDE            PIC S9(003)V9(008).
           05 DIST-CLIE-LONGITUDE           PIC S9(003)V9(008).
           05 DIST-VEND-CODIGO              PIC  9(007).
           05 DIST-VEND-CPF                 PIC  9(014).
           05 DIST-VEND-RAZAO-SOCIAL        PIC  X(040).
           05 DIST-VEND-LATITUDE            PIC S9(003)V9(008).
           05 DIST-VEND-LONGITUDE           PIC S9(003)V9(008).
           05 DIST-DISTANCIA                PIC  9(006).
