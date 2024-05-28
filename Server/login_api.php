<?php
header("Access-Control-Allow-Origin: *");	// Tutti possono accedere alla pagina
header("Content-Type: application/json; charset=UTF-8");
include_once 'database.php';						
include_once 'accountcliente.php';

$database = new Database();	// Crea un oggetto Database e si collega al database
$db = $database->getConnection();
$account = new AccountCliente($db);

// Funzione per gestire la richiesta GET /getcruises
function getPassword($username, $password) {
    global $account;

    $stmt = $account->read($username, $password);	// Legge i dati dal database
    $num = $stmt->rowCount();

    if($num > 0){	// Se vengono trovate crociere nel database
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        $storedPassword = $row['password_cliente'];
        if (password_verify($password, $storedPassword)) {
            echo "Le password corrispondono!";
        } else {
            $response = array("message" => "ERR");
    http_response_code(200);
    echo json_encode($response);
        }	// Restituisce i dati come JSON
    } else {
        $response = array("message" => "ERR");
        http_response_code(201);
        echo json_encode($response);
    }
}
function getFiscalCode($username) {
    global $account;

    $stmt = $account->readFiscalCode($username);	// Legge i dati dal database
    $num = $stmt->rowCount();

    if($num > 0){	// Se vengono trovate crociere nel database
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        $cfcliente = $row['cf_cliente'];
        echo $cfcliente;
        }	// Restituisce i dati come JSON
    else {
        $response = array("message" => "ERR");
        http_response_code(201);
        echo json_encode($response);
    }
}

// Funzione per gestire la richiesta POST /createcruise
function createAccount($username_cliente1, $password_cliente1, $cf_cliente1) {
    global $account;
    // Qui dovresti implementare la logica per creare una nuova crociera nel tuo sistema
    // Ad esempio, potresti ricevere i dati dal corpo della richiesta e inserirli nel database
    // Per semplicità, in questo esempio restituiamo solo una risposta di conferma
    $stmt = $account->createAcc($username_cliente1, $password_cliente1, $cf_cliente1);
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
function deleteAccount($cruiseId) {
    // Qui dovresti implementare la logica per eliminare una crociera dal tuo sistema
    // Ad esempio, potresti eliminare la crociera corrispondente all'ID specificato dal database
    // Per semplicità, in questo esempio restituiamo solo una risposta di conferma
    $response = array("message" => "Cruise deleted successfully");
    http_response_code(200);
    echo json_encode($response);
}

// Funzione per gestire la richiesta PUT /updatecruise/{cruiseId}
function updateAccount($cruiseId) {
    // Qui dovresti implementare la logica per aggiornare una crociera nel tuo sistema
    // Ad esempio, potresti ricevere i dati dal corpo della richiesta e aggiornare i dati nel database
    // Per semplicità, in questo esempio restituiamo solo una risposta di conferma
    $response = array("message" => "Cruise updated successfully");
    http_response_code(200);
    echo json_encode($response);
}

?>
