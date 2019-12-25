      *================================================================*
       IDENTIFICATION              DIVISION.
      *================================================================*
       PROGRAM-ID. GCC042P.
      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos         *
      *    PROGRAMA....: GCC042P                                       *
      *    AUTHOR......: Leo Ribeiro e Silva Santos                    *
      *    DATA........: 18/12/2019                                    *
      *    OBJETIVO ...: Importacao arquivo vendedores                 *
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

      * Arquivo Vendedores
       COPY ".\copybooks\GCC012FC".
      * Arquivo Importacao
       COPY ".\copybooks\GCC022FC".

      *================================================================*
       DATA                            DIVISION.
      *================================================================*
       FILE                            SECTION.

      * Arquivo Vendedores
       COPY ".\copybooks\GCC012FD".
      * Arquivo importacao
       COPY ".\copybooks\GCC022FD".

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
       COPY ".\copybooks\GCC042S".
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
               MOVE WID-ARQ-IMP-VEND   TO  S-ARQ-IMP-VEND
               MOVE "Importacao Vendedores"
                                       TO  W-MODULO
               MOVE "<Esc> Voltar <Enter> Processar"
                                   TO W-STATUS
               DISPLAY S-CLS
               DISPLAY S-TELA-IMPORTA

               ACCEPT S-ARQ-IMP-VEND
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

           MOVE  WID-ARQ-IMP-VEND      TO W-ARQ-IMPORTA
           PERFORM 7611-ABRIR-ARQ-IMPORTA-INPUT
           IF  FS-OK
               PERFORM 7210-ABRIR-ARQ-VEND
               IF FS-OK
                   DISPLAY S-TELA-CONTADOR

                   PERFORM 7650-LER-PROX-ARQ-IMPORTA
                   PERFORM UNTIL FS-FIM
                          ADD 1       TO W-LIDOS
                          DISPLAY S-LIDOS
                          MOVE  IMPT-CODIGO
                                       TO VEND-CODIGO
                          MOVE  IMPT-CPF
                                       TO VEND-CPF
                          MOVE  IMPT-RAZAO-SOCIAL
                                       TO VEND-RAZAO-SOCIAL
                          MOVE  IMPT-LATITUDE
                                       TO VEND-LATITUDE
                          MOVE  IMPT-LONGITUDE
                                       TO VEND-LONGITUDE

                          WRITE REG-ARQ-VENDEDOR
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

                   PERFORM 7290-FECHAR-ARQ-VEND
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

      * Rotinas arquivo vendedores
       COPY ".\copybooks\GCC012R".

      * Rotinas tela principal
       COPY ".\copybooks\GCC000R".

      * Rotinas relatorio e importacao
       COPY ".\copybooks\GCC022R".
