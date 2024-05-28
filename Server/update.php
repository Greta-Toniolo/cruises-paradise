<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
 
include_once 'database.php';
include_once 'crociera.php';


$database = new Database();
$db = $database->getConnection();
 
$crociera = new Crociera($db);
 
$data = json_decode(file_get_contents("php://input"));
 
$crociera->id_crociera = $data->id_crociera;
$crociera->data_inizio = $data->data_inizio;
$crociera->data_fine = $data->data_fine;
$crociera->durata_crociera = $data->durata_crociera;
$crociera->tema_crociera = $data->tema_crociera;
$crociera->id_nave = $data->id_nave;
$crociera->localita = $data->localita;
 


if($crociera->update())
  {
    http_response_code(200);
    echo json_encode(array("risposta" => "Crociera aggiornata"));
  }
  else
  {    
    http_response_code(503);						//503 servizio non disponibile
    echo json_encode(array("risposta" => "Impossibile aggiornare crociera"));
  }
?>
 