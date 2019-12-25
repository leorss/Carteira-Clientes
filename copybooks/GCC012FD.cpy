      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos
      *    AUTHOR......: Leo Ribeiro e Silva Santos
      *    DATA........: 18/12/2019
      *    OBJETIVO ...: FD arquivo vendedores
      *================================================================*

       FD  ARQ-VENDEDOR.
       01  REG-ARQ-VENDEDOR.
           02 VEND-CODIGO              PIC  9(007).
           02 VEND-CPF                 PIC  9(011).
           02 VEND-RAZAO-SOCIAL        PIC  X(040).
           02 VEND-LATITUDE            PIC S9(003)V9(008).
           02 VEND-LONGITUDE           PIC S9(003)V9(008).
