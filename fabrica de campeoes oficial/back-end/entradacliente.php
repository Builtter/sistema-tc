<?php
session_start();
class entradacliente {

    public function connection() {
        require_once 'db_config.php'; 
        $connection = new mysqli(DB_SERVERNAME, DB_USERNAME, DB_PASSWORD, DB_NAME, DB_PORT);
        if ($connection->connect_error) {
            die("Erro de conexão: " . $connection->connect_error);
        }
        mysqli_set_charset($connection, 'utf8');
        return $connection;
    }

    public function select($query){
        $connection = $this->connection();
        $result = mysqli_query($connection, $query);
        $data = mysqli_fetch_all($result, MYSQLI_ASSOC);
        mysqli_close($connection);
        return $data;
    }

    public function insert($query){
        
        $connection = $this->connection();
        $result=mysqli_query($connection, $query);

        if(!$result){
            echo mysqli_error($connection);
        }else{
            $_SESSION['logged'] = true;
        }

        mysqli_close($connection);
        return $result;
    }
    public function update($query){
        $connection = $this->connection();
        $result=mysqli_query($connection, $query);

        if(!$result){
            echo mysqli_error($connection);
        }else{
            $_SESSION['logged'] = true;
        }

        mysqli_close($connection);
        return $result;
    }
    public function delete($query){
        $connection = $this->connection();
        $result=mysqli_query($connection, $query);

        if(!$result){
            echo mysqli_error($connection);
        }

        mysqli_close($connection);
        return $result;
    }
}