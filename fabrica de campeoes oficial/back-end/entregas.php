<?php
require_once 'db_config.php';

$conn = new mysqli(DB_SERVERNAME, DB_USERNAME, DB_PASSWORD, DB_NAME, DB_PORT);

if ($conn->connect_error) {
    die("Erro de conexão: " . $conn->connect_error);
}

//ultimos pedidos
$result = $conn->query("SELECT 
  p.protCompra,
  c.idCliente,
  c.nome AS nomeCliente,
  t.numero AS telefone,
  p.dtPedido AS dataPedido,
  pr.nome AS nomeProduto,
  pr.descricao AS descricaoProduto,
  COALESCE(p.tipoPagamento, ' - ') As formaPagamento,
  COALESCE(e.status, 'aguardando') AS status
FROM 
  pedido as p
  INNER JOIN cliente as c ON p.idCliente = c.idCliente
  INNER JOIN telefone as t ON c.idCliente = t.idCliente
  INNER JOIN produto as pr ON p.idEstoque = pr.idProduto
  LEFT JOIN entrega as e ON p.protCompra = e.idPedido
  ORDER BY p.dtPedido DESC
  LIMIT 25 ");
$ultimosPedidos = '';
while($row = $result->fetch_assoc()) {
    $ultimosPedidos .= implode(', ', $row) . "\n";
}

echo nl2br($ultimosPedidos);

//Encerra conexão
$conn->close();