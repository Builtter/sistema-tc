<?php
require_once 'db_config.php';

$conn = new mysqli(DB_SERVERNAME, DB_USERNAME, DB_PASSWORD, DB_NAME, DB_PORT);

if ($conn->connect_error) {
    die("Erro de conexão: " . $conn->connect_error);
}

//Resgata id produtos estoque negativo
$result = $conn->query("SELECT idProduto FROM produto WHERE quantidade < 10");
$produtosEmEstoque = [];
while($row = $result->fetch_assoc()) {
    $produtosEmEstoque[] = $row;
}

$data = array (
    'produtosEmEstoque' => $produtosEmEstoque
);

echo json_encode($data);