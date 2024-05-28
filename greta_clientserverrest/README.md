# Documentazione dell'Applicazione "Cruises Paradise"
 ### Introduzione
"Cruises Paradise" è un'applicazione mobile sviluppata con Flutter che consente agli utenti di accedere ai servizi offerti da una compagnia di crociere. L'applicazione consente agli utenti di effettuare il login, visualizzare e prenotare crociere disponibili, nonché gestire il proprio account. I dati vengono salvati in un database  recuperati con delle API. 

### Funzionalità Principali
## Login
L'applicazione offre un sistema di login per gli utenti registrati. Gli utenti possono accedere utilizzando il proprio username e password. La password viene criptata nel database. 

## Visualizzazione delle Crociere Disponibili
Gli utenti possono visualizzare un elenco delle crociere disponibili, con informazioni dettagliate su ciascuna crociera, come la destinazione, la durata e le date disponibili. Aprendo il percorso possono visualizzare tutte le città nel quale la crociera approderà.

## Prenotazione di Crociere
Una volta effettuato il login, gli utenti possono prenotare una crociera selezionata. La visualizzazione dell'elenco di crociere prenotate può essere effettuata anche senza la connessione al server contenente il database grazie all'uso di un database interno che sfrutta il pacchetto floor di flutter.

 ## Architettura dell'Applicazione
L'applicazione segue un'architettura basata su Provider e ChangeNotifier per la gestione dello stato dell'applicazione. Utilizza un database locale per memorizzare le informazioni sugli utenti e sulle prenotazioni delle crociere del pacchetto floor di dart.

 ## File dell'Applicazione
 - *accountcliente.dart*: Definisce la classe AccountCliente per rappresentare un account utente.
 - *crociera.dart*: Definisce la classe Crociera per rappresentare una Crociera.
 - *cruisedetailpage.dart*: Contiene i dettagli di una crociera
 - *dao.dart*: Contiene i Data Access Object (DAO) per interagire con il database.
 - *database.dart*: Contiene la definizione del database locale utilizzato dall'applicazione.
 - *database.g.dart*: file generato
 - *details.dart*: contiene il percorso di una crociera
 - *elenco.dart*: Contiene la logica per visualizzare l'elenco delle crociere disponibili.
 - *main.dart*: Il punto di ingresso dell'applicazione. Avvia l'applicazione e inizializza il database
 - *model.dart*: definizione delle entity del database interno
 - *prenotazione.dart*:  Definisce la classe Prenotazione per rappresentare una prenotazione.
 - *prenotazioni.dart*: logica per stampare il riepilogo delle prenotazioni
 - *registration.dart*: Contiene la logica per la registrazione di nuovi utenti.
 - *route.dart*:  Definisce la classe Route per rappresentare un percorso.