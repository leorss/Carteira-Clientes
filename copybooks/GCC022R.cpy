      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos
      *    AUTHOR......: Leo Ribeiro e Silva Santos
      *    DATA........: 18/12/2019
      *    OBJETIVO ...: Rotinas relatorio e importacao
      *================================================================*
      *----------------------------------------------------------------*
       7510-ABRIR-ARQ-RELATO           SECTION.
      *----------------------------------------------------------------*
      *
           OPEN OUTPUT ARQ-RELATO
           IF  NOT FS-OK
               STRING "Erro ao abrir ARQ-RELATO. FS: "
                      WS-RESULTADO-ACESSO INTO W-MSGERRO
               PERFORM 9999-MOSTRA-ERRO-FS
               PERFORM 8500-MOSTRA-AVISO
           END-IF.

      *----------------------------------------------------------------*
       7510-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7560-GRAVAR-ARQ-RELATO          SECTION.
      *----------------------------------------------------------------*
      *
           WRITE REG-ARQ-RELATO
           IF  NOT FS-OK
               STRING "Erro gravar ARQ-RELATO. FS: "
                      WS-RESULTADO-ACESSO  INTO W-MSGERRO
               PERFORM 9999-MOSTRA-ERRO-FS
               PERFORM 8500-MOSTRA-AVISO
           END-IF.

      *----------------------------------------------------------------*
       7560-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7590-FECHAR-ARQ-RELATO          SECTION.
      *----------------------------------------------------------------*
      *
           CLOSE ARQ-RELATO.
           IF  NOT FS-OK
               STRING "Erro fechar ARQ-RELATO . FS: "
                      WS-RESULTADO-ACESSO  INTO W-MSGERRO
               PERFORM 9999-MOSTRA-ERRO-FS
               PERFORM 8500-MOSTRA-AVISO
           END-IF.

      *----------------------------------------------------------------*
       7590-FIM.                       EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7610-ABRIR-ARQ-IMPORTA          SECTION.
      *----------------------------------------------------------------*
      *
           OPEN OUTPUT ARQ-IMPORTA
           IF  NOT FS-OK
               STRING "Erro ao abrir ARQ-IMPORTA. FS: "
                      WS-RESULTADO-ACESSO INTO W-MSGERRO
               PERFORM 9999-MOSTRA-ERRO-FS
               PERFORM 8500-MOSTRA-AVISO
           END-IF.

      *----------------------------------------------------------------*
       7610-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7611-ABRIR-ARQ-IMPORTA-INPUT   SECTION.
      *----------------------------------------------------------------*
      *
           OPEN INPUT ARQ-IMPORTA
           IF  NOT FS-OK
               STRING "Erro ao abrir ARQ-IMPORTA. FS: "
                      WS-RESULTADO-ACESSO INTO W-MSGERRO
               PERFORM 9999-MOSTRA-ERRO-FS
               PERFORM 8500-MOSTRA-AVISO
           END-IF.

      *----------------------------------------------------------------*
       7611-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7650-LER-PROX-ARQ-IMPORTA       SECTION.
      *----------------------------------------------------------------*
      *
           READ ARQ-IMPORTA NEXT
           IF  NOT FS-OK
               IF  NOT FS-FIM
                   STRING "Erro leitura ARQ-IMPORTA. FS: "
                          WS-RESULTADO-ACESSO  INTO W-MSGERRO
                   PERFORM 9999-MOSTRA-ERRO-FS
                   PERFORM 8500-MOSTRA-AVISO
               END-IF
           END-IF.

      *----------------------------------------------------------------*
       7650-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7660-GRAVAR-ARQ-IMPORTA          SECTION.
      *----------------------------------------------------------------*
      *
           WRITE REG-ARQ-IMPORTA
           IF  NOT FS-OK
               STRING "Erro gravar ARQ-IMPORTA. FS: "
                      WS-RESULTADO-ACESSO  INTO W-MSGERRO
               PERFORM 9999-MOSTRA-ERRO-FS
               PERFORM 8500-MOSTRA-AVISO
           END-IF.

      *----------------------------------------------------------------*
       7660-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       7690-FECHAR-ARQ-IMPORTA          SECTION.
      *----------------------------------------------------------------*
      *
           CLOSE ARQ-IMPORTA.
           IF  NOT FS-OK
               STRING "Erro fechar ARQ-IMPORTA . FS: "
                      WS-RESULTADO-ACESSO  INTO W-MSGERRO
               PERFORM 9999-MOSTRA-ERRO-FS
               PERFORM 8500-MOSTRA-AVISO
           END-IF.

      *----------------------------------------------------------------*
       7690-FIM.                       EXIT.
      *----------------------------------------------------------------*
