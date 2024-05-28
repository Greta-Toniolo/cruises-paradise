<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
include_once 'database.php';
include_once 'route.php';

$database = new Database();
$db = $database->getConnection();
$route = new Route($db);

// Funzione per gestire la richiesta GET /getcruises
function getRoutes($idCrociera) {
    global $route;

    $stmt = $route->read($idCrociera);    // Legge i dati dal database utilizzando l'id della crociera
    $num = $stmt->rowCount();

    if($num > 0){   // Se vengono trovate route nel database
        $routes_arr = array();    // Array delle route
        $routes_arr["records"] = array();

        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
            extract($row);
            $route_item = array(
                "codice_percorso" => $codice_percorso,
                "data_ora" => $data_ora, 
                "citta" => $citta,
                "id_crociera" => $id_crociera,
            );
            array_push($routes_arr["records"], $route_item);
        }
        echo json_encode($routes_arr);    // Restituisce i dati come JSON
    } else {
        echo json_encode( array("message" => "Nessuna Route Trovata.") );
    }
}

?>
