<?php
require_once 'db_config.php';

$conn = new mysqli(DB_SERVERNAME, DB_USERNAME, DB_PASSWORD, DB_NAME, DB_PORT);

if ($conn->connect_error) {
    die("Erro de conexão: " . $conn->connect_error);
}

// Atualizar PedodoProduto
$sqlInsertAtt = "INSERT INTO pedido_produto (idPedido, idProduto, qtd, idEstoque)
SELECT p.idPedido, p.idEstoque, p.quantidade, p.idEstoque
FROM pedido p
WHERE NOT EXISTS 
    (SELECT 1 FROM pedido_produto pp 
        WHERE pp.idPedido = p.idPedido AND pp.idProduto = p.idEstoque)";
$stmtUpdate = $conn->prepare($sqlInsertAtt);
$stmtUpdate->execute();

if ($stmtUpdate->affected_rows > 0) {
  echo "Pedidos Atualizados!";
} else {
  echo "Sem novos pedidos!";
}

$conn->close();
?>
