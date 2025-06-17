<?php
require_once 'db_config.php';

$conn = new mysqli(DB_SERVERNAME, DB_USERNAME, DB_PASSWORD, DB_NAME, DB_PORT);

if ($conn->connect_error) {
    die("Erro de conexão: " . $conn->connect_error);
}

$nome = $_POST['nome'];
$descricao = $_POST['descricao'];
$quantidade = $_POST['quantidade'];
$preco = $_POST['preco'];

$sql = "INSERT INTO produto (nome, descricao, quantidade, preco) VALUES (?, ?, ?, ?)";
$stmt = $conn->prepare($sql);
//var_dump($conn,$stmt, $sql); // Debugging line to check if the statement is prepared correctly
$stmt->bind_param("ssid", $nome, $descricao, $quantidade, $preco);

if ($stmt->execute()) {
  echo "Produto cadastrado com sucesso.";
  //fazer redirecionamento para a página de produtos
  header("Location: ../front-end/estoque.html"); // Redireciona para a página de produtos
} else {
  echo "Erro ao cadastrar: " . $conn->error;
}

$sql = "INSERT INTO estoque (descricao) VALUES (?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $descricao);

if ($stmt->execute()) {
  echo "Estoque cadastrado com sucesso.";
} else {
  echo "Erro ao cadastrar: " . $conn->error;
}

$conn->close();
?>
