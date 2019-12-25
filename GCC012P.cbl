      *================================================================*
       IDENTIFICATION              DIVISION.
      *================================================================*
       PROGRAM-ID. GCC012P.
      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos         *
      *    PROGRAMA....: GCC012P                                       *
      *    AUTHOR......: Leo Ribeiro e Silva Santos                    *
      *    DATA........: 18/12/2019                                    *
      *    OBJETIVO ...: Cadastro vendedores                           *
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

      * Arquivo vendedoress
       COPY ".\copybooks\GCC012FC".

      *================================================================*
       DATA                            DIVISION.
      *================================================================*
       FILE                            SECTION.

      * Arquivo vendedoress
       COPY ".\copybooks\GCC012FD".

      *----------------------------------------------------------------*
       WORKING-STORAGE                 SECTION.
      *----------------------------------------------------------------*
      * Campos uso comum
       COPY ".\copybooks\GCC000W".
      * Campos validacao CPF e CPF
       COPY ".\copybooks\GCC8000W".

      *----------------------------------------------------------------*
       LINKAGE                         SECTION.
      *----------------------------------------------------------------*
       COPY ".\copybooks\GCC000L".

      *----------------------------------------------------------------*
       SCREEN                          SECTION.
      *----------------------------------------------------------------*
      * Copybook telas
       COPY ".\copybooks\GCC000S".
       COPY ".\copybooks\GCC012S".
      *
       COPY screenio.

      *================================================================*
       PROCEDURE                       DIVISION USING LK-PARAM.
      *================================================================*

      *----------------------------------------------------------------*
      *    ROTINA PRINCIPAL DO PROGRAMA.                               *
      *----------------------------------------------------------------*
       0000-MENU                       SECTION.
      *----------------------------------------------------------------*
           SET ENVIRONMENT 'COB_SCREEN_EXCEPTIONS' TO 'Y'.
           SET ENVIRONMENT 'COB_SCREEN_ESC'        TO 'Y'.
           SET ENVIRONMENT 'ESCDELAY'              TO '25'.

           PERFORM UNTIL W-FIM EQUAL "S"
               MOVE "N"                TO W-VOLTAR
               INITIALIZE S-TELA-CAPTURA
               MOVE "Cadastro Vendedores" TO W-MODULO
               MOVE "<Esc> Sair <F1> Incluir <F2> Alterar <F3> Excluir <
      -             "F4> Importar"     TO W-STATUS
               MOVE " "                TO W-OP
               MOVE SPACES             TO W-OPCAO
               DISPLAY S-CLS
               DISPLAY S-TELA-CAPTURA
               ACCEPT  S-OPCAO
               EVALUATE COB-CRT-STATUS
                   WHEN COB-SCR-F1
                       PERFORM 1000-INCLUIR UNTIL W-VOLTAR = "S"
                   WHEN COB-SCR-F2
                       PERFORM 2000-ALTERAR UNTIL W-VOLTAR = "S"
                   WHEN COB-SCR-F3
                       PERFORM 3000-EXCLUIR UNTIL W-VOLTAR = "S"
                   WHEN COB-SCR-F4
                       CALL W-PROG-IMP-VEND USING "*"
      *             WHEN COB-SCR-F5
      *                 CALL W-PROG-REL-VEN  USING "1"
                   WHEN COB-SCR-ESC
                       GOBACK
               END-EVALUATE
           END-PERFORM.

      *----------------------------------------------------------------*
       0000-99-FIM.                   EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       1000-INCLUIR                   SECTION.
      *----------------------------------------------------------------*

           INITIALIZE  S-TELA-CAPTURA
           MOVE "[Incluir]"            TO W-OP
           MOVE SPACES                 TO W-OPCAO
           DISPLAY S-CLS
           DISPLAY S-TELA-CAPTURA

           MOVE  "N"                   TO  W-CAMPO-VALIDADO
           PERFORM 6110-VALIDAR-CODIGO
                                     UNTIL W-CAMPO-VALIDADO EQUAL "S"
                                       OR  W-VOLTAR         EQUAL "S"

           IF  W-VOLTAR                EQUAL "N"
               MOVE  "N"               TO  W-RETORNAR
               MOVE  "N"               TO  W-CAMPO-VALIDADO
               PERFORM 6120-VALIDAR-CPF
                                       UNTIL W-CAMPO-VALIDADO EQUAL "S"
                                         OR  W-RETORNAR       EQUAL "S"
               IF  W-CAMPO-VALIDADO  EQUAL "S"
                   ACCEPT S-VEND-RAZAO-SOCIAL
                   ACCEPT S-VEND-LATITUDE
                   ACCEPT S-VEND-LONGITUDE
                   PERFORM 8100-CONFIRMA
                   IF  COB-CRT-STATUS EQUAL COB-SCR-F1
                       PERFORM 7220-INCLUIR-ARQ-VEND
                   END-IF
               END-IF
           END-IF.

      *----------------------------------------------------------------*
       1000-99-FIM.                   EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       2000-ALTERAR                 SECTION.
      *----------------------------------------------------------------*
=
           INITIALIZE  S-TELA-CAPTURA
           MOVE "[Alterar]"            TO W-OP
           MOVE SPACES                 TO W-OPCAO
           DISPLAY S-CLS
           DISPLAY S-TELA-CAPTURA

           MOVE  "N"                    TO  W-CAMPO-VALIDADO
           PERFORM 6200-BUSCAR-CAMPOS UNTIL W-CAMPO-VALIDADO EQUAL "S"
                                        OR  W-VOLTAR         EQUAL "S"

           IF  W-CAMPO-VALIDADO        EQUAL "S"
               DISPLAY S-TELA-CAPTURA
               ACCEPT  S-VEND-RAZAO-SOCIAL
               ACCEPT  S-VEND-LATITUDE
               ACCEPT  S-VEND-LONGITUDE
               PERFORM 8100-CONFIRMA
               IF  COB-CRT-STATUS EQUAL COB-SCR-F1
                   PERFORM 7230-ALTERAR-ARQ-VEND
               END-IF
           END-IF.

      *----------------------------------------------------------------*
       2000-99-FIM.                   EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       3000-EXCLUIR                   SECTION.
      *----------------------------------------------------------------*

           INITIALIZE  S-TELA-CAPTURA
           MOVE "[Excluir]"            TO W-OP
           MOVE SPACES                 TO W-OPCAO
           DISPLAY S-CLS
           DISPLAY S-TELA-CAPTURA

           MOVE "N"                    TO   W-CAMPO-VALIDADO
           PERFORM 6200-BUSCAR-CAMPOS UNTIL W-CAMPO-VALIDADO EQUAL "S"
                                        OR  W-VOLTAR         EQUAL "S"

           IF  W-CAMPO-VALIDADO        EQUAL "S"
               PERFORM 8100-CONFIRMA
               IF  COB-CRT-STATUS EQUAL COB-SCR-F1
                   INITIALIZE S-TELA-CAPTURA
                   DISPLAY S-TELA-CAPTURA
                   PERFORM 7240-EXCLUIR-ARQ-VEND
               END-IF
           END-IF.

      *----------------------------------------------------------------*
       3000-99-FIM.                   EXIT.
      *----------------------------------------------------------------*

      ******************************************************************
      * ROTINAS AUXILIARES
      ******************************************************************

      *----------------------------------------------------------------*
       6110-VALIDAR-CODIGO              SECTION.
      *----------------------------------------------------------------*

           MOVE "<Esc> Voltar"        TO  W-STATUS
           DISPLAY S-CLS
           DISPLAY S-TELA-CAPTURA

           INITIALIZE S-VEND-CODIGO
           ACCEPT S-VEND-CODIGO

           IF  COB-CRT-STATUS          EQUAL COB-SCR-ESC
               MOVE "S"                TO W-VOLTAR
           ELSE
               IF VEND-CODIGO          EQUAL ZEROS
                   MOVE "Codigo invalido, tecle <Enter>"
                                           TO W-MSGERRO
                   PERFORM 8500-MOSTRA-AVISO
               ELSE
                   PERFORM 7251-LER-ARQ-VEND-CODIGO
                   IF  W-REG-ENCONTRADO EQUAL "S"
                       MOVE "Codigo ja cadastrado, tecle <Enter>"
                                           TO  W-MSGERRO
                       PERFORM 8500-MOSTRA-AVISO
                   ELSE
                       MOVE "S"    TO  W-CAMPO-VALIDADO
                   END-IF
               END-IF
           END-IF.

      *----------------------------------------------------------------*
       6110-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       6120-VALIDAR-CPF               SECTION.
      *----------------------------------------------------------------*

           MOVE "N"                    TO W-CAMPO-VALIDADO

           MOVE "<Esc> Voltar"         TO  W-STATUS
           DISPLAY S-CLS
           DISPLAY S-TELA-CAPTURA

           INITIALIZE S-VEND-CPF
           ACCEPT S-VEND-CPF
           IF  COB-CRT-STATUS EQUAL COB-SCR-ESC
               MOVE "S"                TO W-RETORNAR
           ELSE
               MOVE VEND-CPF           TO CPF-RECEBIDO
               PERFORM 8110-VALIDA-CPF
               IF  CPF-VALIDO EQUAL "N"
                   MOVE "CPF invalido, tecle <Enter>"
                                       TO  W-MSGERRO
                   PERFORM 8500-MOSTRA-AVISO
               ELSE
                   PERFORM 7252-LER-ARQ-VEND-CPF
                   IF  W-REG-ENCONTRADO EQUAL "S"
                       MOVE "CPF ja cadastrado, tecle <Enter>"
                                       TO  W-MSGERRO
                       PERFORM 8500-MOSTRA-AVISO
                   ELSE
                       MOVE "S"        TO W-CAMPO-VALIDADO
                   END-IF
              END-IF
           END-IF.

      *----------------------------------------------------------------*
       6120-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       6200-BUSCAR-CAMPOS              SECTION.
      *----------------------------------------------------------------*

           MOVE "N"                    TO W-CAMPO-VALIDADO
           MOVE "N"                    TO W-RETORNAR

           MOVE "<Esc> Voltar"        TO  W-STATUS
           DISPLAY S-CLS
           DISPLAY S-TELA-CAPTURA

           INITIALIZE S-VEND-CODIGO
           ACCEPT S-VEND-CODIGO

           IF  COB-CRT-STATUS EQUAL COB-SCR-ESC
               MOVE "S"                TO W-VOLTAR
           END-IF

           IF  W-VOLTAR                EQUAL "N"  AND
               W-RETORNAR              EQUAL "N"  AND
               VEND-CODIGO             EQUAL ZEROS
               MOVE "Codigo invalido, tecle <Enter>"
                                       TO  W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
               MOVE "S"                TO W-RETORNAR
           END-IF

           IF  W-VOLTAR                EQUAL "N" AND
               W-RETORNAR              EQUAL "N"
               PERFORM 7251-LER-ARQ-VEND-CODIGO
               IF  W-REG-ENCONTRADO = "N"
                   MOVE "Codigo nao cadastrado, tecle <Enter>"
                                       TO  W-MSGERRO
                   PERFORM 8500-MOSTRA-AVISO
                   MOVE "S"            TO W-RETORNAR
                ELSE
                    MOVE  VEND-CODIGO  TO S-VEND-CODIGO
                    MOVE  VEND-CPF     TO S-VEND-CPF
                    MOVE  VEND-RAZAO-SOCIAL
                                       TO S-VEND-RAZAO-SOCIAL
                    MOVE  VEND-LATITUDE
                                       TO S-VEND-LATITUDE
                    MOVE  VEND-LONGITUDE
                                       TO S-VEND-LONGITUDE
                    DISPLAY S-TELA-CAPTURA
               END-IF
           END-IF

           IF  W-VOLTAR                EQUAL "N"  AND
               W-RETORNAR              EQUAL "N"
               MOVE "S"                TO  W-CAMPO-VALIDADO
           END-IF.

      *----------------------------------------------------------------*
       6200-99-FIM.                   EXIT.
      *----------------------------------------------------------------*

      * Rotinas arquivo vendedoress
       COPY ".\copybooks\GCC012R".
      * Rotinas validacao CNPJ e CPF
       COPY ".\copybooks\GCC8000R".
      * Rotinas tela principal
       COPY ".\copybooks\GCC000R".
