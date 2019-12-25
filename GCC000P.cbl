      *================================================================*
       IDENTIFICATION              DIVISION.
      *================================================================*
       PROGRAM-ID. GCC000P.
      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos         *
      *    PROGRAMA....: GCC000P                                       *
      *    AUTHOR......: Leo Ribeiro e Silva Santos                    *
      *    DATA........: 18/12/2019                                    *
      *    OBJETIVO ...: Menu Principal                                *
      *----------------------------------------------------------------*
      *================================================================*
       ENVIRONMENT                     DIVISION.
      *================================================================*

      *----------------------------------------------------------------*
       CONFIGURATION                   SECTION.
      *----------------------------------------------------------------*

       SPECIAL-NAMES.
           DECIMAL-POINT               IS COMMA.

      *================================================================*
       DATA                            DIVISION.
      *================================================================*

      *----------------------------------------------------------------*
       WORKING-STORAGE                 SECTION.
      *----------------------------------------------------------------*

      * Campos de uso comum
       COPY ".\copybooks\GCC000W".
      *
       COPY screenio.

      *----------------------------------------------------------------*
       LINKAGE                         SECTION.
      *----------------------------------------------------------------*
       COPY ".\copybooks\GCC000L".

      *----------------------------------------------------------------*
       SCREEN                          SECTION.
      *----------------------------------------------------------------*
      * Tela principal
       COPY ".\copybooks\GCC000S".

      *================================================================*
       PROCEDURE                       DIVISION.
      *================================================================*

      *----------------------------------------------------------------*
      *    ROTINA PRINCIPAL DO PROGRAMA.                               *
      *----------------------------------------------------------------*
       0000-MENU                       SECTION.
      *----------------------------------------------------------------*

           SET ENVIRONMENT 'COB_SCREEN_EXCEPTIONS' TO 'Y'.
           SET ENVIRONMENT 'COB_SCREEN_ESC'        TO 'Y'.
           SET ENVIRONMENT 'ESCDELAY'              TO '25'.
           ACCEPT W-NUML FROM LINES
           ACCEPT W-NUMC FROM COLUMNS

           PERFORM UNTIL W-FIM EQUAL "S"
               MOVE "Menu Principal"   TO W-MODULO
               MOVE "<Esc> Sair"       TO W-STATUS
               MOVE " "                TO W-OP
               MOVE SPACES             TO W-OPCAO
               DISPLAY S-CLS
               ACCEPT S-MENU
               EVALUATE COB-CRT-STATUS
                   WHEN COB-SCR-F1 CALL W-PROG-CAD-CLI  USING "*"
                   WHEN COB-SCR-F2 CALL W-PROG-CAD-VEN  USING "*"
                   WHEN COB-SCR-F3 CALL W-PROG-REL-CLI  USING "2"
                   WHEN COB-SCR-F4 CALL W-PROG-REL-VEND USING "2"
                   WHEN COB-SCR-F5 CALL W-PROG-EXE-DIS  USING "*"
                   WHEN COB-SCR-ESC
                       MOVE "S"        TO  W-FIM
               END-EVALUATE
           END-PERFORM

           STOP RUN.

      *----------------------------------------------------------------*
       0000-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *================================================================*
      * Rotinas auxiliares
      *================================================================*

      * Rotinas tela principal
       COPY ".\copybooks\GCC000R".
