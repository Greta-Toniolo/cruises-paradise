<?php
class Database					// classe PHP con metodo per collegarsi al database
  {
      private $host =     "localhost";		// credenziali
      private $db_name =  "crociera";
      private $username = "root";
      private $password = "";
      public $conn;
	
      public function getConnection()		// connessione al database
	{
	  try
	      {
                $this->conn = new PDO("mysql:host=$this->host;  dbname=$this->db_name", $this->username, $this->password);
		$this->conn->exec("set names utf8");
	      }
	  catch(PDOException $exception)
	      {
		echo "Errore di connessione: " . $exception->getMessage();
	       }
	  return $this->conn;
        }
  }
?>