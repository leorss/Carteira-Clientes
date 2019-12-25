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
               MOVE "N"                TO W-GRAVADO
               MOVE "N"                TO W-VOLTAR

               MOVE "Distribuicao Clientes"
                                       TO  W-MODULO
               MOVE WID-ARQ-DISTRIBUICAO
                                       TO  W-ARQ-RELATO
                                           S-NOME-ARQ

               MOVE "<Esc> Voltar <Enter> Processar"
                                       TO W-STATUS
               DISPLAY S-CLS
               DISPLAY S-TELA-ACC-ARQ
               ACCEPT S-NOME-ARQ

               IF  COB-CRT-STATUS NOT EQUAL COB-SCR-ESC
                   PERFORM 2100-ABRIR-ARQUIVOS
                   IF  W-VOLTAR        EQUAL "N"
                       PERFORM 2000-PROCESSAR
                   END-IF
               END-IF
               GOBACK
           END-PERFORM.

      *----------------------------------------------------------------*
       0000-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       2000-PROCESSAR.
      *----------------------------------------------------------------*

           PERFORM 7111-ABRIR-INPUT-ARQ-CLIE
           IF  NOT FS-OK
               MOVE "S"                TO W-VOLTAR
           ELSE
               PERFORM 7153-LER-PROX-ARQ-CLIE
               IF  NOT FS-OK
                   MOVE "S"            TO W-VOLTAR
               END-IF
           END-IF

           PERFORM 1100-REALIZAR-DIST UNTIL FS-FIM  OR
                                          W-VOLTAR  EQUAL "S"

           PERFORM 7190-FECHAR-ARQ-CLIE
           PERFORM 7590-FECHAR-ARQ-RELATO
           PERFORM 7690-FECHAR-ARQ-DIST.

           MOVE  "Fim processo, tecle <Enter>"
                                       TO  W-MSGERRO
           PERFORM 8500-MOSTRA-AVISO.

      *----------------------------------------------------------------*
       1000-99-FIM.                   EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       1100-REALIZAR-DIST.
      *----------------------------------------------------------------*

           MOVE REG-ARQ-CLIENTE        TO REG-DIST-CLIENTE
           MOVE CLIE-CODIGO            TO W-RELAT-CLIE-COD
           MOVE CLIE-RAZAO-SOCIAL      TO W-RELAT-CLIE-RAZAO

           PERFORM 1110-ENCONTRAR-VENDEDOR
           IF  W-VOLTAR                EQUAL "N"
               PERFORM 4300-GRAVAR-REGISTRO
               IF  NOT FS-OK
                   MOVE "S"            TO W-VOLTAR
               ELSE
                   PERFORM 7153-LER-PROX-ARQ-CLIE
                   IF  NOT FS-OK AND NOT FS-FIM
                       MOVE "S"        TO W-VOLTAR
                  END-IF
               END-IF
           END-IF.

      *----------------------------------------------------------------*
       1100-99-FIM.                   EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       1110-ENCONTRAR-VENDEDOR.
      *----------------------------------------------------------------*

           MOVE 9999999999,99999999 TO W-DIST-VEND-ANTERIOR

           PERFORM 7211-ABRIR-INPUT-ARQ-VEND
           IF  NOT FS-OK
               MOVE "S"                TO W-VOLTAR
           ELSE
               PERFORM 7253-LER-PROX-ARQ-VEND
               IF  NOT FS-OK
                   MOVE "S"            TO W-VOLTAR
               END-IF
           END-IF

           PERFORM UNTIL FS-FIM OR  W-VOLTAR EQUAL "S"
               PERFORM 5100-CALCULAR-DISTANCIA

               IF  W-DIST-VEND-ANTERIOR GREATER
                   W-DIST-VEND-ATUAL

                   MOVE REG-ARQ-VENDEDOR
                                       TO REG-DIST-VENDEDOR
                   MOVE VEND-CODIGO    TO W-RELAT-VEND-COD
                   MOVE VEND-RAZAO-SOCIAL
                                       TO W-RELAT-VEND-RAZAO
                   MOVE W-DIST-VEND-ATUAL
                                       TO W-DISTANCIA
                                          DIST-DISTANCIA
                   MOVE W-DIST-VEND-ATUAL
                                       TO W-DIST-VEND-ANTERIOR
               END-IF

               PERFORM 7253-LER-PROX-ARQ-VEND
               IF  NOT FS-OK AND  NOT FS-FIM
                   MOVE "S"            TO W-VOLTAR
               END-IF

           END-PERFORM

           PERFORM 7290-FECHAR-ARQ-VEND.

      *----------------------------------------------------------------*
       1000-99-FIM.                   EXIT.
      *----------------------------------------------------------------*

      ******************************************************************
      * ROTINAS AUXILIARES
      ******************************************************************
      *----------------------------------------------------------------*
       2100-ABRIR-ARQUIVOS.
      *----------------------------------------------------------------*
      * Validar arquivo de clientes
           IF  W-VOLTAR                EQUAL "N"
               PERFORM 7111-ABRIR-INPUT-ARQ-CLIE
               IF  NOT FS-OK
                   MOVE "S"            TO W-VOLTAR
                   IF  NOT FS-ARQ-NAO-ENCONTRADO
                       PERFORM 7190-FECHAR-ARQ-CLIE
                   END-IF
               ELSE
                   PERFORM 7153-LER-PROX-ARQ-CLIE
                   IF  FS-FIM
                       MOVE "S"            TO W-VOLTAR
                       MOVE  "Arquivo clientes vazio, Tecle <Enter>"
                                           TO  W-MSGERRO
                       PERFORM 8500-MOSTRA-AVISO
                   END-IF
                   PERFORM 7190-FECHAR-ARQ-CLIE
               END-IF
           END-IF

      * Validar arquivo de vendedores
           IF  W-VOLTAR    EQUAL "N"
               PERFORM 7211-ABRIR-INPUT-ARQ-VEND
               IF  NOT FS-OK
                   MOVE "S"            TO W-VOLTAR
                   IF  NOT FS-ARQ-NAO-ENCONTRADO
                       PERFORM 7290-FECHAR-ARQ-VEND
                   END-IF
               ELSE
                   PERFORM 7253-LER-PROX-ARQ-VEND
                   IF  FS-FIM
                       MOVE "S"        TO W-VOLTAR
                       MOVE  "Arquivo clientes vazio, Tecle <Enter>"
                                       TO  W-MSGERRO
                       PERFORM 8500-MOSTRA-AVISO
                   END-IF
                   PERFORM 7290-FECHAR-ARQ-VEND
               END-IF
           END-IF

           IF  W-VOLTAR    EQUAL "N"
               PERFORM 7510-ABRIR-ARQ-RELATO
               IF  NOT FS-OK
                   MOVE "S"            TO W-VOLTAR
                   PERFORM 7590-FECHAR-ARQ-RELATO
               END-IF
           END-IF

           IF  W-VOLTAR    EQUAL "N"
               PERFORM 7610-ABRIR-ARQ-DIST
               IF  NOT FS-OK
                   MOVE "S"            TO W-VOLTAR
                   PERFORM 7590-FECHAR-ARQ-RELATO
                   PERFORM 7690-FECHAR-ARQ-DIST
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

           MOVE  W-REG-ARQ-RELATO      TO REG-ARQ-RELATO
           PERFORM 7560-GRAVAR-ARQ-RELATO.
           IF  NOT FS-OK
               MOVE "S"                TO W-VOLTAR
           ELSE
               PERFORM 7660-GRAVAR-ARQ-DIST
               IF  NOT FS-OK
                   MOVE "S"            TO W-VOLTAR.

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
