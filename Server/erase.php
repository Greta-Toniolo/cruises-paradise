<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");	// codifica dei dati
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");				// tempo di permanenza nella cache in secondi
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
 
include_once 'database.php';
include_once 'crociera.php';
 
$database = new Database();
$db = $database->getConnection();
 
$crociera = new Crociera($db);
 
$data = json_decode(file_get_contents("php://input"));
 
$crociera->id_crociera = $data->id_crociera;

echo $crociera->id_crociera;
 
if($crociera->delete())
  {
    http_response_code(200);
    echo json_encode(array("risposta" => "Crociera e' stato eliminato"));
   }
else
  {
    http_response_code(503);						  //503 servizio non disponibile
    echo json_encode(array("risposta" => "Impossibile eliminare Crociera."));
  }
?>