      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos
      *    AUTHOR......: Leo Ribeiro e Silva Santos
      *    DATA........: 18/12/2019
      *    OBJETIVO ...: Rotinas validacao CPF / CNPJ
      *================================================================*

      ******************************************************************
      * ROTINAS DE VALIDACAO DE CPF
      *----------------------------------------------------------------*
       8110-VALIDA-CPF                 SECTION.
      *----------------------------------------------------------------*

           MOVE CPF-RECEBIDO(1:9) TO CPF-CALCULADO(1:9)

           MOVE DIG(6) TO G
           PERFORM VARYING I FROM 1 BY 1 UNTIL DIG(I) NOT = G OR I > 9
           END-PERFORM.

           IF  I       GREATER 9
               MOVE ZEROS              TO TOTAL
               MOVE DIG(6)             TO DIG(10)
               MOVE DIG(6)             TO DIG(11)
           ELSE
               MOVE 1                  TO F
               PERFORM 8111-CALCULA-DIGITOS
               MOVE ZEROS              TO F
               PERFORM 8111-CALCULA-DIGITOS
           END-IF.

           IF  CPF-CALCULADO NOT EQUAL CPF-RECEBIDO OR
               TOTAL EQUAL ZERO
               MOVE "N"                TO CPF-VALIDO
           ELSE
               MOVE "S"                TO CPF-VALIDO
           END-IF.

      *----------------------------------------------------------------*
       8110-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       8111-CALCULA-DIGITOS.
      *----------------------------------------------------------------*
           MOVE ZERO                   TO G.
           MOVE ZERO                   TO TOTAL

           PERFORM VARYING I FROM F BY 1 UNTIL I GREATER 9
              ADD 1                    TO G
              COMPUTE TOTAL = TOTAL + DIG(G) * I
           END-PERFORM

           DIVIDE TOTAL BY 11 GIVING INTEIRO REMAINDER RESTO
           IF RESTO        GREATER 9
              MOVE ZERO                TO DIG(G + 1)
           ELSE
              MOVE RESTO               TO DIG(G + 1)
           END-IF.

      *----------------------------------------------------------------*
       8111-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      ******************************************************************
      * ROTINAS DE VALIDACAO DE CNPJ
      *----------------------------------------------------------------*
       8210-VALIDA-CNPJ                SECTION.
      *----------------------------------------------------------------*

           MOVE "11"                   TO RETORNO

           COMPUTE DV  = (CNPJ-01 * 5)
                       + (CNPJ-02 * 4)
                       + (CNPJ-03 * 3)
                       + (CNPJ-04 * 2)
                       + (CNPJ-05 * 9)
                       + (CNPJ-06 * 8)
                       + (CNPJ-07 * 7)
                       + (CNPJ-08 * 6)
                       + (CNPJ-09 * 5)
                       + (CNPJ-10 * 4)
                       + (CNPJ-11 * 3)
                       + (CNPJ-12 * 2)

           DIVIDE 11 INTO DV GIVING LIXO REMAINDER RESTO

           IF   RESTO EQUAL 0 OR 1
                MOVE ZERO              TO RESTO
           ELSE
                COMPUTE RESTO = RESTO - 11
           END-IF

           IF   CNPJ-14 EQUAL RESTO
                MOVE "0"               TO RETORNO-1
                COMPUTE DV  = (CNPJ-01 * 6)
                            + (CNPJ-02 * 5)
                            + (CNPJ-03 * 4)
                            + (CNPJ-04 * 3)
                            + (CNPJ-05 * 2)
                            + (CNPJ-06 * 9)
                            + (CNPJ-07 * 8)
                            + (CNPJ-08 * 7)
                            + (CNPJ-09 * 6)
                            + (CNPJ-10 * 5)
                            + (CNPJ-11 * 4)
                            + (CNPJ-12 * 3)
                            + (CNPJ-14 * 2)
                DIVIDE 11 INTO DV GIVING LIXO REMAINDER RESTO
                IF   RESTO             EQUAL 0 OR 1
                     MOVE 0            TO RESTO
                     IF   CNPJ-15 EQUAL RESTO
                          MOVE "0"     TO RETORNO-2
                     END-IF
                ELSE
                     COMPUTE RESTO = RESTO - 11
                     IF   CNPJ-15 EQUAL RESTO
                          MOVE "0"     TO RETORNO-2
                     END-IF
                END-IF
           END-IF

           IF  CNPJ     EQUAL ZERO OR
               CNPJ     EQUAL 99999999999
               MOVE "99"               TO RETORNO
           END-IF


           IF  RETORNO NOT EQUAL ZERO
               MOVE "N"                TO CNPJ-VALIDO
           ELSE
               MOVE "S"                TO CNPJ-VALIDO
           END-IF.

      *----------------------------------------------------------------*
       8210-99-FIM.                    EXIT.
      *----------------------------------------------------------------*
