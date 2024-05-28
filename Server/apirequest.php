<?php

// Include i file delle API
include 'cruise_api.php';
include 'routes_api.php';
include 'login_api.php';
include 'reservation_api.php';
include 'clienti_api.php';
/*include 'boat_api.php';
include 'client_api.php';
include 'route_api.php';
include 'reservation_api.php';
include 'account_api.php';*/

// Routing delle richieste
$requestMethod = $_SERVER["REQUEST_METHOD"];
$requestUri = $_SERVER["REQUEST_URI"];


// Gestisci le richieste in base al percorso e al metodo
if ($_SERVER['REQUEST_METHOD'] === 'GET' && $requestUri === '/REST/Server/apirequest.php/connection') {
    
    // Prova a connetterti al database o esegui altre operazioni necessarie
    // Se la connessione ha successo, restituisci una risposta di successo
    http_response_code(200);
    echo json_encode(array('message' => 'Connessione riuscita'));
}
elseif($requestMethod === 'GET' && $requestUri === '/REST/Server/apirequest.php/getcruises') {
    getCruises();
} elseif ($requestMethod === 'POST' && $requestUri === '/createcruise') {
    createCruise();
} elseif ($requestMethod === 'DELETE' && preg_match('/^\/delcruises\/(\d+)$/', $requestUri, $matches)) {
    deleteCruise($matches[1]);
} elseif ($requestMethod === 'PUT' && preg_match('/^\/updatecruise\/(\d+)$/', $requestUri, $matches)) {
    updateCruise($matches[1]);
} elseif ($requestMethod === 'GET' && strpos($requestUri, '/REST/Server/apirequest.php/getroutes') !== false) {
    if (isset($_GET['id_crociera'])) {
        $idCrociera = $_GET['id_crociera'];
        getRoutes($idCrociera);
    }
    }
    elseif ($requestMethod === 'GET' && strpos($requestUri, '/REST/Server/apirequest.php/getpassword') !== false) {
        // Controlla se è stato ricevuto il parametro username
        if (isset($_GET['username']) && isset($_GET['password'])) {
            // Recupera l'username e la password dalla richiesta GET
            $username = $_GET['username'];
            $password = $_GET['password'];
        }
        getPassword($username, $password);

    } 
    elseif ($requestMethod === 'GET' && strpos($requestUri, '/REST/Server/apirequest.php/getcfcliente') !== false) {
        // Controlla se è stato ricevuto il parametro username
        if (isset($_GET['username'])) {
            // Recupera l'username e la password dalla richiesta GET
            $username = $_GET['username'];
            getFiscalCode($username);
        }
        

    } 
    elseif ($requestMethod === 'GET' && strpos($requestUri, '/REST/Server/apirequest.php/getreservation') !== false) {
        // Controlla se è stato ricevuto il parametro username
        if (isset($_GET['cf_cliente'])) {
            // Recupera l'username e la password dalla richiesta GET
            $cf_cliente = $_GET['cf_cliente'];
            getReservation($cf_cliente);
        }
        

    } 
    elseif ($requestMethod === 'GET' && strpos($requestUri, '/REST/Server/apirequest.php/getcruise') !== false) {
        // Controlla se è stato ricevuto il parametro username
        if (isset($_GET['id_crociera'])) {
            // Recupera l'username e la password dalla richiesta GET
            $id_crociera = $_GET['id_crociera'];
            getCruise($id_crociera);
        }
        
    } 
    elseif ($requestMethod === 'POST' && strpos($requestUri, '/REST/Server/apirequest.php/newuser') !== false) {
        // Controlla se è stato ricevuto il parametro username
        if (isset($_POST['username']) && isset($_POST['password']) && isset($_POST['fiscalcode'])) {
            // Recupera l'username e la password dalla richiesta GET
            $username= $_POST['username'];
            $password = $_POST['password'];
            $cf_cliente= $_POST['fiscalcode'];
            createAccount($username, $password, $cf_cliente);
        }
        

    }
    elseif ($requestMethod === 'POST' && strpos($requestUri, '/REST/Server/apirequest.php/newreserve') !== false) {
        // Controlla se è stato ricevuto il parametro username
        if (isset($_POST['cf_cliente']) && isset($_POST['id_crociera']) && isset($_POST['data_prenotazione'])) {
            // Recupera l'username e la password dalla richiesta GET
            $cf_cliente= $_POST['cf_cliente'];
            $id_crociera = $_POST['id_crociera'];
            $data_prenotazione= $_POST['data_prenotazione'];
            createPrenotazione($cf_cliente, $id_crociera, $data_prenotazione);
        }
        

    } elseif ($requestMethod === 'POST' && strpos($requestUri, '/REST/Server/apirequest.php/newclient') !== false) {
        // Controlla se è stato ricevuto il parametro username
        if (isset($_POST['fiscalcode']) && isset($_POST['nome']) && isset($_POST['cognome']) && isset($_POST['email']) && isset($_POST['phone'])) {
            // Recupera l'username e la password dalla richiesta GET
            $cf_cliente= $_POST['fiscalcode'];
            $nome_cliente = $_POST['nome'];
            $cognome_cliente= $_POST['cognome'];
            $email_cliente= $_POST['email'];
            $telefono_cliente= $_POST['phone'];

            createCliente($cf_cliente, $nome_cliente, $cognome_cliente, $email_cliente, $telefono_cliente);
        }
        

    }
    elseif ($requestMethod === 'DELETE' && strpos($requestUri, '/REST/Server/apirequest.php/deletebooking') !== false) {
        // Controlla se è stato ricevuto il parametro username
        $requestData = file_get_contents("php://input");
        $data = json_decode($requestData, true); // Decodifica i dati JSON
        
        // Controlla se sono stati ricevuti i parametri id_crociera e cf_cliente
        if (isset($data['id_crociera']) && isset($data['cf_cliente'])) {
            // Recupera i parametri dalla richiesta
            $id_crociera = $data['id_crociera'];
            $cf_cliente = $data['cf_cliente'];
    
            // Esegui l'operazione di eliminazione
            deleteBooking($id_crociera, $cf_cliente);
        } else {
            // Parametri mancanti nella richiesta
            http_response_code(400);
            echo json_encode(array("message" => "Parametri mancanti nella richiesta."));
        }

    }
    elseif ($requestMethod === 'PUT' && strpos($requestUri, '/REST/Server/apirequest.php/modifybooking') !== false) {
        // Controlla se è stato ricevuto il parametro username
        $requestData = file_get_contents("php://input");
        $data = json_decode($requestData, true); // Decodifica i dati JSON
        
        // Controlla se sono stati ricevuti i parametri id_crociera e cf_cliente
        if (isset($data['id_crociera']) && isset($data['cf_cliente']) && isset($data['data_prenotazione'])&& isset($data['id_crociera_old'])) {
            // Recupera i parametri dalla richiesta
            $id_crociera = $data['id_crociera'];
            $id_crociera_old = $data['id_crociera_old'];
            $cf_cliente = $data['cf_cliente'];
            $data_prenotazione = $data['data_prenotazione'];
    
            // Esegui l'operazione di eliminazione
            modifyBooking($id_crociera, $cf_cliente, $id_crociera_old, $data_prenotazione);
        } else {
            // Parametri mancanti nella richiesta
            http_response_code(400);
            echo json_encode(array("message" => "Parametri mancanti nella richiesta."));
        }

    }/* elseif ($requestMethod === 'GET' && $requestUri === '/getnave') {
    getBoats();
} elseif ($requestMethod === 'POST' && $requestUri === '/createnave') {
    createBoat();
} elseif ($requestMethod === 'DELETE' && preg_match('/^\/delnave\/(\d+)$/', $requestUri, $matches)) {
    deleteBoat($matches[1]);
} elseif ($requestMethod === 'PUT' && preg_match('/^\/updatenave\/(\d+)$/', $requestUri, $matches)) {
    updateBoat($matches[1]);
} elseif ($requestMethod === 'GET' && $requestUri === '/getcliente') {
    getClients();
} elseif ($requestMethod === 'POST' && $requestUri === '/createcliente') {
    createClient();
} elseif ($requestMethod === 'DELETE' && preg_match('/^\/delcliente\/(\d+)$/', $requestUri, $matches)) {
    deleteClient($matches[1]);
} elseif ($requestMethod === 'PUT' && preg_match('/^\/updatecliente\/(\d+)$/', $requestUri, $matches)) {
    updateClient($matches[1]);
} elseif ($requestMethod === 'GET' && $requestUri === '/createroute') {
    getRoutes();
} elseif ($requestMethod === 'POST' && $requestUri === '/createroute') {
    createRoute();
} elseif ($requestMethod === 'DELETE' && preg_match('/^\/delroute\/(\d+)$/', $requestUri, $matches)) {
    deleteRoute($matches[1]);
} elseif ($requestMethod === 'PUT' && preg_match('/^\/updateroute\/(\d+)$/', $requestUri, $matches)) {
    updateRoute($matches[1]);
} elseif ($requestMethod === 'GET' && preg_match('/^\/getreservation\/(\d+)$/', $requestUri, $matches)) {
    getReservations($matches[1]);
} elseif ($requestMethod === 'GET' && preg_match('/^\/login\/(.+)\/(.+)$/', $requestUri, $matches)) {
    login($matches[1], $matches[2]);
}*/ else {
    // Se il percorso richiesto non corrisponde a nessuna route definita, restituisci un errore 404
    http_response_code(404);
    header('Content-Type: application/json');
    echo json_encode(array("error" => "Route not found"));
    echo $_SERVER["REQUEST_URI"];

}
?>
