      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos
      *    AUTHOR......: Leo Ribeiro e Silva Santos
      *    DATA........: 18/12/2019
      *    OBJETIVO ...: Tela principal
      *================================================================*

      *----------------------------------------------------------------*
       01  S-CLS.
      *----------------------------------------------------------------*
           05 SS-FILLER.
               10 BLANK SCREEN.
               10 LINE 02 COLUMN 01 ERASE EOL
                  BACKGROUND-COLOR W-COR-FUNDO.
               10 LINE 02 COLUMN 01 ERASE EOL
                  BACKGROUND-COLOR W-COR-FUNDO.
           05 SS-CABECALHO.
               10 LINE 02 COLUMN 02 PIC X(31) FROM W-MODULO
                  HIGHLIGHT FOREGROUND-COLOR W-COR-FRENTE
                            BACKGROUND-COLOR W-COR-FUNDO.
           05 S-STATUS.
               10 LINE 29 COLUMN 2 ERASE EOL PIC X(70)
                  FROM W-STATUS HIGHLIGHT
                            FOREGROUND-COLOR W-COR-FRENTE
                            BACKGROUND-COLOR W-COR-FUNDO.

      *----------------------------------------------------------------*
       01 S-ERRO.
      *----------------------------------------------------------------*
           05 FILLER FOREGROUND-COLOR 4 BACKGROUND-COLOR 1 HIGHLIGHT.
               10 LINE 29   COLUMN 2 PIC X(80) FROM W-MSGERRO BELL.
               10 COLUMN PLUS 2 TO W-ERRO.

      *----------------------------------------------------------------*
       01 S-OPCAO.
      *----------------------------------------------------------------*
           05 FILLER FOREGROUND-COLOR W-COR-FRENTE
                     BACKGROUND-COLOR W-COR-FUNDO HIGHLIGHT.
               10 LINE 29   COLUMN 2 PIC X(80) FROM W-STATUS BELL.
               10 COLUMN PLUS 2 TO W-OPCAO.


      *----------------------------------------------------------------*
       01  S-MENU.
      *----------------------------------------------------------------*
           05  LINE 06 COL 10 VALUE "Cadastros".
           05  LINE 07 COL 10 VALUE "  <F1> Cadastro de Cliente".
           05  LINE 08 COL 10 VALUE "  <F2> Cadastro de Vendedor".
           05  LINE 10 COL 10 VALUE "Relatorios".
           05  LINE 11 COL 10 VALUE "  <F3> Relatorio de Clientes".
           05  LINE 12 COL 10 VALUE "  <F4> Relatorio de Vendedores".
           05  LINE 14 COL 10 VALUE "Executar".
           05  LINE 15 COL 10 VALUE "  <F5> Executar Distribuicao de Cli
      -                             "entes".
           05 LINE 29 COL 1  USING W-OPCAO AUTO.
