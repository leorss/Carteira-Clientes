      *================================================================*
       IDENTIFICATION              DIVISION.
      *================================================================*
       PROGRAM-ID. GCC022P.
      *================================================================*
      *    MODULO......: Carteira de clientes Vendedores Novos         *
      *    PROGRAMA....: GCC021P                                       *
      *    AUTHOR......: Leo Ribeiro e Silva Santos                    *
      *    DATA........: 22/12/2019                                    *
      *    OBJETIVO ...: Relatorio vendedores                          *
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

      * Arquivo vendedores
       COPY ".\copybooks\GCC012FC".

       SELECT ARQ-SORT ASSIGN TO "VEND-SORT.TMP"
           FILE STATUS     IS  WS-RESULTADO-ACESSO.

      * Arquivo relatorio e importacao
       COPY ".\copybooks\GCC021FC".

      *================================================================*
       DATA                            DIVISION.
      *================================================================*
       FILE                            SECTION.

      * Arquivo vendedores
       COPY ".\copybooks\GCC012FD".

       SD  ARQ-SORT.
       01  REG-SORT.
           05  SORT-CODIGO             PIC  9(007).
           05  SORT-CPF                PIC  9(011).
           05  SORT-RAZAO-SOCIAL       PIC  X(040).
           05  SORT-LATITUDE           PIC S9(003)V9(008).
           05  SORT-LONGITUDE          PIC S9(003)V9(008).

      * Arquivo Relatorio
       COPY ".\copybooks\GCC021FD".

      *----------------------------------------------------------------*
       WORKING-STORAGE                 SECTION.
      *----------------------------------------------------------------*
      * Campos uso comum
       COPY ".\copybooks\GCC000W".

       01  W-FILTROS.
           05 W-ORDENACAO          PIC X(01).
              88 W-ORDENACAO-VALIDA       VALUE "A" "a" "D" "d".
              88 W-ORDENACAO-ASC          VALUE "A" "a".
              88 W-ORDENACAO-DES          VALUE "D" "d".
           05 W-CLASSIFICACAO      PIC X(01).
              88 W-CLASSIFICACAO-VALIDA   VALUE "C" "c" "R" "r".
              88 W-CLASSIFICACAO-VENDEDOR  VALUE "C" "c".
              88 W-CLASSIFICACAO-RAZAO    VALUE "R" "r".
           05 W-CODIGO             PIC 9(07) VALUE ZEROS.
           05 W-RAZAO-SOCIAL       PIC X(40) VALUE SPACES.

       01  W-CAMPOS-RELATORIO.
           05  W-CONTADOR          PIC 9(004) VALUE 0.
           05  W-PAGINAS           PIC 9(004) VALUE 0.
           05  W-LINHAS            PIC 9(002) VALUE 0.
           05  W-TRACOS-1          PIC X(132) VALUE ALL "=".
           05  W-TRACOS-2          PIC X(132) VALUE ALL "-".

       01  W-CAB-01.
           05 FILLER             PIC X(68) VALUE "Relatorio Vendedores".
           05 FILLER             PIC X(52).
           05 FILLER             PIC X(08) VALUE "Pagina: ".
           05 W-CAB-01-PAGINA    PIC ZZZ9.

       01  W-CAB-02.
           05 FILLER               PIC X(04).
           05 FILLER               PIC X(06) VALUE "Codigo".
           05 FILLER               PIC X(03).
           05 FILLER               PIC X(18) VALUE "CPF".
           05 FILLER               PIC X(03).
           05 FILLER               PIC X(40) VALUE "Razao Social".
           05 FILLER               PIC X(03).
           05 FILLER               PIC X(12) VALUE "Latitude".
           05 FILLER               PIC X(04).
           05 FILLER               PIC X(12) VALUE "Longitude".

       01  W-DET-01.
           05 FILLER               PIC X(03).
           05 W-DET-01-CODIGO      PIC ZZZZZZ9.
           05 FILLER               PIC X(06).
           05 W-DET-01-CPF         PIC 999.999.999.99.
           05 FILLER               PIC X(07).
           05 W-DET-01-RAZAO-SOCIAL
                                   PIC X(40).
           05 FILLER               PIC X(03).
           05 W-DET-01-LATITUDE    PIC -ZZ9,99999999.
           05 FILLER               PIC X(03).
           05 W-DET-01-LONGITUDE   PIC -ZZ9,99999999.

       01  W-ROD-01.
           05 FILLER               PIC X(10).
           05 FILLER               PIC X(30)
              VALUE "           Total registros  : ".
           05 W-ROD-TOTAL          PIC ZZ.ZZ9.

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
       COPY ".\copybooks\GCC022S".
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

               MOVE "Relatorio Vendedores"
                                           TO W-MODULO
               MOVE WID-ARQ-REL-VEND       TO W-ARQ-RELATO
                                              S-NOME-ARQ

               MOVE "<Esc> Voltar <Enter> Processar"
                                   TO W-STATUS
               DISPLAY S-CLS
               DISPLAY S-TELA-ACC-ARQ

               ACCEPT S-NOME-ARQ
               IF COB-CRT-STATUS NOT EQUAL COB-SCR-ESC
                   IF   W-VOLTAR EQUAL "N"
                       PERFORM 4100-ACC-FILTROS
                       IF  W-VOLTAR EQUAL "N"
                           PERFORM 1000-INICIALIZA
                           IF   W-VOLTAR EQUAL "N"
                                PERFORM 2000-PROCESSAR
                           END-IF
                      END-IF
                   END-IF
               END-IF

               GOBACK
           END-PERFORM.

      *----------------------------------------------------------------*
       0000-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       1000-INICIALIZA                 SECTION.
      *----------------------------------------------------------------*
           MOVE "N"                    TO      W-VOLTAR

           PERFORM 7211-ABRIR-INPUT-ARQ-VEND
           IF  NOT FS-OK
               MOVE "S"                TO W-VOLTAR
               IF  NOT FS-ARQ-NAO-ENCONTRADO
                   PERFORM 7290-FECHAR-ARQ-VEND
               END-IF
           END-IF.

      *----------------------------------------------------------------*
       1000-99-FIM.                   EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       2000-PROCESSAR.
      *----------------------------------------------------------------*

           MOVE "N"                    TO W-GRAVADO
           MOVE "N"                    TO W-VOLTAR
           MOVE 0                      TO W-PAGINAS
           MOVE 0                      TO W-LINHAS

           IF  W-ORDENACAO-ASC
               IF  W-CLASSIFICACAO-VENDEDOR
                   SORT ARQ-SORT    ON ASCENDING   KEY SORT-CODIGO
                   INPUT PROCEDURE  IS 2100-INPUT-SORT
                   OUTPUT PROCEDURE IS 2200-OUTPUT-SORT
               ELSE
                   SORT ARQ-SORT    ON ASCENDING   KEY SORT-RAZAO-SOCIAL
                   INPUT PROCEDURE  IS 2100-INPUT-SORT
                   OUTPUT PROCEDURE IS 2200-OUTPUT-SORT
               END-IF
           ELSE
               IF  W-CLASSIFICACAO-VENDEDOR
                   SORT ARQ-SORT    ON DESCENDING  KEY SORT-CODIGO
                   INPUT PROCEDURE  IS 2100-INPUT-SORT
                   OUTPUT PROCEDURE IS 2200-OUTPUT-SORT
               ELSE
                   SORT ARQ-SORT    ON DESCENDING  KEY SORT-RAZAO-SOCIAL
                   INPUT PROCEDURE  IS 2100-INPUT-SORT
                   OUTPUT PROCEDURE IS 2200-OUTPUT-SORT
               END-IF
           END-IF.

      *----------------------------------------------------------------*
       2000-99-FIM.                   EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       2100-INPUT-SORT                 SECTION.
      *----------------------------------------------------------------*

           PERFORM 7253-LER-PROX-ARQ-VEND

           PERFORM UNTIL NOT FS-OK
               PERFORM 2110-MOVER-CAMPOS-SORT
           END-PERFORM

           PERFORM 7290-FECHAR-ARQ-VEND.

      *----------------------------------------------------------------*
       2100-EXIT.                      EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       2110-MOVER-CAMPOS-SORT          SECTION.
      *----------------------------------------------------------------*

           IF  W-CODIGO                EQUAL ZEROS
               IF  W-RAZAO-SOCIAL      EQUAL SPACES
                   RELEASE REG-SORT    FROM  REG-ARQ-VENDEDOR
               ELSE
                   IF  VEND-RAZAO-SOCIAL EQUAL W-RAZAO-SOCIAL
                       RELEASE REG-SORT  FROM  REG-ARQ-VENDEDOR
                   END-IF
               END-IF
           ELSE
               IF  VEND-CODIGO         EQUAL W-CODIGO
                   RELEASE REG-SORT    FROM  REG-ARQ-VENDEDOR
               END-IF
           END-IF

           PERFORM 7253-LER-PROX-ARQ-VEND.

      *----------------------------------------------------------------*
       2110-EXIT.                      EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       2200-OUTPUT-SORT                SECTION.
      *----------------------------------------------------------------*

           RETURN ARQ-SORT AT END
               MOVE "S"                TO W-VOLTAR
               MOVE  "Nao ha registros para essa busca, tecle <Enter>
      -               ""               TO  W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           END-RETURN.

           IF  W-VOLTAR EQUAL "N"
               MOVE S-NOME-ARQ         TO W-ARQ-RELATO
               PERFORM 7510-ABRIR-ARQ-RELATO
               IF  NOT FS-OK
                   PERFORM 7590-FECHAR-ARQ-RELATO
               ELSE
                   PERFORM 4310-GRAVAR-CABECALHO
                   PERFORM UNTIL NOT FS-OK
                       PERFORM 2210-GERA-RELATORIO THRU 2210-99-FIM
                   END-PERFORM
                   PERFORM 7590-FECHAR-ARQ-RELATO

                   IF  W-PAGINAS       NOT EQUAL ZEROS
                       MOVE  "Relatorio gerado, tecle <Enter>"
                                       TO  W-MSGERRO
                       PERFORM 8500-MOSTRA-AVISO
                   END-IF
               END-IF
           END-IF.

      *----------------------------------------------------------------*
       2200-EXIT.                      EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       2210-GERA-RELATORIO             SECTION.
      *----------------------------------------------------------------*

           IF  W-LINHAS         GREATER 61 OR
               W-PAGINAS        EQUAL   0
               PERFORM 4310-GRAVAR-CABECALHO
           END-IF

           ADD  1                      TO W-CONTADOR
           ADD  1                      TO W-LINHAS

           MOVE  SORT-CODIGO           TO W-DET-01-CODIGO
           MOVE  SORT-CPF              TO W-DET-01-CPF
           MOVE  SORT-RAZAO-SOCIAL     TO W-DET-01-RAZAO-SOCIAL
           MOVE  SORT-LATITUDE         TO W-DET-01-LATITUDE
           MOVE  SORT-LONGITUDE        TO W-DET-01-LONGITUDE

           WRITE REG-ARQ-RELATO  FROM W-DET-01 AFTER 1

           RETURN ARQ-SORT AT END
               MOVE "S"        TO W-VOLTAR
           END-RETURN.

      *----------------------------------------------------------------*
       2210-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      ******************************************************************
      * ROTINAS AUXILIARES
      ******************************************************************

      *----------------------------------------------------------------*
       4100-ACC-FILTROS.
      *----------------------------------------------------------------*

           INITIALIZE W-FILTROS

           MOVE SPACES                 TO  W-STATUS
           MOVE "Codigo = 0 (Todos)"   TO  S-CODIGO-DESC
           MOVE "A - Ascendente D - Decrescente"
                                       TO  S-ORDENACAO-DESC
           MOVE "C - Codigo R - Razao Social"
                                       TO  S-CLASSIFICACAO-DESC
           DISPLAY S-CLS
           DISPLAY S-TELA-ACC-ARQ

           PERFORM UNTIL W-ORDENACAO-VALIDA
               ACCEPT S-ORDENACAO
           END-PERFORM

           IF W-ORDENACAO-ASC
               MOVE "Ascendente "      TO  S-ORDENACAO-DESC
           ELSE
               MOVE "Decrescente"      TO  S-ORDENACAO-DESC
           END-IF
           DISPLAY S-TELA-ACC-ARQ

           PERFORM UNTIL W-CLASSIFICACAO-VALIDA
               ACCEPT S-CLASSIFICACAO
           END-PERFORM

           IF W-ORDENACAO-ASC
               MOVE "Por Codigo       "
                                       TO  S-CLASSIFICACAO-DESC
           ELSE
               MOVE "Por Razao Social "
                                       TO  S-CLASSIFICACAO-DESC
           END-IF
           DISPLAY S-TELA-ACC-ARQ

           MOVE  "N"                   TO  W-REG-ENCONTRADO
           PERFORM UNTIL W-REG-ENCONTRADO EQUAL "S"
               MOVE "Codigo = 0 (Todos)"
                                       TO  S-CODIGO-DESC
               DISPLAY S-TELA-ACC-ARQ
               ACCEPT S-CODIGO
               MOVE W-CODIGO           TO VEND-CODIGO
               IF  W-CODIGO            EQUAL ZEROS
                   MOVE "S"            TO W-REG-ENCONTRADO
                   MOVE "Todos os vendedores"
                                       TO  S-CODIGO-DESC
                   DISPLAY S-TELA-ACC-ARQ
                   ACCEPT S-RAZAO-SOCIAL
               ELSE
                   PERFORM 7251-LER-ARQ-VEND-CODIGO
                   IF  W-REG-ENCONTRADO EQUAL  "S"
                       MOVE SPACES     TO  S-CODIGO-DESC
                       MOVE VEND-RAZAO-SOCIAL
                                       TO  S-RAZAO-SOCIAL
                       DISPLAY S-TELA-ACC-ARQ
                   ELSE
                       MOVE  "Cliente invalido, tecle <Enter>"
                                       TO  W-MSGERRO
                       PERFORM 8500-MOSTRA-AVISO
                   END-IF
               END-IF
           END-PERFORM.

      *----------------------------------------------------------------*
       4100-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       4310-GRAVAR-CABECALHO           SECTION.
      *----------------------------------------------------------------*

           ADD  1                      TO W-PAGINAS
           MOVE 5                      TO W-LINHAS
           MOVE W-PAGINAS              TO W-CAB-01-PAGINA

           IF  W-PAGINAS               EQUAL 1
               WRITE REG-ARQ-RELATO  FROM W-TRACOS-1 AFTER 1
           ELSE
               WRITE REG-ARQ-RELATO  FROM W-TRACOS-1 AFTER PAGE
           END-IF

           WRITE REG-ARQ-RELATO  FROM W-CAB-01   AFTER 1
           WRITE REG-ARQ-RELATO  FROM W-TRACOS-1 AFTER 1
           WRITE REG-ARQ-RELATO  FROM W-CAB-02   AFTER 2
           WRITE REG-ARQ-RELATO  FROM W-TRACOS-2 AFTER 1.

      *----------------------------------------------------------------*
       4310-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       4320-GRAVAR-RODAPE              SECTION.
      *----------------------------------------------------------------*

           MOVE  W-CONTADOR      TO   W-ROD-TOTAL
           WRITE REG-ARQ-RELATO  FROM W-TRACOS-2 AFTER 1
           WRITE REG-ARQ-RELATO  FROM W-ROD-01   AFTER 1

           ADD  2                       TO W-LINHAS.

      *----------------------------------------------------------------*
       4320-99-FIM.                    EXIT.
      *----------------------------------------------------------------*
      *
      * Rotinas arquivo vendedores
       COPY ".\copybooks\GCC012R".
      * Rotinas arquivo relatorio e importacao
       COPY ".\copybooks\GCC022R".
      * Rotinas tela principal
       COPY ".\copybooks\GCC000R".
