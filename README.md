# Progetto di Prenotazione Crociere

## Descrizione del Progetto

Questo progetto consiste in un sistema integrato per la gestione e la prenotazione di crociere. Il sistema comprende:
- Un sito web per la gestione amministrativa delle crociere e dei clienti.
- Un'app mobile Flutter per la prenotazione e la visualizzazione delle crociere.
- Un'API OpenAPI per la comunicazione tra l'applicazione mobile e il database.

## Struttura del Progetto

### 1. Sito Web
- **Tecnologie Utilizzate:** PHP, HTML, Tailwind CSS
- **Funzionalità:**
  - Login crittografato per garantire l'accesso sicuro.
  - Gestione delle crociere: creazione, modifica e eliminazione delle crociere.
  - Gestione dei clienti: creazione, modifica e eliminazione dei clienti.
  - Visualizzazione delle crociere e delle escursioni disponibili.

### 2. Applicazione Mobile
- **Tecnologie Utilizzate:** Flutter
- **Package Principali:** 
  - `floor e MySqlLite` per la gestione del database locale.
- **Funzionalità:**
  - Login crittografato per garantire l'accesso sicuro.
  - Prenotazione delle crociere.
  - Visualizzazione delle crociere e delle escursioni disponibili.
  - Sincronizzazione con l'API per ottenere dati aggiornati.

### 3. API
- **Utilizzo:** L'API viene utilizzata dall'applicazione mobile per comunicare con il server e ottenere dati aggiornati sulle crociere e le escursioni.
- **Standard:** OpenAPI
- **Endpoint Principali:**
  - Autenticazione e gestione del login.
  - Recupero delle informazioni sulle crociere.
  - Prenotazione delle crociere.
  - Gestione delle escursioni.

## Installazione

### Requisiti
- PHP 7.4 o superiore
- Flutter SDK
- Dart
- MySQL o altro database supportato

### Istruzioni

#### Sito Web
1. Clona il repository:
    ```sh
    git clone https://github.com/tuo-username/cruises-paradise.git
    ```
2. In questo progetto è stato utilizzato xampp come server web. Inserisci il server nella cartella 'htdocs' e avvia Apache e MySql

#### Applicazione Mobile
1. Clona il repository (se non l'hai già fatto):
    ```sh
    git clone https://github.com/tuo-username/cruises-paradise.git
    ```

2. Installa le dipendenze Flutter:
    ```sh
    flutter pub get
    ```

3. Configura l'applicazione con le impostazioni necessarie per la connessione all'API.

4. Avvia l'applicazione:
    ```sh
    flutter run
    ```

### Configurazione dell'API
1. Ho definito gli endpoint e le loro specifiche seguendo lo standard OpenAPI.
2. Ho configurato il server per gestire le richieste API.
3. Ho integrato l'API con il database per recuperare e aggiornare i dati delle crociere e delle escursioni.

## Utilizzo

### Sito Web
1. Accedi alla pagina di login e inserisci le tue credenziali.
2. Utilizza le funzionalità di gestione per aggiungere, modificare o eliminare crociere e clienti.
3. Visualizza le crociere disponibili e le loro escursioni.

### Applicazione Mobile
1. Avvia l'applicazione e accedi con le tue credenziali.
2. Visualizza le crociere e le escursioni disponibili.
3. Prenota una crociera direttamente dall'app.
---

Grazie per aver utilizzato il nostro sistema di prenotazione crociere!