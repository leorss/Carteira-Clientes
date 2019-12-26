      *================================================================*
      *    MODULO......: Carteira de Clientes Vendedores Novos
      *    AUTHOR......: Leo Ribeiro e Silva Santos
      *    DATA........: 18/12/2019
      *    OBJETIVO ...: Rotinas tela principal
      *================================================================*

      *----------------------------------------------------------------*
       8100-CONFIRMA                   SECTION.
      *----------------------------------------------------------------*

           MOVE "<F1> Confirmar <Esc> Cancelar"
                                       TO W-MSGERRO
           PERFORM 8500-MOSTRA-AVISO  UNTIL
                                   COB-CRT-STATUS EQUAL COB-SCR-F1 OR
                                   COB-CRT-STATUS EQUAL COB-SCR-ESC.

      *----------------------------------------------------------------*
       8100-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       8500-MOSTRA-AVISO               SECTION.
      *----------------------------------------------------------------*

           DISPLAY S-ERRO
           ACCEPT  S-ERRO
           DISPLAY S-STATUS.

           INITIALIZE S-ERRO W-MSGERRO W-MSGERRO-1 W-MSGERRO-2.

      *----------------------------------------------------------------*
       8500-99-FIM.                    EXIT.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       9999-MOSTRA-ERRO-FS             SECTION.
      *----------------------------------------------------------------*

           INITIALIZE W-MSG-FILE-STATUS

           IF  WS-RESULTADO-ACESSO    EQUAL "02"
               MOVE "Indexed files only."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "04"
               MOVE "The length of the record being processed does not c
      -             "onform to the fixed file attributes for that file."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "05"
               MOVE "The referenced optional file is not present at the
      -             "time the OPEN statement is executed."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "06"
               MOVE "Attempted to write to a file that has been opened f
      -              "or input."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "07"
               MOVE "Sequential files only. For an OPEN or CLOSE stateme
      -        "nt with the REEL/UNIT phrase the referenced file is a no
      -        "n-reel/unit medium."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "08"
               MOVE "Attempted to read from a file opened for output."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "09"
               MOVE "No room in directory or directory does not exist."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "10"
               MOVE "No next logical record exists. You have reached the
      -             " end of the file."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "12"
               MOVE "Attempted to open a file that is already open."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "13"
               MOVE "File not found."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "14"
               MOVE "Too many files open simultaneously."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "15"
               MOVE "Too many indexed files open."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "16"
               MOVE "Too many device files open."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "17"
               MOVE "Record error: probably zero length."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "18"
               MOVE "Read part record error: EOF before EOR or file open
      -        " in wrong mode."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "19"
               MOVE "Rewrite error: open mode or access mode wrong."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "20"
               MOVE "Device or resource busy."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "21"
               MOVE "Sequentially accessed files only."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "22"
               MOVE "Attempt has been made to store a record that would
      -             "create a duplicate key in the indexed."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "23"
               MOVE "Indicates no record found. An attempt has been made
      -         "to access a record, identified by a key, and that recor
      -         "d does not exist in the file."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "24"
               MOVE "Relative and indexed files only. Indicates a bounda
      -             "ry violation."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "30"
               MOVE "The I/O statement was unsuccessfully executed as th
      -        "e result of a boundary violation for a sequential file."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "32"
               MOVE "Too many Indexed files opened."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "34"
               MOVE "The I/O statement failed because of a boundary viol
      -             "ation."          TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "35"
               MOVE "An OPEN operation with the I-O, INPUT, or EXTEND ph
      -             "rases has been tried on a non-OPTIONAL file that is
      -             " not present."   TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "37"
               MOVE "An OPEN operation has been tried on a file which do
      -             "es not support the open mode specified in the OPEN
      -             "statement."      TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "38"
               MOVE "An OPEN operation has been tried on a file previous
      -             "ly closed with a lock."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "39"
               MOVE "A conflict has been detected between the fixed file
      -             " attributes and the attributes specified for the fi
      -             "le in the program."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "41"
               MOVE "An OPEN operation has been tried on file already op
      -             "ened."           TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "42"
               MOVE "A CLOSE operation has been tried on file already cl
      -             "osed."           TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "43"
               MOVE "The last I/O statement executed for the file, befor
      -             "e the execution of a DELETE or REWRITE statement, w
      -             "as not a READ statement."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "44"
               MOVE "A boundary violation exists."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "46"
               MOVE "A sequential READ operation has been tried on a fil
      -             "e open in the INPUT or I-O mode but no valid next r
      -             "ecord has been established."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "47"
               MOVE "A READ or START operation has been tried on a file
      -             "not opened INPUT or I-O."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "48"
               MOVE "A WRITE operation has been tried on a file not open
      -             "ed in the OUTPUT, I-O, or EXTEND mode, or on a file
      -             " open I-O."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "49"
               MOVE "A DELETE or REWRITE operation has been tried on a f
      -             "ile that is not opened I-O."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "91"
               MOVE "For VSAM only. Password Failure."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "92"
               MOVE "For VSAM only. Logical Error."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "93"
               MOVE "For VSAM only. Recourse not Available."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "94"
               MOVE "For VSAM with CMPR2 compiler-option only: No file p
      -             "osition indicator for sequential request."
                                       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "95"
               MOVE "For VSAM only. Invalid or incomplete file informati
      -             "on."             TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "96"
               MOVE "For VSAM under MVS: No DD statement specified for t
      -             "his file."       TO  W-MSG-FILE-STATUS
           ELSE
           IF  WS-RESULTADO-ACESSO    EQUAL "97"
            MOVE "For VSAM only. OPEN statement execution successful: Fi
      -          "le integrity verified."
                                       TO  W-MSG-FILE-STATUS.

           STRING " " W-MSG-FILE-STATUS-1
                                       INTO W-MSGERRO-1
           STRING " " W-MSG-FILE-STATUS-2
                                       INTO W-MSGERRO-2.

           DISPLAY S-ERRO-2.

      *----------------------------------------------------------------*
       9999-99-FIM.                    EXIT.
      *----------------------------------------------------------------*
