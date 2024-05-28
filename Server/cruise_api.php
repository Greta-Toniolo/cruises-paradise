<?php
header("Access-Control-Allow-Origin: *");	// Tutti possono accedere alla pagina
header("Content-Type: application/json; charset=UTF-8");
include_once 'database.php';						
include_once 'crociera.php';

$database = new Database();	// Crea un oggetto Database e si collega al database
$db = $database->getConnection();
$crociera = new Crociera($db);

// Funzione per gestire la richiesta GET /getcruises
function getCruises() {
    global $crociera;

    $stmt = $crociera->read();	// Legge i dati dal database
    $num = $stmt->rowCount();

    if($num > 0){	// Se vengono trovate crociere nel database
        $crociere_arr = array();	// Array delle crociere
        $crociere_arr["records"] = array();

        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
            extract($row);
            $crociera_item = array(
                "id_crociera" => $id_crociera,
                "data_inizio" => $data_inizio, 
                "data_fine" => $data_fine,
                "durata_crociera" => $durata_crociera,
                "tema_crociera" => $tema_crociera,
                "id_nave" => $id_nave,
                "img" => $img,
                "localita" => $localita
            );
            array_push($crociere_arr["records"], $crociera_item);
        }
        echo json_encode($crociere_arr);	// Restituisce i dati come JSON
    } else {
        echo json_encode( array("message" => "Nessuna Crociera Trovata.") );
    }
}
function getCruise($id_crociera) {
    global $crociera;

    $stmt = $crociera->readByID($id_crociera);	// Legge i dati dal database
    $num = $stmt->rowCount();

    if($num > 0){	// Se vengono trovate crociere nel databas

        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
            extract($row);
            $crociera_item = array(
                "id_crociera" => $id_crociera,
                "data_inizio" => $data_inizio, 
                "data_fine" => $data_fine,
                "durata_crociera" => $durata_crociera,
                "tema_crociera" => $tema_crociera,
                "id_nave" => $id_nave,
                "img" => $img,
                "localita" => $localita
            );
        }
        echo json_encode($crociera_item);	// Restituisce i dati come JSON
    } else {
        echo json_encode( array("message" => "Nessuna Crociera Trovata.") );
    }
}

// Funzione per gestire la richiesta POST /createcruise
function createCruise() {
    // Qui dovresti implementare la logica per creare una nuova crociera nel tuo sistema
    // Ad esempio, potresti ricevere i dati dal corpo della richiesta e inserirli nel database
    // Per semplicità, in questo esempio restituiamo solo una risposta di conferma
    $response = array("message" => "Cruise created successfully");
    http_response_code(201);
    echo json_encode($response);
}

// Funzione per gestire la richiesta DELETE /delcruises/{cruiseId}
function deleteCruise($cruiseId) {
    // Qui dovresti implementare la logica per eliminare una crociera dal tuo sistema
    // Ad esempio, potresti eliminare la crociera corrispondente all'ID specificato dal database
    // Per semplicità, in questo esempio restituiamo solo una risposta di conferma
    $response = array("message" => "Cruise deleted successfully");
    http_response_code(200);
    echo json_encode($response);
}

// Funzione per gestire la richiesta PUT /updatecruise/{cruiseId}
function updateCruise($cruiseId) {
    // Qui dovresti implementare la logica per aggiornare una crociera nel tuo sistema
    // Ad esempio, potresti ricevere i dati dal corpo della richiesta e aggiornare i dati nel database
    // Per semplicità, in questo esempio restituiamo solo una risposta di conferma
    $response = array("message" => "Cruise updated successfully");
    http_response_code(200);
    echo json_encode($response);
}

?>
