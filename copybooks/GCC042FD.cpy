      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos
      *    AUTHOR......: Leo Ribeiro e Silva Santos
      *    DATA........: 18/12/2019
      *    OBJETIVO ...: FD arquivo importacao vendedores
      *================================================================*

       FD  ARQ-IMPORTA.
       01  REG-ARQ-IMPORTA.
           02 IMPT-CODIGO        PIC  9(007).
           02 IMPT-CPF           PIC  9(011).
           02 IMPT-RAZAO-SOCIAL  PIC  X(040).
           02 IMPT-LATITUDE      PIC S9(003)V9(008).
           02 IMPT-LONGITUDE     PIC S9(003)V9(008).
