<?php
class Prenotazione
	{
	private $conn;
	private $table_name = "prenotazioni_crociera";
	
	public $cf_cliente;
    public $id_crociera;
    public $data_prenotazione;
			// colonne della tabella utente


	
	public function __construct($db)	// costruttore
		{
		$this->conn = $db;
		}


	function createReservation($cf_cliente, $id_crociera, $data_prenotazione){	 
    		$query = "INSERT INTO " . $this->table_name ." SET  cf_cliente='$cf_cliente', id_crociera='$id_crociera', data_prenotazione='$data_prenotazione'"; 
    		$stmt = $this->conn->prepare($query);
    	if($stmt->execute()) return true;
    		return false;    
		}
		function readPrenotazione($cf_cliente)				
		{
		$query = "SELECT  cf_cliente, id_crociera, data_prenotazione FROM prenotazioni_crociera WHERE cf_cliente='$cf_cliente'";
		$stmt = $this->conn->prepare($query);
		$stmt->execute();		
		return $stmt;
		}



	function modifyPrenotazione($id_crociera, $cf_cliente, $id_crociera_old,$data_prenotazione){
		$id_crociera_old=  intval($id_crociera_old);
		$id_crociera=  intval($id_crociera);
		$data_prenotazione=  date("Y-m-d");
    		$query = "UPDATE prenotazioni_crociera SET id_crociera= '$id_crociera', data_prenotazione= '$data_prenotazione' WHERE id_crociera= '$id_crociera_old' AND cf_cliente='$cf_cliente'";
    		$stmt = $this->conn->prepare($query);
    		if($stmt->execute()) return true;
    		return false;
		}



		function deletePrenotazione($id_crociera, $cf_cliente){
			$id_crociera=  intval($id_crociera);
			$query = "DELETE FROM prenotazioni_crociera WHERE id_crociera = '$id_crociera' AND cf_cliente = '$cf_cliente'";
			$stmt = $this->conn->prepare($query);
			if($stmt->execute()) {
				return true;
			} else {
				return false;
			}
		}




	// CREARE Utente		da fare metodo create()
	// AGGIORNARE Utente    da fare metodo update()
	// CANCELLARE Utente	da fare	metodo delete()
	}
?>