<?php
header("Access-Control-Allow-Origin: *");	// Tutti possono accedere alla pagina
header("Content-Type: application/json; charset=UTF-8");
include_once 'database.php';						
include_once 'prenotazione.php';

$database = new Database();	// Crea un oggetto Database e si collega al database
$db = $database->getConnection();
$prenotazione = new Prenotazione($db);

// Funzione per gestire la richiesta GET /getcruises


// Funzione per gestire la richiesta POST /createcruise
function createPrenotazione($cf_cliente, $id_crociera, $data_prenotazione) {
    global $prenotazione;
    // Qui dovresti implementare la logica per creare una nuova crociera nel tuo sistema
    // Ad esempio, potresti ricevere i dati dal corpo della richiesta e inserirli nel database
    // Per semplicità, in questo esempio restituiamo solo una risposta di conferma
    $stmt = $prenotazione->createReservation($cf_cliente, $id_crociera, $data_prenotazione);
    if ($stmt) {
        // Account creato con successo
        $response = array("success" => true, "message" => "Reservation created successfully");
        http_response_code(201);
    } else {
        // Errore durante la creazione dell'account
        $response = array("success" => false, "message" => "Failed to create Reservation");
        http_response_code(500); // Codice di errore del server interno
    }
    
    echo json_encode($response);
}
function getReservation($cf_cliente) {
    global $prenotazione;

    $stmt = $prenotazione->readPrenotazione($cf_cliente);	// Legge i dati dal database
    $num = $stmt->rowCount();

    if($num > 0){	// Se vengono trovate crociere nel database
        $crociere_arr = array();	// Array delle crociere
        $crociere_arr["records"] = array();

        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
            extract($row);
            $crociera_item = array(
                "cf_cliente" => $cf_cliente,
                "id_crociera" => $id_crociera, 
                "data_prenotazione" => $data_prenotazione,
            );
            array_push($crociere_arr["records"], $crociera_item);
        }
        echo json_encode($crociere_arr);	// Restituisce i dati come JSON
    } else {
        echo json_encode( array("message" => "Nessuna Crociera Trovata.") );
    }
}
function deleteBooking($id_crociera, $cf_cliente){
    global $prenotazione;
    // Qui dovresti implementare la logica per creare una nuova crociera nel tuo sistema
    // Ad esempio, potresti ricevere i dati dal corpo della richiesta e inserirli nel database
    // Per semplicità, in questo esempio restituiamo solo una risposta di conferma
    $stmt = $prenotazione->deletePrenotazione($id_crociera, $cf_cliente);
    if ($stmt) {
        // Account creato con successo
        $response = "ciao!";
        http_response_code(200);
        echo json_encode($response);
    } else {
        // Errore durante la creazione dell'account
        $response = array("success" => false, "message" => "Failed to delete Reservation");
        http_response_code(500); 
        echo json_encode($response);// Codice di errore del server interno
    }
    
    
}
function modifyBooking($id_crociera, $cf_cliente, $id_crociera_old,$data_prenotazione){
    global $prenotazione;
    // Qui dovresti implementare la logica per creare una nuova crociera nel tuo sistema
    // Ad esempio, potresti ricevere i dati dal corpo della richiesta e inserirli nel database
    // Per semplicità, in questo esempio restituiamo solo una risposta di conferma
    $stmt = $prenotazione->modifyPrenotazione($id_crociera, $cf_cliente, $id_crociera_old,$data_prenotazione);
    if ($stmt) {
        // Account creato con successo
        $response = "ciao!";
        http_response_code(200);
        echo json_encode($response);
    } else {
        // Errore durante la creazione dell'account
        $response = array("success" => false, "message" => "Failed to update Reservation");
        http_response_code(500); 
        echo json_encode($response);// Codice di errore del server interno
    }
    
    
}

// Funzione per gestire la richiesta DELETE /delcruises/{cruiseId}


?>
