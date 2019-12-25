      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos
      *    AUTHOR......: Leo Ribeiro e Silva Santos
      *    DATA........: 18/12/2019
      *    OBJETIVO ...: Rotinas distribuicao
      *================================================================*

      *----------------------------------------------------------------*
       7610-ABRIR-ARQ-DIST          SECTION.
      *----------------------------------------------------------------*
      *
           OPEN OUTPUT ARQ-DIST
           IF  NOT FS-OK
               STRING "Erro ao abrir ARQ-DIST. FS: "
                      WS-RESULTADO-ACESSO INTO W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           END-IF.

      *----------------------------------------------------------------*
       7610-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7611-ABRIR-ARQ-DIST-INPUT   SECTION.
      *----------------------------------------------------------------*
      *
           OPEN INPUT ARQ-DIST
           IF  NOT FS-OK
               STRING "Erro ao abrir ARQ-DIST. FS: "
                      WS-RESULTADO-ACESSO INTO W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           END-IF.

      *----------------------------------------------------------------*
       7611-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7650-LER-PROX-ARQ-DIST       SECTION.
      *----------------------------------------------------------------*
      *
           READ ARQ-DIST NEXT
           IF  NOT FS-OK
               IF  NOT FS-FIM
                   STRING "Erro leitura ARQ-DIST. FS: "
                          WS-RESULTADO-ACESSO  INTO W-MSGERRO
                   PERFORM 8500-MOSTRA-AVISO
               END-IF
           END-IF.

      *----------------------------------------------------------------*
       7650-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7651-LER-ARQ-DIST-CODIGO       SECTION.
      *----------------------------------------------------------------*
      *
           PERFORM 7610-ABRIR-ARQ-DIST

           READ ARQ-DIST KEY IS DIST-CLIE-CODIGO
                    INVALID KEY MOVE "N" TO W-REG-ENCONTRADO
                NOT INVALID KEY MOVE "S" TO W-REG-ENCONTRADO
           END-READ

           PERFORM 7690-FECHAR-ARQ-DIST.

      *----------------------------------------------------------------*
       7651-FIM.                       EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7653-LER-PROX-ARQ-DIST          SECTION.
      *----------------------------------------------------------------*
           READ ARQ-DIST NEXT
           IF  NOT FS-OK
               IF  NOT FS-FIM
                   STRING "Erro leitura ARQ-DIST. FS: "
                          WS-RESULTADO-ACESSO INTO W-MSGERRO
                   PERFORM 8500-MOSTRA-AVISO
               END-IF
           END-IF.

      *----------------------------------------------------------------*
       7653-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7660-GRAVAR-ARQ-DIST          SECTION.
      *----------------------------------------------------------------*
      *
           WRITE REG-ARQ-DIST
           IF  NOT FS-OK
               STRING "Erro gravar ARQ-DIST. FS: "
                      WS-RESULTADO-ACESSO  INTO W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           END-IF.

      *----------------------------------------------------------------*
       7660-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7690-FECHAR-ARQ-DIST          SECTION.
      *----------------------------------------------------------------*
      *
           CLOSE ARQ-DIST.
           IF  NOT FS-OK
               STRING "Erro fechar ARQ-DIST . FS: "
                      WS-RESULTADO-ACESSO  INTO W-MSGERRO
               PERFORM 8500-MOSTRA-AVISO
           END-IF.

      *----------------------------------------------------------------*
       7690-FIM.                       EXIT.
      *----------------------------------------------------------------*
