      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos
      *    AUTHOR......: Leo Ribeiro e Silva Santos
      *    DATA........: 18/12/2019
      *    OBJETIVO ...: Rotinas arquivo clientes
      *================================================================*
      *----------------------------------------------------------------*
       7110-ABRIR-ARQ-CLIE             SECTION.
      *----------------------------------------------------------------*
      *
           OPEN I-O ARQ-CLIENTE

           IF  NOT FS-OK
               IF FS-ARQ-NAO-ENCONTRADO
                   OPEN OUTPUT ARQ-CLIENTE
                   CLOSE ARQ-CLIENTE
                   OPEN I-O ARQ-CLIENTE
               ELSE
                   STRING "Erro ao abrir ARQ-CLIENTE. FS: "
                          WS-RESULTADO-ACESSO INTO W-MSGERRO
                   PERFORM 8500-MOSTRA-AVISO
               END-IF
           END-IF.

      *----------------------------------------------------------------*
       7110-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7111-ABRIR-INPUT-ARQ-CLIE       SECTION.
      *----------------------------------------------------------------*
      *
           OPEN INPUT ARQ-CLIENTE
           IF  NOT FS-OK
               IF  FS-ARQ-NAO-ENCONTRADO
                   STRING "Arquivo ARQ-CLIENTE nao existe. FS: "
                          WS-RESULTADO-ACESSO INTO W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
               ELSE
                   STRING "Erro ao abrir ARQ-CLIE. FS: "
                          WS-RESULTADO-ACESSO INTO W-MSGERRO
                   PERFORM 8500-MOSTRA-AVISO
               END-IF
           END-IF.

      *----------------------------------------------------------------*
       7111-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7120-INCLUIR-ARQ-CLIE           SECTION.
      *----------------------------------------------------------------*
      *
           PERFORM 7110-ABRIR-ARQ-CLIE

           WRITE REG-ARQ-CLIENTE
           IF  NOT FS-OK
               STRING "Error inserir registro. FS: "
                      WS-RESULTADO-ACESSO  INTO W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           ELSE
               MOVE "Registro inserido com sucesso!"
                                       TO W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           END-IF.

           PERFORM 7190-FECHAR-ARQ-CLIE.

      *----------------------------------------------------------------*
       7120-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7130-ALTERAR-ARQ-CLIE           SECTION.
      *----------------------------------------------------------------*
      *
           PERFORM 7110-ABRIR-ARQ-CLIE

           REWRITE REG-ARQ-CLIENTE
           IF NOT FS-OK
               STRING "Erro alterar registro. FS: "
                      WS-RESULTADO-ACESSO  INTO W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           ELSE
               MOVE "Registro alterado com sucesso!"
                                       TO W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           END-IF

           PERFORM 7190-FECHAR-ARQ-CLIE.

      *----------------------------------------------------------------*
       7130-FIM.                       EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7140-EXCLUIR-ARQ-CLIE           SECTION.
      *----------------------------------------------------------------*
      *
           PERFORM 7110-ABRIR-ARQ-CLIE

           DELETE ARQ-CLIENTE
           IF NOT FS-OK
               STRING "Error excluir registro. FS: "
                      WS-RESULTADO-ACESSO  INTO W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           ELSE
               MOVE "Registro excluido com sucesso!"
                                       TO W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           END-IF

           PERFORM 7190-FECHAR-ARQ-CLIE.

      *----------------------------------------------------------------*
       7140-FIM.                       EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7151-LER-ARQ-CLIE-CODIGO       SECTION.
      *----------------------------------------------------------------*
      *
           PERFORM 7110-ABRIR-ARQ-CLIE

           READ ARQ-CLIENTE KEY IS CLIE-CODIGO
                    INVALID KEY MOVE "N" TO W-REG-ENCONTRADO
                NOT INVALID KEY MOVE "S" TO W-REG-ENCONTRADO
           END-READ

           PERFORM 7190-FECHAR-ARQ-CLIE.

      *----------------------------------------------------------------*
       7151-FIM.                       EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7152-LER-ARQ-CLIE-CNPJ          SECTION.
      *----------------------------------------------------------------*
      *
           PERFORM 7110-ABRIR-ARQ-CLIE

           READ ARQ-CLIENTE KEY IS CLIE-CNPJ
                    INVALID KEY MOVE "N" TO W-REG-ENCONTRADO
                NOT INVALID KEY MOVE "S" TO W-REG-ENCONTRADO
           END-READ

           PERFORM 7190-FECHAR-ARQ-CLIE.

      *----------------------------------------------------------------*
       7152-FIM.                       EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7153-LER-PROX-ARQ-CLIE          SECTION.
      *----------------------------------------------------------------*
           READ ARQ-CLIENTE NEXT
           IF  NOT FS-OK
               IF  NOT FS-FIM
                   STRING "Erro leitura ARQ-CLIENTE. FS: "
                          WS-RESULTADO-ACESSO INTO W-MSGERRO
                   PERFORM 8500-MOSTRA-AVISO
               END-IF
           END-IF.

      *----------------------------------------------------------------*
       7153-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7154-LER-ANT-ARQ-CLIE          SECTION.
      *----------------------------------------------------------------*
           READ ARQ-CLIENTE PREVIOUS
           IF  NOT FS-OK
               IF  NOT FS-FIM
                   STRING "Erro leitura ARQ-CLIENTE. FS: "
                          WS-RESULTADO-ACESSO INTO W-MSGERRO
                   PERFORM 8500-MOSTRA-AVISO
               END-IF
           END-IF.

      *----------------------------------------------------------------*
       7154-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7155-LER-ARQ-CLIENTE           SECTION.
      *----------------------------------------------------------------*
      *
           READ ARQ-CLIENTE
           IF  NOT FS-OK
               IF  NOT FS-FIM
                   STRING "Erro leitura ARQ-CLIENTE. FS: "
                          WS-RESULTADO-ACESSO INTO W-MSGERRO
                   PERFORM 8500-MOSTRA-AVISO
               END-IF
           END-IF.

      *----------------------------------------------------------------*
       7155-FIM.                       EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7160-GRAVAR-ARQ-CLIE            SECTION.
      *----------------------------------------------------------------*
      *
           WRITE REG-ARQ-CLIENTE
           IF NOT FS-OK
               STRING "Erro gravar ARQ-CLIE. FS: "
                      WS-RESULTADO-ACESSO  INTO W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           END-IF.

      *----------------------------------------------------------------*
       7160-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7171-START-ARQ-CLIE-ASC         SECTION.
      *----------------------------------------------------------------*
      *
           START ARQ-CLIENTE KEY IS GREATER THAN CLIE-CODIGO
           IF  NOT FS-OK
               STRING "Erro start ARQ-CLIENTE. FS: "
                      WS-RESULTADO-ACESSO INTO W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           END-IF.

      *----------------------------------------------------------------*
       7171-FIM.                       EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7172-START-ARQ-CLIE-DES         SECTION.
      *----------------------------------------------------------------*
      *
           START ARQ-CLIENTE KEY IS LESS THAN CLIE-CODIGO
           IF  NOT FS-OK
               STRING "Erro start ARQ-CLIENTE. FS: "
                      WS-RESULTADO-ACESSO  INTO W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           END-IF.

      *----------------------------------------------------------------*
       7172-FIM.                       EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7181-START-ARQ-CLIE-ASC-ALT     SECTION.
      *----------------------------------------------------------------*
      *
           START ARQ-CLIENTE KEY IS GREATER
                                           THAN CLIE-RAZAO-SOCIAL
           IF NOT FS-OK
               STRING "Erro start ARQ-CLIENTE. FS: "
                      WS-RESULTADO-ACESSO  INTO W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           END-IF.

      *----------------------------------------------------------------*
       7181-FIM.                       EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7182-START-ARQ-CLIE-DES-ALT     SECTION.
      *----------------------------------------------------------------*
      *
           START ARQ-CLIENTE KEY IS LESS
                                       THAN CLIE-RAZAO-SOCIAL
           IF NOT FS-OK
               STRING "Erro start ARQ-CLIENTE. FS: "
                      WS-RESULTADO-ACESSO  INTO W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           END-IF.

      *----------------------------------------------------------------*
       7182-FIM.                       EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7190-FECHAR-ARQ-CLIE            SECTION.
      *----------------------------------------------------------------*
      *
           CLOSE ARQ-CLIENTE.
           IF NOT FS-OK
               STRING "Erro fechar ARQ-CLIE. FS: "
                      WS-RESULTADO-ACESSO  INTO W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           END-IF.

      *----------------------------------------------------------------*
       7190-FIM.                       EXIT.
      *----------------------------------------------------------------*
