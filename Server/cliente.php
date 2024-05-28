<?php
class Clienti
{
    private $conn;
    private $table_name = "clienti";

    public $cf_cliente;
    public $nome_cliente;
    public $cognome_cliente;
    public $email_cliente;
    public $telefono_cliente;



    public function __construct($db)	// costruttore
    {
        $this->conn = $db;
    }

    function read($username, $password)
    {
        $query = "SELECT  password_cliente FROM account_clienti WHERE username_cliente='$username'";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }


    function createClienti($cf_cliente, $nome_cliente, $cognome_cliente, $email_cliente, $telefono_cliente)
    {
        $query = "INSERT INTO " . $this->table_name . " SET cf_cliente='$cf_cliente', nome_cliente='$nome_cliente', cognome_cliente='$cognome_cliente', email_cliente='$email_cliente', telefono_cliente='$telefono_cliente'";
        $stmt = $this->conn->prepare($query);
        if ($stmt->execute())
            return true;
        return false;
    }


    function update()
    {

        echo "*************  PUNTO 4";
        $query = "UPDATE " . $this->table_name . " SET data_inizio= :data_inizio, data_fine= :data_fine, durata_crociera= :durata_crociera, tema_crociera= :tema_crociera, id_nave= :id_nave, localita= :localita WHERE id_crociera= :id_crociera";
        $stmt = $this->conn->prepare($query);

        $this->id_crociera = htmlspecialchars(strip_tags($this->id_crociera));		// strip_tags rimuove i tag HTML e PHP
        $this->data_inizio = htmlspecialchars(strip_tags($this->data_inizio));	// htmlspecialchars converte i caratteri in HTML
        $this->data_fine = htmlspecialchars(strip_tags($this->data_fine));
        $this->durata_crociera = htmlspecialchars(strip_tags($this->durata_crociera));
        $this->tema_crociera = htmlspecialchars(strip_tags($this->tema_crociera));
        $this->id_nave = htmlspecialchars(strip_tags($this->id_nave));
        $this->localita = htmlspecialchars(strip_tags($this->localita));

        $stmt->bindParam(":id_crociera", $this->id_crociera);
        $stmt->bindParam(":data_inizio", $this->data_inizio);
        $stmt->bindParam(":data_fine", $this->data_fine);
        $stmt->bindParam(":durata_crociera", $this->durata_crociera);
        $stmt->bindParam(":tema_crociera", $this->tema_crociera);
        $stmt->bindParam(":id_nave", $this->id_nave);
        $stmt->bindParam(":localita", $this->localita);
        if ($stmt->execute())
            return true;
        return false;
    }



    function delete()
    {
        $query = "DELETE FROM " . $this->table_name . " WHERE id_crociera = ?";
        $stmt = $this->conn->prepare($query);
        $this->id = htmlspecialchars(strip_tags($this->id_crociera));
        $stmt->bindParam(1, $this->id_crociera);
        if ($stmt->execute())
            return true;
        return false;
    }




    // CREARE Utente		da fare metodo create()
    // AGGIORNARE Utente    da fare metodo update()
    // CANCELLARE Utente	da fare	metodo delete()
}
?>