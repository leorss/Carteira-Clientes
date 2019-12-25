      *================================================================*
       IDENTIFICATION              DIVISION.
      *================================================================*
       PROGRAM-ID. GCC011P.
      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos         *
      *    PROGRAMA....: GCC011P                                       *
      *    AUTHOR......: Leo Ribeiro e Silva Santos                    *
      *    DATA........: 18/12/2019                                    *
      *    OBJETIVO ...: Cadastro cliente                              *
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

      *================================================================*
       DATA                            DIVISION.
      *================================================================*
       FILE                            SECTION.

      * Arquivo Clientes
       COPY ".\copybooks\GCC011FD".

      *----------------------------------------------------------------*
       WORKING-STORAGE                 SECTION.
      *----------------------------------------------------------------*
      * Campos uso comum
       COPY ".\copybooks\GCC000W".
      * Campos validacao CPF e CNPJ
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
       COPY ".\copybooks\GCC011S".
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
               MOVE "Cadastro Cliente" TO W-MODULO
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
                       CALL W-PROG-IMP-CLIE USING "*"
      *             WHEN COB-SCR-F5
      *                 CALL W-PROG-REL-CLI  USING "1"
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
               PERFORM 6120-VALIDAR-CNPJ
                                       UNTIL W-CAMPO-VALIDADO EQUAL "S"
                                         OR  W-RETORNAR       EQUAL "S"
               IF  W-CAMPO-VALIDADO  EQUAL "S"
                   ACCEPT S-CLIE-RAZAO-SOCIAL
                   ACCEPT S-CLIE-LATITUDE
                   ACCEPT S-CLIE-LONGITUDE
                   PERFORM 8100-CONFIRMA
                   IF  COB-CRT-STATUS EQUAL COB-SCR-F1
                       PERFORM 7120-INCLUIR-ARQ-CLIE
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
               ACCEPT  S-CLIE-RAZAO-SOCIAL
               ACCEPT  S-CLIE-LATITUDE
               ACCEPT  S-CLIE-LONGITUDE
               PERFORM 8100-CONFIRMA
               IF  COB-CRT-STATUS EQUAL COB-SCR-F1
                   PERFORM 7130-ALTERAR-ARQ-CLIE
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
                   PERFORM 7140-EXCLUIR-ARQ-CLIE
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

           INITIALIZE S-CLIE-CODIGO
           ACCEPT S-CLIE-CODIGO

           IF  COB-CRT-STATUS          EQUAL COB-SCR-ESC
               MOVE "S"                TO W-VOLTAR
           ELSE
               IF CLIE-CODIGO          EQUAL ZEROS
                   MOVE "Codigo invalido, tecle <Enter>"
                                           TO W-MSGERRO
                   PERFORM 8500-MOSTRA-AVISO
               ELSE
                   PERFORM 7151-LER-ARQ-CLIE-CODIGO
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
       6120-VALIDAR-CNPJ               SECTION.
      *----------------------------------------------------------------*

           MOVE "N"                    TO W-CAMPO-VALIDADO

           MOVE "<Esc> Voltar"         TO  W-STATUS
           DISPLAY S-CLS
           DISPLAY S-TELA-CAPTURA

           INITIALIZE S-CLIE-CNPJ
           ACCEPT S-CLIE-CNPJ
           IF  COB-CRT-STATUS EQUAL COB-SCR-ESC
               MOVE "S"                TO W-RETORNAR
           ELSE
               MOVE CLIE-CNPJ          TO CNPJ
               PERFORM 8210-VALIDA-CNPJ
               IF  CNPJ-VALIDO EQUAL "N"
                   MOVE "CNPJ invalido, tecle <Enter>"
                                       TO  W-MSGERRO
                   PERFORM 8500-MOSTRA-AVISO
               ELSE
                   PERFORM 7152-LER-ARQ-CLIE-CNPJ
                   IF  W-REG-ENCONTRADO EQUAL "S"
                       MOVE "CNPJ ja cadastrado, tecle <Enter>"
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

           INITIALIZE S-CLIE-CODIGO
           ACCEPT S-CLIE-CODIGO

           IF  COB-CRT-STATUS EQUAL COB-SCR-ESC
               MOVE "S"                TO W-VOLTAR
           END-IF

           IF  W-VOLTAR                EQUAL "N"  AND
               W-RETORNAR              EQUAL "N"  AND
               CLIE-CODIGO             EQUAL ZEROS
               MOVE "Codigo invalido, tecle <Enter>"
                                       TO  W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
               MOVE "S"                TO W-RETORNAR
           END-IF

           IF  W-VOLTAR                EQUAL "N" AND
               W-RETORNAR              EQUAL "N"
               PERFORM 7151-LER-ARQ-CLIE-CODIGO
               IF  W-REG-ENCONTRADO = "N"
                   MOVE "Codigo nao cadastrado, tecle <Enter>"
                                       TO  W-MSGERRO
                   PERFORM 8500-MOSTRA-AVISO
                   MOVE "S"            TO W-RETORNAR
                ELSE
                    MOVE  CLIE-CODIGO  TO S-CLIE-CODIGO
                    MOVE  CLIE-CNPJ    TO S-CLIE-CNPJ
                    MOVE  CLIE-RAZAO-SOCIAL
                                       TO S-CLIE-RAZAO-SOCIAL
                    MOVE  CLIE-LATITUDE
                                       TO S-CLIE-LATITUDE
                    MOVE  CLIE-LONGITUDE
                                       TO S-CLIE-LONGITUDE
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

      * Rotinas arquivo clientes
       COPY ".\copybooks\GCC011R".
      * Rotinas validacao CPF e CNPJ
       COPY ".\copybooks\GCC8000R".
      * Rotinas tela principal
       COPY ".\copybooks\GCC000R".
