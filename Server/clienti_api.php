<?php
header("Access-Control-Allow-Origin: *");	// Tutti possono accedere alla pagina
header("Content-Type: application/json; charset=UTF-8");
include_once 'database.php';						
include_once 'cliente.php';

$database = new Database();	// Crea un oggetto Database e si collega al database
$db = $database->getConnection();
$cli = new Clienti($db);

// Funzione per gestire la richiesta GET /getcruises



// Funzione per gestire la richiesta POST /createcruise
function createCliente($cf_cliente, $nome_cliente, $cognome_cliente, $email_cliente, $telefono_cliente) {
    global $cli;
    // Qui dovresti implementare la logica per creare una nuova crociera nel tuo sistema
    // Ad esempio, potresti ricevere i dati dal corpo della richiesta e inserirli nel database
    // Per semplicità, in questo esempio restituiamo solo una risposta di conferma
    $stmt = $cli->createClienti($cf_cliente, $nome_cliente, $cognome_cliente, $email_cliente, $telefono_cliente);
    if ($stmt) {
        // Account creato con successo
        $response = array("success" => true, "message" => "Account created successfully");
        http_response_code(201);
    } else {
        // Errore durante la creazione dell'account
        $response = array("success" => false, "message" => "Failed to create account");
        http_response_code(500); // Codice di errore del server interno
    }
    
    echo json_encode($response);
}

// Funzione per gestire la richiesta DELETE /delcruises/{cruiseId}


// Funzione per gestire la richiesta PUT /updatecruise/{cruiseId}


?>
