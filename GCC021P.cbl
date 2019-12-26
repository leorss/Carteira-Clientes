      *================================================================*
       IDENTIFICATION              DIVISION.
      *================================================================*
       PROGRAM-ID. GCC021P.
      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos         *
      *    PROGRAMA....: GCC021P                                       *
      *    AUTHOR......: Leo Ribeiro e Silva Santos                    *
      *    DATA........: 21/12/2019                                    *
      *    OBJETIVO ...: Relatorio clientes                            *
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

      * Arquivo Distribuicao
       COPY ".\copybooks\GCC031FC".

      * Arquivo Clientes
       COPY ".\copybooks\GCC011FC".

      * Arquivo Vendedores
       COPY ".\copybooks\GCC012FC".

       SELECT ARQ-SORT ASSIGN TO "CLIE-SORT.TMP"
           FILE STATUS     IS  WS-RESULTADO-ACESSO.

      * Arquivo relatorio e importacao
       COPY ".\copybooks\GCC021FC".

      *================================================================*
       DATA                            DIVISION.
      *================================================================*
       FILE                            SECTION.

      * Arquivo disistribuicao
       COPY ".\copybooks\GCC031FD".

      * Arquivo Clientes
       COPY ".\copybooks\GCC011FD".

      * Arquivo Vendedores
       COPY ".\copybooks\GCC012FD".


       SD  ARQ-SORT.
       01  REG-SORT.
           05 REG-SORT-CLIENTE.
               10 SORT-CLIE-CODIGO     PIC  9(007).
               10 SORT-CLIE-CNPJ       PIC  9(014).
               10 SORT-CLIE-RAZAO-SOCIAL
                                       PIC  X(040).
               10 SORT-CLIE-LATITUDE   PIC S9(003)V9(008).
               10 SORT-CLIE-LONGITUDE  PIC S9(003)V9(008).
           05 REG-SORT-VENDEDOR.
               10 SORT-VEND-CODIGO     PIC  9(007).
               10 SORT-VEND-CPF        PIC  9(011).
               10 SORT-VEND-RAZAO-SOCIAL
                                       PIC  X(040).
               10 SORT-VEND-LATITUDE   PIC S9(003)V9(008).
               10 SORT-VEND-LONGITUDE  PIC S9(003)V9(008).
           05  SORT-DISTANCIA          PIC  9(006).

      * Arquivo Relatorio
       COPY ".\copybooks\GCC021FD".

      *----------------------------------------------------------------*
       WORKING-STORAGE                 SECTION.
      *----------------------------------------------------------------*
       77 W-COD-VEND               PIC 9(07) VALUE ZEROS.
       77 W-SEL-REGISTRO           PIC X(01) VALUE "N".

      * Campos uso comum
       COPY ".\copybooks\GCC000W".

       01  W-FILTROS.
           05 W-ORDENACAO          PIC X(01).
              88 W-ORDENACAO-VALIDA       VALUE "A" "a" "D" "d".
              88 W-ORDENACAO-ASC          VALUE "A" "a".
              88 W-ORDENACAO-DES          VALUE "D" "d".
           05 W-CLASSIFICACAO      PIC X(01).
              88 W-CLASSIFICACAO-VALIDA   VALUE "C" "c" "R" "r".
              88 W-CLASSIFICACAO-CLIENTE  VALUE "C" "c".
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
           05 FILLER               PIC X(68) VALUE "Relatorio clientes".
           05 FILLER               PIC X(52).
           05 FILLER               PIC X(08) VALUE "Pagina: ".
           05 W-CAB-01-PAGINA      PIC ZZZ9.

       01  W-CAB-02.
           05 FILLER               PIC X(01).
           05 FILLER               PIC X(06) VALUE "Codigo".
           05 FILLER               PIC X(01).
           05 FILLER               PIC X(18) VALUE "CNPJ".
           05 FILLER               PIC X(01).
           05 FILLER               PIC X(40) VALUE "Razao Social".
           05 FILLER               PIC X(11).
           05 FILLER               PIC X(09) VALUE "Distancia".
           05 FILLER               PIC X(01).
           05 FILLER               PIC X(08) VALUE "Vendedor".
           05 FILLER               PIC X(01).
           05 FILLER               PIC X(30) VALUE "Razao Social".

       01  W-DET-01.
           05 FILLER               PIC X(01).
           05 W-DET-01-CODIGO      PIC ZZZZZZ9.
           05 FILLER               PIC X(01).
           05 W-DET-01-CNPJ        PIC 99.999.999/9999.99.
           05 FILLER               PIC X(01).
           05 W-DET-01-RAZAO-SOCIAL
                                   PIC X(40).
           05 FILLER               PIC X(01).
           05 W-DET-01-DISTANCIA   PIC ZZZZZZZZZ9,99999999.
           05 FILLER               PIC X(01).
           05 W-DET-01-VEND-COD    PIC ZZZZZZ9.
           05 FILLER               PIC X(02).
           05 W-DET-01-VEND-RAZAO  PIC X(30).

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
       COPY ".\copybooks\GCC021S".
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

               MOVE "Relatorio Cliente"    TO W-MODULO
               MOVE WID-ARQ-REL-CLIE       TO W-ARQ-RELATO
                                              S-NOME-ARQ

               MOVE "<Esc> Voltar <Enter> Processar"
                                   TO W-STATUS
               DISPLAY S-CLS
               DISPLAY S-TELA-ACC-ARQ

               ACCEPT S-NOME-ARQ
               IF COB-CRT-STATUS NOT EQUAL COB-SCR-ESC
                   PERFORM 4100-ACC-FILTROS
                   IF  W-VOLTAR EQUAL "N"
                       PERFORM 1000-INICIALIZA
                       IF   W-VOLTAR EQUAL "N"
                            PERFORM 2000-PROCESSAR
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
      * Validar arquivo de distribuicao
           IF  W-VOLTAR    EQUAL "N"
               PERFORM 7611-ABRIR-ARQ-DIST-INPUT
               IF  NOT FS-OK
                   MOVE "S"            TO W-VOLTAR
                   IF  NOT FS-ARQ-NAO-ENCONTRADO
                       PERFORM 7690-FECHAR-ARQ-dist
                   END-IF
               ELSE
                   PERFORM 7653-LER-PROX-ARQ-DIST
                   IF  FS-FIM
                       MOVE "S"        TO W-VOLTAR
                       MOVE  "Arquivo distribuicao vazio, Tecle <Enter>"
                                       TO  W-MSGERRO
                       PERFORM 8500-MOSTRA-AVISO
                   END-IF
                   PERFORM 7690-FECHAR-ARQ-DIST
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
               IF  W-CLASSIFICACAO-CLIENTE
                   SORT ARQ-SORT ON
                   ASCENDING   KEY SORT-CLIE-CODIGO
                   INPUT PROCEDURE  IS 2100-INPUT-SORT
                   OUTPUT PROCEDURE IS 2200-OUTPUT-SORT
               ELSE
                   SORT ARQ-SORT ON
                   ASCENDING   KEY SORT-CLIE-RAZAO-SOCIAL
                   INPUT PROCEDURE  IS 2100-INPUT-SORT
                   OUTPUT PROCEDURE IS 2200-OUTPUT-SORT
               END-IF
           ELSE
               IF  W-CLASSIFICACAO-CLIENTE
                   SORT ARQ-SORT ON
                   DESCENDING  KEY SORT-CLIE-CODIGO
                   INPUT PROCEDURE  IS 2100-INPUT-SORT
                   OUTPUT PROCEDURE IS 2200-OUTPUT-SORT
               ELSE
                   SORT ARQ-SORT ON
                   DESCENDING KEY SORT-CLIE-RAZAO-SOCIAL
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

           PERFORM 7611-ABRIR-ARQ-DIST-INPUT

           PERFORM 7653-LER-PROX-ARQ-DIST

           PERFORM UNTIL NOT FS-OK
               PERFORM 2110-MOVER-CAMPOS-SORT
           END-PERFORM

           PERFORM 7690-FECHAR-ARQ-DIST.

      *----------------------------------------------------------------*
       2100-EXIT.                      EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       2110-MOVER-CAMPOS-SORT          SECTION.
      *----------------------------------------------------------------*
           MOVE "N"                    TO W-SEL-REGISTRO

           IF  W-CODIGO                EQUAL ZEROS
               IF  W-RAZAO-SOCIAL      EQUAL SPACES
                   MOVE "S"            TO W-SEL-REGISTRO
               ELSE
                   IF  CLIE-RAZAO-SOCIAL
                                       EQUAL W-RAZAO-SOCIAL
                       MOVE "S"        TO W-SEL-REGISTRO
                   END-IF
               END-IF
           ELSE
               IF  DIST-CLIE-CODIGO    EQUAL W-CODIGO
                   MOVE "S"            TO W-SEL-REGISTRO
               END-IF
           END-IF

           IF  W-COD-VEND              NOT EQUAL ZEROS
               IF  DIST-VEND-CODIGO    NOT EQUAL W-COD-VEND
                   MOVE "N"            TO W-SEL-REGISTRO
               END-IF
           END-IF

           IF  W-SEL-REGISTRO          EQUAL "S"
               RELEASE REG-SORT FROM REG-ARQ-DIST
           END-IF

           PERFORM 7653-LER-PROX-ARQ-DIST.

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

           MOVE  SORT-CLIE-CODIGO      TO W-DET-01-CODIGO
           MOVE  SORT-CLIE-CNPJ        TO W-DET-01-CNPJ
           MOVE  SORT-CLIE-RAZAO-SOCIAL
                                       TO W-DET-01-RAZAO-SOCIAL
           MOVE  SORT-DISTANCIA        TO W-DET-01-DISTANCIA
           MOVE  SORT-VEND-CODIGO      TO W-DET-01-VEND-COD
           MOVE  SORT-VEND-RAZAO-SOCIAL
                                       TO W-DET-01-VEND-RAZAO

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
                                           S-COD-VEND-DESC
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

      * Validar Cliente
           MOVE  "N"                   TO  W-REG-ENCONTRADO
           PERFORM UNTIL W-REG-ENCONTRADO EQUAL "S"
               MOVE "Codigo = 0 (Todos)"
                                       TO  S-CODIGO-DESC
               DISPLAY S-TELA-ACC-ARQ
               ACCEPT S-CODIGO
               MOVE W-CODIGO           TO CLIE-CODIGO
               IF  W-CODIGO            EQUAL ZEROS
                   MOVE "S"            TO W-REG-ENCONTRADO
                   MOVE "Todos os clientes"
                                       TO  S-CODIGO-DESC
                   DISPLAY S-TELA-ACC-ARQ
                   ACCEPT S-RAZAO-SOCIAL
               ELSE
                   MOVE W-CODIGO  TO VEND-CODIGO
                   PERFORM 7151-LER-ARQ-CLIE-CODIGO
                   IF  W-REG-ENCONTRADO EQUAL  "S"
                       MOVE SPACES     TO  S-CODIGO-DESC
                       MOVE CLIE-RAZAO-SOCIAL
                                       TO  S-RAZAO-SOCIAL
                       DISPLAY S-TELA-ACC-ARQ
                   ELSE
                       MOVE  "Cliente invalido, tecle <Enter>"
                                       TO  W-MSGERRO
                       PERFORM 8500-MOSTRA-AVISO
                   END-IF
               END-IF
           END-PERFORM.

      * Validar Vendedor
           MOVE  "N"                   TO  W-REG-ENCONTRADO
           PERFORM UNTIL W-REG-ENCONTRADO EQUAL "S"
               MOVE "Codigo = 0 (Todos)"
                                       TO  S-COD-VEND-DESC
               DISPLAY S-TELA-ACC-ARQ
               ACCEPT S-COD-VEND
               MOVE W-COD-VEND         TO VEND-CODIGO
               IF   W-COD-VEND          EQUAL ZEROS
                   MOVE "S"            TO W-REG-ENCONTRADO
                   MOVE "Todos os vendedores"
                                       TO  S-COD-VEND-DESC
                   DISPLAY S-TELA-ACC-ARQ
               ELSE
                   MOVE W-COD-VEND  TO VEND-CODIGO
                   PERFORM 7251-LER-ARQ-VEND-CODIGO
                   IF  W-REG-ENCONTRADO EQUAL  "S"
                       MOVE VEND-RAZAO-SOCIAL
                                       TO  S-COD-VEND-DESC
                       DISPLAY S-TELA-ACC-ARQ
                   ELSE
                       MOVE  "Vendedor invalido, tecle <Enter>"
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
      * Rotinas arquivo clientes
       COPY ".\copybooks\GCC011R".
      * Rotinas arquivo vendedor
       COPY ".\copybooks\GCC012R".
      * Rotinas arquivo distribuicao
       COPY ".\copybooks\GCC031R".
      * Rotinas arquivo relatorio e importacao
       COPY ".\copybooks\GCC021R".
      * Rotinas tela principal
       COPY ".\copybooks\GCC000R".
