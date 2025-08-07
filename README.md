# Abaco.bas – Gioco Didattico sull'Abaco Orizzontale

**Autore:** Marco da Venezia  
**Licenza:** Public Domain (1986-2025)  

---

## Descrizione

Questo programma in QuickBASIC simula un abaco orizzontale a 10 barre, utile per comprendere il concetto di addizione e sottrazione con riporto e prestito.  

L'interfaccia mostra una rappresentazione grafica e animata delle barre con le "perle" (`o`), con la possibilità di inserire numeri positivi e negativi tramite un editor interno che limita l'input ai numeri rappresentabili sull'abaco.  

---

## Caratteristiche principali

- Addizione e sottrazione con gestione di riporto e prestito su 10 barre  
- Visualizzazione animata delle perle sulle barre, con feedback sonoro  
- Editor interno per input numerico con controllo di validità e lunghezza  
- Salvataggio dello stato attuale dell'abaco in un file di testo `screen.txt`  
- Interfaccia testuale con cornice, titoli e valori numerici separati da spazi  
- Limiti di input gestiti per evitare overflow (massimo ±1.000.000.000)  

---

## Istruzioni per l'uso

1. Avviare il programma in ambiente compatibile QuickBASIC o DOSBox.  
2. Inserire un numero intero (positivo o negativo) entro i limiti specificati.  
3. Visualizzare l'aggiornamento animato dell'abaco con le perle.  
4. Per uscire, inserire `0`.  
5. Alla chiusura, lo stato finale viene salvato nel file `screen.txt`.  

---

## Struttura del codice

- `Main`: ciclo principale per l'input e l'aggiornamento dell'abaco  
- `Addizione`: gestione dell'addizione con riporto  
- `Sottrazione`: gestione della sottrazione con prestito  
- `DisegnaAbaco`: disegna e anima la rappresentazione grafica dell'abaco  
- `editLine`: editor interno per l'input da tastiera  
- `creafiletxt`: salva lo schermo in file di testo  
- `clsrow`: funzione ausiliaria per pulizia riga schermo  
- `ResettaAbaco`: resetta tutte le barre a zero  

---
```
## Esempio di schermata

+------------------------------------------------------------------------------+
|                      IMPARIAMO A CALCOLARE CON L'ABACO                       |
|                                                                              |
|                     Grazie per aver giocato con l'abaco                      |
|                                                                              |
|            o----------ooooooooo  <- Miliardi ( 1 )                           |
|            oo----------oooooooo  <- Centinaia di milioni ( 2 )               |
|            ----------oooooooooo  <- Decine di milioni ( 0 )                  |
|            oooooooo----------oo  <- Milioni ( 8 )                            |
|            ----------oooooooooo  <- Centinaia di migliaia ( 0 )              |
|            ooooo----------ooooo  <- Decine di migliaia ( 5 )                 |
|            ooo----------ooooooo  <- Migliaia ( 3 )                           |
|            oooooo----------oooo  <- Centinaia ( 6 )                          |
|            oooooo----------oooo  <- Decine ( 6 )                             |
|            ooooo----------ooooo  <- Unita' ( 5 )                             |
|                                                                              |
|                                                                              |
|            -----------------------------------------------------             |
|               Valore attuale sull'abaco:  1 2 0 8 0 5 3 6 6 5                |
|            -----------------------------------------------------             |
|                                                                              |
|               Inserisci un numero (0 per uscire): ...........                |
|                                                                              |
|                                                                              |
+------------------------------------------------------------------------------+
```

---

## Note

- Il codice è scritto per QuickBASIC ma può essere eseguito anche su emulatori DOS come DOSBox.  
- Il limite massimo di valore inseribile è ±1.000.000.000 per garantire che il valore sia rappresentabile sull'abaco.  
- Il progetto è rilasciato in pubblico dominio e può essere usato e modificato liberamente.  

---

## Contatti

Autore: Marco da Venezia  
GitHub: [https://github.com/marco67ve/abaco](https://github.com/marco67ve/abaco)

---

*By Marco da Venezia con la collaborazione di Bishop (ChatGPT)*

