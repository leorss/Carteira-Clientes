      *================================================================*
       IDENTIFICATION              DIVISION.
      *================================================================*
       PROGRAM-ID. GCC030P.
      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos         *
      *    PROGRAMA....: GCC030P                                       *
      *    AUTHOR......: Leo Ribeiro e Silva Santos                    *
      *    DATA........: 21/12/2019                                    *
      *    OBJETIVO ...: Distribuicao clientes a vendedores proximos   *
      *----------------------------------------------------------------*
      *================================================================*
       ENVIRONMENT                     DIVISION.
      *================================================================*

      *----------------------------------------------------------------*
       CONFIGURATION                   SECTION.
      *----------------------------------------------------------------*

       SPECIAL-NAMES.
           DECIMAL-POINT               IS COMMA.

      *----------------------------------------------------------------*
       INPUT-OUTPUT                    SECTION.
      *----------------------------------------------------------------*
       FILE-CONTROL.

      * Arquivo Clientes
       COPY ".\copybooks\GCC011FC".
      * Arquivo Vendedores
       COPY ".\copybooks\GCC012FC".
      * Arquivo relatorio
       COPY ".\copybooks\GCC021FC".
      * Arquivo Distribuicao
       COPY ".\copybooks\GCC031FC".

      *================================================================*
       DATA                            DIVISION.
      *================================================================*
       FILE                            SECTION.

      * Arquivo Clientes
       COPY ".\copybooks\GCC011FD".
      * Arquivo Vendedores
       COPY ".\copybooks\GCC012FD".
      * Arquivo Relatorio
       COPY ".\copybooks\GCC021FD".
      * Arquivo Distribuicao
       COPY ".\copybooks\GCC031FD".

      *----------------------------------------------------------------*
       WORKING-STORAGE                 SECTION.
      *----------------------------------------------------------------*
      * Campos uso comum
       COPY ".\copybooks\GCC000W".

       01  W-CALCULO-DISTANCIA.
           05  W-DIST-VEND-ATUAL       PIC  9(10)V9(08)  VALUE ZEROS.
           05  W-DIST-VEND-ANTERIOR    PIC  9(10)V9(08)  VALUE ZEROS.
           05  W-LAT-CLI               PIC S9(03)V9(08)  VALUE ZEROS.
           05  W-LAT-VEN               PIC S9(03)V9(08)  VALUE ZEROS.
           05  W-LON-CLI               PIC S9(03)V9(08)  VALUE ZEROS.
           05  W-LON-VEN               PIC S9(03)V9(08)  VALUE ZEROS.
           05  W-DLA                   PIC S9(03)V9(08)  VALUE ZEROS.
           05  W-DLO                   PIC S9(03)V9(08)  VALUE ZEROS.
           05  W-A                     PIC S9(03)V9(08)  VALUE ZEROS.
           05  W-C                     PIC S9(03)V9(08)  VALUE ZEROS.

       01  W-REG-ARQ-RELATO-CAB.
           05 FILLER                   PIC X(132) VALUE
           "Cliente; Razao Social; Vendedor; Nome; Distancia ;".

       01  W-REG-ARQ-RELATO.
           05 W-RELAT-CLIE-COD         PIC  9(07) VALUES ZEROS.
           05 FILLER                   PIC  X(01) VALUE ";".
           05 W-RELAT-CLIE-RAZAO       PIC  X(40) VALUES SPACES.
           05 FILLER                   PIC  X(01) VALUE ";".
           05 W-RELAT-VEND-COD         PIC  9(07) VALUES ZEROS.
           05 FILLER                   PIC  X(01) VALUE ";".
           05 W-RELAT-VEND-RAZAO       PIC  X(40) VALUES SPACES.
           05 FILLER                   PIC  X(01) VALUE ";".
           05 W-DISTANCIA              PIC  9(06) VALUES ZEROS.
           05 FILLER                   PIC  X(01) VALUE ";".

      *----------------------------------------------------------------*
       LINKAGE                         SECTION.
      *----------------------------------------------------------------*
       COPY ".\copybooks\GCC000L".

      *----------------------------------------------------------------*
       SCREEN                          SECTION.
      *----------------------------------------------------------------*
      * Copybook tela principal
       COPY ".\copybooks\GCC000S".
      * Copybook tela relatorio
       COPY ".\copybooks\GCC030S".
      *
       COPY screenio.

      *================================================================*
       PROCEDURE                       DIVISION USING LK-PARAM.
      *================================================================*

      *----------------------------------------------------------------*
      *    ROTINA PRINCIPAL DO PROGRAMA.                               *
      *----------------------------------------------------------------*
       0000-INICIO                     SECTION.
      *----------------------------------------------------------------*
      *
           SET ENVIRONMENT 'COB_SCREEN_EXCEPTIONS' TO 'Y'.
           SET ENVIRONMENT 'COB_SCREEN_ESC'        TO 'Y'.
           SET ENVIRONMENT 'ESCDELAY'              TO '25'.

           PERFORM UNTIL W-FIM EQUAL "S"
               MOVE "N"                    TO W-GRAVADO
               MOVE "N"                    TO W-VOLTAR

               MOVE "Distribuicao Clientes"
                                       TO  W-MODULO
               MOVE WID-ARQ-DISTRIBUICAO
                                          TO  W-ARQ-RELATO
                                           S-NOME-ARQ
               MOVE "<Esc> Voltar <Enter> Processar"
                                   TO W-STATUS
               DISPLAY S-CLS
               DISPLAY S-TELA-ACC-ARQ

               IF  W-VOLTAR        EQUAL "N"
                   ACCEPT S-NOME-ARQ
                   IF COB-CRT-STATUS NOT EQUAL COB-SCR-ESC
                       PERFORM 1000-PROCESSAR
                   END-IF
               END-IF

               GOBACK
           END-PERFORM.

      *----------------------------------------------------------------*
       0000-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       1000-PROCESSAR.
      *----------------------------------------------------------------*

           MOVE "N"                    TO W-VOLTAR
           MOVE "N"                    TO W-GRAVADO

           PERFORM 2100-ABRIR-ARQUIVOS

           IF  W-VOLTAR EQUAL "N"
               PERFORM 7153-LER-PROX-ARQ-CLIE
               IF  FS-FIM
                   MOVE "S"         TO W-VOLTAR
                   MOVE  "Arquivo Clientes vazio, tecle <Enter>"
                                       TO  W-MSGERRO
                   PERFORM 8500-MOSTRA-AVISO
               END-IF
               PERFORM UNTIL FS-FIM  OR
                             W-VOLTAR EQUAL "S"
                  INITIALIZE W-REG-ARQ-RELATO
                  MOVE CLIE-CODIGO
                                        TO W-RELAT-CLIE-COD
                  MOVE CLIE-RAZAO-SOCIAL
                                        TO W-RELAT-CLIE-RAZAO
                  MOVE CLIE-CODIGO      TO DIST-CLIE-CODIGO
                  MOVE CLIE-CNPJ        TO DIST-CLIE-CNPJ
                  MOVE CLIE-RAZAO-SOCIAL
                                          TO DIST-CLIE-RAZAO-SOCIAL
                  MOVE CLIE-LATITUDE    TO DIST-CLIE-LATITUDE
                  MOVE CLIE-LONGITUDE   TO DIST-CLIE-LONGITUDE
                  PERFORM 1100-ENCONTRAR-VENDEDOR
                  PERFORM 4300-GRAVAR-REGISTRO
                  PERFORM 7153-LER-PROX-ARQ-CLIE
               END-PERFORM
               PERFORM 7190-FECHAR-ARQ-CLIE
               PERFORM 7290-FECHAR-ARQ-VEND
               PERFORM 7590-FECHAR-ARQ-RELATO
               PERFORM 7690-FECHAR-ARQ-DIST
               IF   W-VOLTAR EQUAL "N"
                    IF  W-GRAVADO  EQUAL "S"
                        MOVE  "Relatorio gerado, tecle <Enter>"
                                TO  W-MSGERRO
                        PERFORM 8500-MOSTRA-AVISO
                    END-IF
               END-IF
           END-IF.

      *----------------------------------------------------------------*
       1000-99-FIM.                   EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       1100-ENCONTRAR-VENDEDOR.
      *----------------------------------------------------------------*

           MOVE "N"                    TO W-REG-ENCONTRADO

           MOVE 0                      TO VEND-CODIGO
           PERFORM 7271-START-ARQ-VEND-ASC

           PERFORM 7253-LER-PROX-ARQ-VEND
           IF  FS-FIM
               MOVE "S"         TO W-VOLTAR
               MOVE  "Arquivo Vendedores vazio, tecle <Enter>"
                                   TO  W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           END-IF
           PERFORM UNTIL FS-FIM  OR
                         W-VOLTAR = "S"
               PERFORM 5100-CALCULAR-DISTANCIA
               IF  W-DIST-VEND-ANTERIOR GREATER
                   W-DIST-VEND-ATUAL
                   MOVE "S"            TO W-REG-ENCONTRADO
                   MOVE VEND-CODIGO    TO W-RELAT-VEND-COD
                   MOVE VEND-RAZAO-SOCIAL
                                       TO W-RELAT-VEND-RAZAO
                   MOVE VEND-CODIGO    TO DIST-VEND-CODIGO
                   MOVE VEND-CPF       TO DIST-VEND-CPF
                   MOVE VEND-RAZAO-SOCIAL
                                       TO DIST-VEND-RAZAO-SOCIAL
                   MOVE VEND-LATITUDE  TO DIST-VEND-LATITUDE
                   MOVE VEND-LONGITUDE TO DIST-VEND-LONGITUDE
                   MOVE W-DIST-VEND-ATUAL
                                       TO W-DISTANCIA
                   MOVE W-DIST-VEND-ATUAL
                                       TO W-DIST-VEND-ANTERIOR
               END-IF
               PERFORM 7253-LER-PROX-ARQ-VEND
           END-PERFORM.

      *----------------------------------------------------------------*
       1000-99-FIM.                   EXIT.
      *----------------------------------------------------------------*

      ******************************************************************
      * ROTINAS AUXILIARES
      ******************************************************************

      *----------------------------------------------------------------*
       2100-ABRIR-ARQUIVOS.
      *----------------------------------------------------------------*

           PERFORM 7111-ABRIR-INPUT-ARQ-CLIE
           IF  NOT FS-OK
               PERFORM 7190-FECHAR-ARQ-CLIE
               MOVE "S"                TO W-VOLTAR
           END-IF

           IF  W-VOLTAR     EQUAL "N"
               PERFORM 7211-ABRIR-INPUT-ARQ-VEND
               IF   NOT FS-OK
                    PERFORM 7190-FECHAR-ARQ-CLIE
                    PERFORM 7290-FECHAR-ARQ-VEND
                    MOVE "S"           TO W-VOLTAR
               END-IF
           END-IF

           IF  W-VOLTAR     EQUAL "N"
               PERFORM 7510-ABRIR-ARQ-RELATO
               IF  NOT FS-OK
                   PERFORM 7190-FECHAR-ARQ-CLIE
                   PERFORM 7290-FECHAR-ARQ-VEND
                   PERFORM 7590-FECHAR-ARQ-RELATO
                   MOVE "S"       TO W-VOLTAR
               END-IF
           END-IF

           IF  W-VOLTAR     EQUAL "N"
               PERFORM 7610-ABRIR-ARQ-DIST
               IF  NOT FS-OK
                   PERFORM 7190-FECHAR-ARQ-CLIE
                   PERFORM 7290-FECHAR-ARQ-VEND
                   PERFORM 7590-FECHAR-ARQ-RELATO
                   PERFORM 7690-FECHAR-ARQ-DIST
                   MOVE "S"       TO W-VOLTAR
               END-IF
           END-IF.

      *----------------------------------------------------------------*
       2100-99-FIM.                   EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       4300-GRAVAR-REGISTRO            SECTION.
      *----------------------------------------------------------------*

           IF  W-GRAVADO           EQUAL "N"
               MOVE  W-REG-ARQ-RELATO-CAB
                                       TO REG-ARQ-RELATO
               PERFORM 7560-GRAVAR-ARQ-RELATO
               MOVE "S"                TO W-GRAVADO
           END-IF

           MOVE  W-REG-ARQ-RELATO  TO REG-ARQ-RELATO
           PERFORM 7560-GRAVAR-ARQ-RELATO.

      *----------------------------------------------------------------*
       4300-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       5100-CALCULAR-DISTANCIA         SECTION.
      *----------------------------------------------------------------*

           COMPUTE W-LAT-CLI  = CLIE-LATITUDE  * FUNCTION PI / 180
           COMPUTE W-LAT-VEN  = VEND-LATITUDE  * FUNCTION PI / 180
           COMPUTE W-LON-CLI  = CLIE-LONGITUDE * FUNCTION PI / 180
           COMPUTE W-LON-VEN  = VEND-LONGITUDE * FUNCTION PI / 180

           COMPUTE W-DLA = W-LAT-VEN - (W-LAT-CLI)
           COMPUTE W-DLO = W-LON-VEN - (W-LON-CLI)
           COMPUTE W-A   = FUNCTION SIN(W-DLA / 2)
                         * FUNCTION SIN(W-DLA / 2)
                         + FUNCTION COS(W-LAT-CLI)
                         * FUNCTION COS(W-LAT-VEN)
                         * FUNCTION SIN(W-DLO / 2)
                         * FUNCTION SIN(W-DLO / 2)

           COMPUTE W-C = 2 * FUNCTION ATAN(FUNCTION SQRT(W-A) /
                                           FUNCTION SQRT(1 - W-A))

           COMPUTE W-DIST-VEND-ATUAL = 6731 * W-C * 1000.

      *----------------------------------------------------------------*
       5100-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      * Rotinas arquivo vendedores
       COPY ".\copybooks\GCC012R".
      * Rotinas arquivo clientes
       COPY ".\copybooks\GCC011R".
      * Rotinas arquivo relatorio e importacao
       COPY ".\copybooks\GCC021R".
      * Rotinas arquivo distribuicao
       COPY ".\copybooks\GCC031R".
      * Rotinas tela principal
       COPY ".\copybooks\GCC000R".
