' ABACOV.BAS - Gioco didattico sull'abaco
' PD (Public Domain) 1986 by Marco da Venezia
'
' Questo programma simula un abaco verticale a 10 barre.

' Dichiarazione di default per le variabili
' DEFDBL A-Z: tutte le variabili non dichiarate esplicitamente saranno di tipo Double
' per garantire la massima precisione nelle operazioni aritmetiche complesse.

DEFDBL A-Z

' Dichiarazione delle subroutine, necessarie per il compilatore QuickBASIC
' per riconoscere le chiamate alle procedure.
DECLARE SUB Addizione (valoreAggiungere)
DECLARE SUB clsrow (c1%, c2%, c$)
DECLARE SUB creafiletxt ()
DECLARE SUB DisegnaAbacoVerticale ()
DECLARE SUB DisegnaCornice ()
DECLARE SUB editLine (edit$)
DECLARE SUB ResettaAbaco ()
DECLARE SUB Sottrazione (valoreTogliere)

' Dichiarazione delle variabili condivise tra le diverse subroutine.
' Barra(): array che memorizza lo stato attuale di ogni barra dell'abaco (0-9).
DIM SHARED Barra(9) AS INTEGER
' BarraPrecedente(): array che memorizza lo stato precedente delle barre.
' Usato per calcolare e animare il movimento delle perle.
DIM SHARED BarraPrecedente(9) AS INTEGER

' -------------------- INIZIO PROGRAMMA PRINCIPALE --------------------

' Disegna la cornice e i titoli all'avvio del programma.
CALL DisegnaCornice
' Inizializza tutte le barre dell'abaco a zero.
CALL ResettaAbaco
' Disegna l'abaco nella sua condizione iniziale.
CALL DisegnaAbacoVerticale

' Ciclo principale del programma.
DO
    ' Posiziona il cursore e chiede l'input all'utente.
    LOCATE 22, 17: PRINT "Inserisci un numero (0 per uscire): ";
    ' Pulisce l'area di input, sostituendo i caratteri precedenti con punti.
    CALL clsrow(53, 64, ".")
    ' Chiama la subroutine personalizzata per l'input da tastiera.
    CALL editLine(edit$)
    ' Converte la stringa di input in un valore numerico.
    numInput = VAL(edit$)

    ' Se l'utente inserisce 0, esce dal loop principale.
    IF numInput = 0 THEN EXIT DO

    ' Decide se chiamare l'addizione o la sottrazione in base al segno del numero.
    IF numInput > 0 THEN
        CALL Addizione(numInput)
    ELSEIF numInput < 0 THEN
        ' Assicura che la sottrazione avvenga con un valore positivo.
        CALL Sottrazione(ABS(numInput))
    END IF

    ' Ridisegna l'abaco dopo ogni operazione, animando il movimento delle perle.
    CALL DisegnaAbacoVerticale
LOOP

' Messaggio finale.
LOCATE 4, 23, 1: PRINT "Grazie per aver giocato con l'abaco";
' Salva lo stato finale dello schermo in un file di testo.
CALL creafiletxt
' Attende la pressione di un tasto prima di terminare.
k$ = INPUT$(1)
' Pulisce lo schermo prima della chiusura.
CLS
' -------------------- FINE PROGRAMMA PRINCIPALE --------------------

' Subroutine per l'addizione
SUB Addizione (valoreAggiungere)
    ' Inizializza la variabile per il riporto.
    currentCarry = valoreAggiungere
    ' Inizia dalla barra delle unita' (indice 0).
    currentBarIndex = 0

    ' Cicla finche' c'è un riporto e ci sono barre disponibili.
    DO WHILE currentCarry > 0 AND currentBarIndex <= 9
        ' Somma il valore corrente della barra con la cifra del riporto.
        Barra(currentBarIndex) = Barra(currentBarIndex) + (currentCarry MOD 10)

        ' Calcola il nuovo riporto per la barra successiva.
        currentCarry = currentCarry \ 10

        ' Gestisce il riporto se il valore della barra supera 9.
        IF Barra(currentBarIndex) >= 10 THEN
            ' Aggiunge il riporto alla prossima barra.
            currentCarry = currentCarry + (Barra(currentBarIndex) \ 10)
            ' Imposta il valore della barra corrente a una sola cifra.
            Barra(currentBarIndex) = Barra(currentBarIndex) MOD 10
        END IF

        ' Passa alla prossima barra dell'abaco.
        currentBarIndex = currentBarIndex + 1

        ' Gestione di numeri troppo grandi per le 10 barre (massimo 9.999.999.999).
        IF currentBarIndex > 9 AND currentCarry > 0 THEN
            LOCATE 24, 15, 1: PRINT "Numero troppo grande per le dieci barre dell'abaco!";
            k$ = INPUT$(1)
            ' Pulisce la riga del messaggio di errore.
            CALL clsrow(15, 70, " ")
            ' Esce dalla subroutine in caso di overflow.
            EXIT SUB
        END IF
    LOOP
END SUB

DEFSNG A-Z
' Subroutine per pulire una riga dello schermo
SUB clsrow (c1%, c2%, c$)
    ' Sposta il cursore nella riga corrente, a partire da c1.
    LOCATE CSRLIN, c1%, 0
    ' Stampa una stringa del carattere specificato per la larghezza desiderata.
    PRINT STRING$(c2% - c1%, c$);
    ' Riposiziona il cursore all'inizio dell'area pulita.
    LOCATE CSRLIN, c1%
END SUB

' Subroutine per salvare lo stato dello schermo in un file di testo
SUB creafiletxt
    ' Apre il file "abacov.scr" per la scrittura.
    OPEN "abacov.scr" FOR APPEND AS #1
    ' Cicla su tutte le 25 righe dello schermo.
    FOR riga = 1 TO 25
        ' Cicla su tutte le 80 colonne dello schermo.
        FOR colonna = 1 TO 80
            ' Legge il carattere ASCII dalla posizione (riga, colonna).
            carattere$ = CHR$(SCREEN(riga, colonna))
            ' Scrive il carattere nel file.
            PRINT #1, carattere$;
        NEXT colonna
        ' Aggiunge un ritorno a capo dopo ogni riga completa.
        PRINT #1,
    NEXT riga
    ' Aggiunge un ritorno a capo dopo il ciclo.
    PRINT #1,
    ' Chiude il file.
    CLOSE #1
END SUB

DEFDBL A-Z
' Subroutine per disegnare e animare l'abaco
SUB DisegnaAbacoVerticale
    DIM i AS INTEGER, r AS INTEGER, col AS INTEGER
    DIM prev AS INTEGER, curr AS INTEGER
    CONST altezzaMax = 10
    DIM margin AS INTEGER

    DIM note$(9)
    note$(0) = "C" ' Unita' (DO)
    note$(1) = "C#"
    note$(2) = "D"
    note$(3) = "D#"
    note$(4) = "E"
    note$(5) = "F"
    note$(6) = "F#"
    note$(7) = "G"
    note$(8) = "G#"
    note$(9) = "A"
   
    margin = (80 - (10 * 2 + 9)) \ 2  ' Calcolo margine orizzontale

    FOR r = 0 TO 9
        curr = Barra(r)
        prev = BarraPrecedente(r)
        col = 2 + margin + (9 - r) * 3' Colonna fissa per ogni barra
        COLOR r + 1

        IF curr > prev THEN
            FOR i = prev + 1 TO curr
                PLAY "o1l10b" + note$(r)
                LOCATE altezzaMax - i + 6, col: PRINT "o";
            NEXT i
        ELSEIF curr < prev THEN
            FOR i = curr + 1 TO prev
                PLAY "o2l10b" + note$(r)
                LOCATE altezzaMax - i + 6, col: PRINT "^";
            NEXT i
        END IF
        COLOR 7: LOCATE 16, margin + 1: PRINT STRING$(30, "=")

        ' Disegno finale della colonna (perle attive)
        FOR i = curr + 1 TO altezzaMax
            LOCATE altezzaMax - i + 6, col: PRINT "|";
        NEXT i
    NEXT r

    COLOR 7

    ' Mostra il valore attuale
    LOCATE 19, 17
    PRINT "Valore attuale sull'abaco: ";
    FOR i = 9 TO 0 STEP -1
        PRINT STR$(Barra(i));
    NEXT

    ' Aggiorna lo stato precedente
    FOR i = 0 TO 9
        BarraPrecedente(i) = Barra(i)
    NEXT i
END SUB

DEFSNG A-Z
' Subroutine per disegnare la cornice del programma
SUB DisegnaCornice
    DEFINT A-Z
    CLS
    ' Disattiva il cursore per il disegno della cornice.
    LOCATE , , 0

    topRow = 1: bottomRow = 25
    leftCol = 1: rightCol = 80

    ' Disegna gli angoli.
    LOCATE topRow, leftCol: PRINT "+";
    LOCATE topRow, rightCol: PRINT "+";
    LOCATE bottomRow, leftCol: PRINT "+";
    LOCATE bottomRow, rightCol: PRINT "+";

    ' Disegna le linee orizzontali.
    FOR col = leftCol + 1 TO rightCol - 1
        LOCATE topRow, col: PRINT "-";
        LOCATE bottomRow, col: PRINT "-";
    NEXT col

    ' Disegna le linee verticali.
    FOR row = topRow + 1 TO bottomRow - 1
        LOCATE row, leftCol: PRINT "|";
        LOCATE row, rightCol: PRINT "|";
    NEXT row

    ' Disegna il titolo centrato.
    title$ = "IMPARIAMO A CALCOLARE CON L'ABACO"
    titleStart = (rightCol - LEN(title$)) \ 2 + 1
    LOCATE 2, titleStart: PRINT title$
END SUB

DEFSNG A-Z
' Subroutine per gestire l'input da tastiera (editor personalizzato)
SUB editLine (edit$)
    DEFINT A-Z
    edit$ = ""
    LOCATE , , 1 ' Attiva il cursore.

    DO
        k$ = INKEY$
        ' Tasto ENTER per confermare.
        IF k$ = CHR$(13) THEN EXIT DO
        ' Tasto BACKSPACE per cancellare.
        IF k$ = CHR$(8) THEN
            IF LEN(edit$) > 0 THEN
                edit$ = LEFT$(edit$, LEN(edit$) - 1)
                ' Sostituisce il carattere cancellato con un punto.
                LOCATE , POS(0) - 1: PRINT ".";
                LOCATE , POS(0) - 1
            END IF
        END IF
        ' Permette di inserire il segno meno solo come primo carattere.
        IF k$ = "-" AND edit$ = "" THEN
            edit$ = "-"
            PRINT "-";
        END IF
        ' Controlla che i caratteri siano cifre e che il numero non superi i limiti.
        IF k$ >= "0" AND k$ <= "9" AND LEN(edit$) <= 10 THEN
            ' Verifica che il valore non superi il limite massimo (10 cifre).
            prova$ = edit$ + k$
            ' I limiti sono 1.000.000.000 per evitare overflow.
            IF VAL(prova$) <= 1000000000 AND VAL(prova$) >= -1000000000 THEN
                edit$ = prova$
                PRINT k$;
            END IF
        END IF
    LOOP

    LOCATE , , 0 ' Disattiva il cursore
END SUB

DEFSNG A-Z
' Subroutine per resettare l'abaco (tutte le barre a zero)
SUB ResettaAbaco
    DEFINT A-Z
    FOR i = 0 TO 9
        Barra(i) = 0
    NEXT i
END SUB

DEFDBL A-Z
' Subroutine per la sottrazione
SUB Sottrazione (valoreTogliere)
    currentBorrow = valoreTogliere
    currentBarIndex = 0

    ' Cicla finche' c'è un prestito e ci sono barre disponibili.
    DO WHILE currentBorrow > 0 AND currentBarIndex <= 9
        ' Sottrae il valore corrente della barra.
        Barra(currentBarIndex) = Barra(currentBarIndex) - (currentBorrow MOD 10)

        ' Gestisce il prestito se il valore della barra va sotto zero.
        IF Barra(currentBarIndex) < 0 THEN
            ' Restituisce 10 alla barra corrente.
            Barra(currentBarIndex) = Barra(currentBarIndex) + 10
            ' Passa un prestito di 1 alla barra successiva.
            currentBorrow = (currentBorrow \ 10) + 1
        ELSE
            currentBorrow = currentBorrow \ 10
        END IF

        currentBarIndex = currentBarIndex + 1

        ' Gestione di sottrazioni troppo grandi (risultato negativo).
        IF currentBarIndex > 9 AND currentBorrow > 0 THEN
            LOCATE 24, 11, 1: PRINT "Errore: il risultato sarebbe negativo, non rappresentabile.";
            k$ = INPUT$(1)
            CALL clsrow(11, 70, " ")
            ' Resetta l'abaco prima di uscire in caso di errore.
            CALL ResettaAbaco
            EXIT SUB
        END IF
    LOOP
END SUB

