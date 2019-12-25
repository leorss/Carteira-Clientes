      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos
      *    AUTHOR......: Leo Ribeiro e Silva Santos
      *    DATA........: 18/12/2019
      *    OBJETIVO ...: Campos validacao CPF / CNPJ
      *================================================================*

      *---------------------------------------------------------*
      * Campos validacao CPF / CNPJ
      *---------------------------------------------------------*
       01  CAMPOS-VALIDA-CPF-CNPJ.
           05  CPF-VALIDO              PIC X(01) VALUE SPACE.
           05  I                       PIC 9(02) VALUE ZEROS.
           05  F                       PIC 9(01) VALUE 1.
           05  G                       PIC 9(02) VALUE ZEROS.
           05  INTEIRO                 PIC 9(02) VALUE ZEROS.
           05  TOTAL                   PIC 9(03) VALUE ZEROS.
           05  CNPJ-VALIDO             PIC X(01) VALUE SPACES.
           05  CNPJ                    PIC 9(14) VALUE ZEROS.
           05  FILLER      REDEFINES   CNPJ.
               10 CNPJ-01              PIC 9(01).
               10 CNPJ-02              PIC 9(01).
               10 CNPJ-03              PIC 9(01).
               10 CNPJ-04              PIC 9(01).
               10 CNPJ-05              PIC 9(01).
               10 CNPJ-06              PIC 9(01).
               10 CNPJ-07              PIC 9(01).
               10 CNPJ-08              PIC 9(01).
               10 CNPJ-09              PIC 9(01).
               10 CNPJ-10              PIC 9(01).
               10 CNPJ-11              PIC 9(01).
               10 CNPJ-12              PIC 9(01).
               10 CNPJ-13              PIC 9(02).
               10 FILLER   REDEFINES   CNPJ-13.
                  15 CNPJ-14           PIC 9(01).
                  15 CNPJ-15           PIC 9(01).
           05  SALVA-CNPJ              PIC 9(14) VALUE ZEROS.
           05  TESTE-77                PIC 9(01) VALUE ZERO.
           05  LIXO                    PIC 9(06) VALUE ZEROS.
           05  DV                      PIC 9(06) VALUE ZEROS.
           05  RESTO                   PIC 9(02) VALUE ZEROS.
           05  FILLER      REDEFINES   RESTO.
               10 R-1                  PIC 9(01).
               10 R-2                  PIC 9(01).
           05  RETORNO.
               10 RETORNO-1            PIC X(01).
               10 RETORNO-2            PIC X(01).

       01  CPF-RECEBIDO                PIC 9(11).
       01  CPF-CALCULADO               PIC 9(11) VALUE ZEROS.
       01  CPF-I REDEFINES CPF-CALCULADO.
           03  CPF-DIG OCCURS 11 TIMES.
               05  DIG                 PIC 9(01).
