<?php
require_once 'db_config.php';

$conn = new mysqli(DB_SERVERNAME, DB_USERNAME, DB_PASSWORD, DB_NAME, DB_PORT);

if ($conn->connect_error) {
    die("Erro de conexão: " . $conn->connect_error);
}

//data dashboard
$result = $conn->query("SELECT 
  DATE(p.dtPedido) AS dataPedido,
  SUM(p.quantidade) AS totalVendas
FROM 
  pedido as p
  INNER JOIN cliente as c ON p.idCliente = c.idCliente
  INNER JOIN telefone as t ON c.idCliente = t.idCliente
  INNER JOIN produto as pr ON p.idEstoque = pr.idProduto
GROUP BY 
  DATE(p.dtPedido)
ORDER BY 
  dataPedido");
$consultaGeral = $result->fetch_all(MYSQLI_ASSOC);

$data = array(
    'consultaGeral' => $consultaGeral
);

echo json_encode($data);

//Encerra conexão
$conn->close();