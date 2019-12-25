      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos
      *    AUTHOR......: Leo Ribeiro e Silva Santos
      *    DATA........: 18/12/2019
      *    OBJETIVO ...: FD arquivo clientes
      *================================================================*
       FD  ARQ-CLIENTE.
       01  REG-ARQ-CLIENTE.
           02 CLIE-CODIGO              PIC  9(007).
           02 CLIE-CNPJ                PIC  9(014).
           02 CLIE-RAZAO-SOCIAL        PIC  X(040).
           02 CLIE-LATITUDE            PIC S9(003)V9(008).
           02 CLIE-LONGITUDE           PIC S9(003)V9(008).
