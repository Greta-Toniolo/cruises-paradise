<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");					// indica che usa il metodo post
//header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
 
include_once 'database.php';
include_once 'crociera.php';
 
$database = new Database();
$db = $database->getConnection();
$crociera = new Crociera($db);
$data = json_decode(file_get_contents("php://input"));			// prende il contenuto URL e lo converte da  JSON a PHP		
	

								
if( !empty($data->id_crociera) && !empty($data->data_inizio) && !empty($data->data_fine) && !empty($data->durata_crociera)  && !empty($data->tema_crociera) && !empty($data->id_nave) && !empty($data->localita)){
    $crociera->id_crociera = $data->id_crociera;
    $crociera->data_inizio = $data->data_inizio;
    $crociera->data_fine = $data->data_fine;
    $crociera->durata_crociera = $data->durata_crociera;
    $crociera->tema_crociera = $data->tema_crociera;
    $crociera->id_nave = $data->id_nave;
    $crociera->localita = $data->localita;

    if($crociera->create()){
        http_response_code(201);
        echo json_encode(array("message" => "Crociera creato correttamente."));
       }
    else{
        http_response_code(503);				  		//503 servizio non disponibile
        echo json_encode(array("message" => "Impossibile creare crociera."));
       }
   }
else{
    http_response_code(400); 							//400 bad request
    echo json_encode(array("message" => "Impossibile creare crociera i dati sono incompleti."));
   }
?>