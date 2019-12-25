      *================================================================*
       IDENTIFICATION              DIVISION.
      *================================================================*
       PROGRAM-ID. GCC041P.
      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos         *
      *    PROGRAMA....: GCC041P                                       *
      *    AUTHOR......: Leo Ribeiro e Silva Santos                    *
      *    DATA........: 18/12/2019                                    *
      *    OBJETIVO ...: Importacao arquivo clientes                   *
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
      * Arquivo Importacao
       COPY ".\copybooks\GCC021FC".

      *================================================================*
       DATA                            DIVISION.
      *================================================================*
       FILE                            SECTION.

      * Arquivo Clientes
       COPY ".\copybooks\GCC011FD".
      * Arquivo importacao
       COPY ".\copybooks\GCC021FD".

      *----------------------------------------------------------------*
       WORKING-STORAGE                 SECTION.
      *----------------------------------------------------------------*
      * Campos uso comum
       COPY ".\copybooks\GCC000W".

      *----------------------------------------------------------------*
       LINKAGE                         SECTION.
      *----------------------------------------------------------------*
       COPY ".\copybooks\GCC000L".

      *----------------------------------------------------------------*
       SCREEN                          SECTION.
      *----------------------------------------------------------------*
      * Copybook tela principal
       COPY ".\copybooks\GCC000S".
      * Copybook tela importacao
       COPY ".\copybooks\GCC041S".
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

           SET ENVIRONMENT 'COB_SCREEN_EXCEPTIONS' TO 'Y'.
           SET ENVIRONMENT 'COB_SCREEN_ESC'        TO 'Y'.
           SET ENVIRONMENT 'ESCDELAY'              TO '25'.

           PERFORM UNTIL W-FIM EQUAL "S"
               MOVE WID-ARQ-IMP-CLIE   TO  S-ARQ-IMP-CLI
               MOVE "Importacao Cliente"
                                       TO  W-MODULO
               MOVE "<Esc> Voltar <Enter> Processar"
                                   TO W-STATUS
               DISPLAY S-CLS
               DISPLAY S-TELA-IMPORTA

               ACCEPT S-ARQ-IMP-CLI
               IF COB-CRT-STATUS NOT EQUAL COB-SCR-ESC
                   PERFORM 0100-PROCESSAR
               END-IF
               GOBACK
           END-PERFORM.

      *----------------------------------------------------------------*
       0000-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       0100-PROCESSAR                  SECTION.
      *----------------------------------------------------------------*

           INITIALIZE W-CONTADORES

           MOVE  WID-ARQ-IMP-CLIE      TO W-ARQ-IMPORTA
           PERFORM 7611-ABRIR-ARQ-IMPORTA-INPUT
           IF  FS-OK
               PERFORM 7110-ABRIR-ARQ-CLIE
               IF FS-OK
                   DISPLAY S-TELA-CONTADOR

                   PERFORM 7650-LER-PROX-ARQ-IMPORTA
                   PERFORM UNTIL FS-FIM
                          ADD 1       TO W-LIDOS
                          DISPLAY S-LIDOS
                          MOVE  IMPT-CODIGO
                                       TO CLIE-CODIGO
                          MOVE  IMPT-CNPJ
                                       TO CLIE-CNPJ
                          MOVE  IMPT-RAZAO-SOCIAL
                                       TO CLIE-RAZAO-SOCIAL
                          MOVE  IMPT-LATITUDE
                                       TO CLIE-LATITUDE
                          MOVE  IMPT-LONGITUDE
                                       TO CLIE-LONGITUDE

                          WRITE REG-ARQ-CLIENTE
                          IF FS-OK
      *     Melhoria: Adcionar log de erros nesse ponto
                              ADD 1    TO W-GRAVADOS
                          ELSE
                              ADD 1    TO W-ERROS
                          END-IF

                          PERFORM 7650-LER-PROX-ARQ-IMPORTA

                          MOVE W-ERROS TO S-ERROS
                          MOVE W-LIDOS TO S-LIDOS
                          MOVE W-GRAVADOS
                                       TO S-GRAVADOS
                          DISPLAY S-TELA-CONTADOR
                   END-PERFORM

                   PERFORM 7190-FECHAR-ARQ-CLIE
                   PERFORM 7690-FECHAR-ARQ-IMPORTA

                   MOVE  "Importacao finalizada, tecle <Enter>"
                                           TO W-MSGERRO
                   PERFORM 8500-MOSTRA-AVISO
               END-IF
           END-IF.

      *----------------------------------------------------------------*
       0100-99-FIM.                   EXIT.
      *----------------------------------------------------------------*

      ******************************************************************
      * ROTINAS AUXILIARES
      ******************************************************************

      * Rotinas arquivo clientes
       COPY ".\copybooks\GCC011R".

      * Rotinas tela principal
       COPY ".\copybooks\GCC000R".

      * Rotinas relatorio e importacao
       COPY ".\copybooks\GCC021R".
