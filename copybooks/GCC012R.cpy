      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos
      *    AUTHOR......: Leo Ribeiro e Silva Santos
      *    DATA........: 18/12/2019
      *    OBJETIVO ...: Rotinas arquivo vendedores
      *================================================================*
      *----------------------------------------------------------------*
       7210-ABRIR-ARQ-VEND            SECTION.
      *----------------------------------------------------------------*
      *
           OPEN I-O ARQ-VENDEDOR

           IF  NOT FS-OK
               IF FS-ARQ-NAO-ENCONTRADO
                   OPEN OUTPUT ARQ-VENDEDOR
                   CLOSE ARQ-VENDEDOR
                   OPEN I-O ARQ-VENDEDOR
               ELSE
                   STRING "Erro ao abrir arquivo. FS: "
                          WS-RESULTADO-ACESSO INTO  W-MSGERRO
                   PERFORM 8500-MOSTRA-AVISO
               END-IF
           END-IF.

      *----------------------------------------------------------------*
       7210-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7211-ABRIR-INPUT-ARQ-VEND       SECTION.
      *----------------------------------------------------------------*
      *
           OPEN INPUT ARQ-VENDEDOR
           IF  NOT FS-OK
               IF  FS-ARQ-NAO-ENCONTRADO
                   STRING "Arquivo ARQ-VEND nao existe. FS: "
                          WS-RESULTADO-ACESSO INTO W-MSGERRO
                   PERFORM 8500-MOSTRA-AVISO
               ELSE
                   STRING "Erro ao abrir ARQ-VEND. FS: "
                          WS-RESULTADO-ACESSO INTO W-MSGERRO
                   PERFORM 8500-MOSTRA-AVISO
               END-IF
           END-IF.

      *----------------------------------------------------------------*
       7211-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7220-INCLUIR-ARQ-VEND           SECTION.
      *----------------------------------------------------------------*
      *
           PERFORM 7210-ABRIR-ARQ-VEND

           WRITE REG-ARQ-VENDEDOR
           IF NOT FS-OK
               STRING "Error inserir registro. FS: "
                      WS-RESULTADO-ACESSO  INTO W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           ELSE
               MOVE "Registro inserido com sucesso!"
                                       TO W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           END-IF.

           PERFORM 7290-FECHAR-ARQ-VEND.

      *----------------------------------------------------------------*
       7220-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7230-ALTERAR-ARQ-VEND           SECTION.
      *----------------------------------------------------------------*
      *
           PERFORM 7210-ABRIR-ARQ-VEND

           REWRITE REG-ARQ-VENDEDOR
           IF NOT FS-OK
               STRING "Erro alterar registro. FS: "
                      WS-RESULTADO-ACESSO  INTO W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           ELSE
               MOVE "Registro alterado com sucesso!"
                                       TO W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           END-IF

           PERFORM 7290-FECHAR-ARQ-VEND.

      *----------------------------------------------------------------*
       7230-FIM.                       EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7240-EXCLUIR-ARQ-VEND           SECTION.
      *----------------------------------------------------------------*
      *
           PERFORM 7210-ABRIR-ARQ-VEND

           DELETE ARQ-VENDEDOR
           IF NOT FS-OK
               STRING "Error excluir registro. FS: "
                      WS-RESULTADO-ACESSO  INTO W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           ELSE
               MOVE "Registro excluido com sucesso!"
                                       TO W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           END-IF

           PERFORM 7290-FECHAR-ARQ-VEND.

      *----------------------------------------------------------------*
       7240-FIM.                       EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7251-LER-ARQ-VEND-CODIGO       SECTION.
      *----------------------------------------------------------------*
      *
           PERFORM 7210-ABRIR-ARQ-VEND

           READ ARQ-VENDEDOR KEY IS VEND-CODIGO
                    INVALID KEY MOVE "N" TO W-REG-ENCONTRADO
                NOT INVALID KEY MOVE "S" TO W-REG-ENCONTRADO
           END-READ

           PERFORM 7290-FECHAR-ARQ-VEND.

      *----------------------------------------------------------------*
       7251-FIM.                       EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7252-LER-ARQ-VEND-CPF           SECTION.
      *----------------------------------------------------------------*
      *
           PERFORM 7210-ABRIR-ARQ-VEND

           READ ARQ-VENDEDOR KEY IS VEND-CPF
                    INVALID KEY MOVE "N" TO W-REG-ENCONTRADO
                NOT INVALID KEY MOVE "S" TO W-REG-ENCONTRADO
           END-READ

           PERFORM 7290-FECHAR-ARQ-VEND.

      *----------------------------------------------------------------*
       7252-FIM.                       EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7253-LER-PROX-ARQ-VEND          SECTION.
      *----------------------------------------------------------------*
           READ ARQ-VENDEDOR NEXT
           IF  NOT FS-OK
               IF  NOT FS-FIM
                   STRING "Erro leitura ARQ-VENDEDOR. FS: "
                          WS-RESULTADO-ACESSO INTO W-MSGERRO
                   PERFORM 8500-MOSTRA-AVISO
               END-IF
           END-IF.

      *----------------------------------------------------------------*
       7253-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7254-LER-ANT-ARQ-VEND          SECTION.
      *----------------------------------------------------------------*
           READ ARQ-VENDEDOR PREVIOUS
           IF  NOT FS-OK
               IF  NOT FS-FIM
                   STRING "Erro leitura ARQ-VENDEDOR. FS: "
                          WS-RESULTADO-ACESSO INTO W-MSGERRO
                   PERFORM 8500-MOSTRA-AVISO
               END-IF
           END-IF.

      *----------------------------------------------------------------*
       7254-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7255-LER-ARQ-VENDEDOR          SECTION.
      *----------------------------------------------------------------*
      *
           READ ARQ-VENDEDOR
           IF  NOT FS-OK
               IF  NOT FS-FIM
                   STRING "Erro leitura ARQ-VENDEDOR. FS: "
                          WS-RESULTADO-ACESSO INTO W-MSGERRO
                   PERFORM 8500-MOSTRA-AVISO
               END-IF
           END-IF.

      *----------------------------------------------------------------*
       7255-FIM.                       EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7260-GRAVAR-ARQ-VEND            SECTION.
      *----------------------------------------------------------------*
      *
           WRITE REG-ARQ-VENDEDOR
           IF NOT FS-OK
               STRING "Erro gravar ARQ-VENDEDOR. FS: "
                      WS-RESULTADO-ACESSO INTO W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           END-IF.

      *----------------------------------------------------------------*
       7260-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7271-START-ARQ-VEND-ASC         SECTION.
      *----------------------------------------------------------------*
      *
           START ARQ-VENDEDOR KEY IS GREATER THAN VEND-CODIGO
           IF  NOT FS-OK
               STRING "Erro start ARQ-VENDEDOR. FS: "
                      WS-RESULTADO-ACESSO INTO W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           END-IF.

      *----------------------------------------------------------------*
       7271-FIM.                       EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7272-START-ARQ-VEND-DES         SECTION.
      *----------------------------------------------------------------*
      *
           START ARQ-VENDEDOR KEY IS LESS THAN VEND-CODIGO
           IF  NOT FS-OK
               STRING "Erro start ARQ-VENDEDOR. FS: "
                      WS-RESULTADO-ACESSO  INTO W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           END-IF.

      *----------------------------------------------------------------*
       7272-FIM.                       EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7281-START-ARQ-VEND-ASC-ALT     SECTION.
      *----------------------------------------------------------------*
      *
           START ARQ-VENDEDOR KEY IS GREATER THAN VEND-RAZAO-SOCIAL
           IF NOT FS-OK
               STRING "Erro start ARQ-VENDEDOR. FS: "
                      WS-RESULTADO-ACESSO  INTO W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           END-IF.

      *----------------------------------------------------------------*
       7281-FIM.                       EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7282-START-ARQ-VEND-DES-ALT     SECTION.
      *----------------------------------------------------------------*
      *
           START ARQ-VENDEDOR KEY IS LESS THAN VEND-RAZAO-SOCIAL
           IF NOT FS-OK
               STRING "Erro start ARQ-VENDEDOR. FS: "
                      WS-RESULTADO-ACESSO  INTO W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           END-IF.

      *----------------------------------------------------------------*
       7282-FIM.                       EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7290-FECHAR-ARQ-VEND            SECTION.
      *----------------------------------------------------------------*
      *
           CLOSE ARQ-VENDEDOR.
           IF NOT FS-OK
               STRING "Erro fechar ARQ-VENDEDOR. FS: "
                      WS-RESULTADO-ACESSO  INTO W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           END-IF.

      *----------------------------------------------------------------*
       7290-FIM. EXIT.
      *----------------------------------------------------------------*
