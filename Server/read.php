<?php				// preleva dei dati dal database e li restituisce in formato json 
								
header("Access-Control-Allow-Origin: *");				// tutti possono accedere alla pagina
header("Content-Type: application/json; charset=UTF-8");		// restituisce in formato json UTF-8

include_once 'database.php';						
include_once 'crociera.php';

$database = new Database();						// crea un oggetto Database e si collega al database
$db = $database->getConnection();

$crociera = new Crociera($db);						// crea un oggetto Utente
$stmt = $crociera->read();						// legge i dati col metodo read creato da noi
$num = $stmt->rowCount();

if($num>0){								// se vengono trovati utenti nel database 
    $crociere_arr = array();						// array di utenti
    $crociere_arr["records"] = array();
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
        extract($row);
        $crociera_item = array(						// crea un array con i dati in formato json
            "id_crociera" => $id_crociera,
            "data_inizio" => $data_inizio, 
            "data_fine" => $data_fine,
            "durata_crociera" => $durata_crociera,
            "tema_crociera" => $tema_crociera,
            "id_nave" => $id_nave,
            "localita" => $localita
        );
        array_push($crociere_arr["records"], $crociera_item);
    }
    echo json_encode($crociere_arr);					// restituisce i dati in formato json
}
else
    echo json_encode( array("message" => "Nessuna Crociera Trovata.")  );

?>