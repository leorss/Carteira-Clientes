      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos
      *    AUTHOR......: Leo Ribeiro e Silva Santos
      *    DATA........: 18/12/2019
      *    OBJETIVO ...: Campos para uso comum entre os programas
      *================================================================*
       77  W-PROGRAMA                  PIC X(08) VALUE SPACES.
       77  W-FUNCAO                    PIC X(07) VALUE SPACES.
       77  W-FIM                       PIC X(01) VALUE "N".
       77  W-RETORNAR                  PIC X(01) VALUE "N".
       77  W-VOLTAR                    PIC X(01) VALUE "N".
       77  W-GRAVADO                   PIC X(01) VALUE "N".
       77  W-REG-ENCONTRADO            PIC X(01) VALUE "N".
       77  W-CAMPO-VALIDADO            PIC X(01) VALUE "N".
       77  W-PARAM-IMPORTA             PIC X(01) VALUE "1".
       77  W-PARAM-RELATO              PIC X(01) VALUE "2".

      *----------------------------------------------------------------*
      * File Status
      *----------------------------------------------------------------*
       77 WS-RESULTADO-ACESSO          PIC X(02).
           88 FS-OK                    VALUE "00".
           88 FS-ARQ-NAO-ENCONTRADO    VALUE "35".
           88 FS-FIM                   VALUE "10".
           88 FS-REG-ENCONTRADO        VALUE "23".
           88 FS-ERRO-LAYOUT           VALUE "39".
           88 FS-CANCELA               VALUE "99".

      *----------------------------------------------------------------*
       01  W-SCREEN.
      *----------------------------------------------------------------*
           05  W-OPCAO                 PIC X(01) VALUE SPACE.
           05  W-MENSAGEM              PIC X(77) VALUE SPACES.
           05  W-MSG-RESPOSTA          PIC X(01) VALUE SPACES.
           05  W-COR-FUNDO             PIC 9(01) VALUE 1.
           05  W-COR-FRENTE            PIC 9(01) VALUE 6.
           05  W-STATUS                PIC X(70).
           05  W-MSGERRO               PIC X(80).
           05  W-NUML                  PIC 9(03).
           05  W-NUMC                  PIC 9(03).
           05  W-ERRO                  PIC X(01).
           88  E-SIM                            VALUES ARE "S" "s".

      *----------------------------------------------------------------*
       01 W-MODULO.
      *----------------------------------------------------------------*
           05 FILLER                   PIC X(20) VALUE SPACES.
           05 W-OP                     PIC X(11) VALUE SPACES.

      *----------------------------------------------------------------*
       01  W-ARQUIVOS.
      *----------------------------------------------------------------*
           05  WID-ARQ-CLIENTE      PIC X(40) VALUE "ARQ-CLIENTE.DAT".
           05  WID-ARQ-VENDEDOR     PIC X(40) VALUE "ARQ-VENDEDOR.DAT".
           05  WID-ARQ-DIST         PIC X(40) VALUE "ARQ-DIST.DAT".
           05  WID-ARQ-IMP-CLIE     PIC X(40) VALUE "ARQ-IMP-CLIE.txt".
           05  WID-ARQ-IMP-VEND     PIC X(40) VALUE "ARQ-IMP-VEND.txt".
           05  WID-ARQ-REL-CLIE     PIC X(40) VALUE "RELATO-CLIE.txt".
           05  WID-ARQ-REL-VEND     PIC X(40) VALUE "RELATO-VEND.txt".
           05  WID-ARQ-DISTRIBUICAO PIC X(40) VALUE "REL-DIST.csv".
           05  W-ARQ-RELATO         PIC X(40) VALUE SPACES.
           05  W-ARQ-IMPORTA        PIC X(40) VALUE SPACES.

      *----------------------------------------------------------------*
       01  W-PROGRAMAS.
      *----------------------------------------------------------------*
      * Cadastro Cliente
           05 W-PROG-CAD-CLI           PIC X(11) VALUE "GCC011P".
      * Cadastro Vendedor
           05 W-PROG-CAD-VEN           PIC X(11) VALUE "GCC012P".
      * Relatorio Cliente
           05 W-PROG-REL-CLI           PIC X(11) VALUE "GCC021P".
      * Relatorio Vendedor
           05 W-PROG-REL-VEND          PIC X(11) VALUE "GCC022P".
      * Distribuicoa Clientes
           05 W-PROG-EXE-DIS           PIC X(11) VALUE "GCC030P".
      * Importar arquivo cliente
           05 W-PROG-IMP-CLIE          PIC X(08) VALUE "GCC041P".
      * Importar arquivo vendedor
           05 W-PROG-IMP-VEND          PIC X(08) VALUE "GCC042P".

      *----------------------------------------------------------------*
       01  W-CONTADORES.
      *----------------------------------------------------------------*
           05  W-LIDOS                 PIC 9(10) VALUE ZEROS.
           05  W-GRAVADOS              PIC 9(10) VALUE ZEROS.
           05  W-ERROS                 PIC 9(10) VALUE ZEROS.
