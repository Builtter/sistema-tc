<?php
require_once 'db_config.php';

$conn = new mysqli(DB_SERVERNAME, DB_USERNAME, DB_PASSWORD, DB_NAME, DB_PORT);

if ($conn->connect_error) {
    die("Erro de conexão: " . $conn->connect_error);
}

$id = $_POST['id'];
$quantidade = $_POST['quantidade'];

// Consultar quantidade atual do produto
$sqlConsulta = "SELECT quantidade FROM produto WHERE idProduto = ?";
$stmtConsulta = $conn->prepare($sqlConsulta);
$stmtConsulta->bind_param("i", $id);
$stmtConsulta->execute();
$stmtConsulta->bind_result($quantidadeAtual);
$stmtConsulta->fetch();
$stmtConsulta->close();

// Atualizar quantidade do produto
$novaQuantidade = $quantidadeAtual + $quantidade;
$sqlUpdate = "UPDATE produto SET quantidade = ? WHERE idProduto = ?";
$stmtUpdate = $conn->prepare($sqlUpdate);
$stmtUpdate->bind_param("ii", $novaQuantidade, $id);
$stmtUpdate->execute();

if ($stmtUpdate->execute()) {
  echo "<script>alert('Estoque atualizado com sucesso.'); window.location.href = '../front-end/estoque.html';</script>";
} else {
  echo "Erro ao atualizar: " . $conn->error;
}

$conn->close();
?>
