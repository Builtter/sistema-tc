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

$prodImg = $_FILES['imagem']['tmp_name'];
$nomeArquivo = substr($_FILES['imagem']['name'], 0, strrpos($_FILES['imagem']['name'], '.'));
$tamanho_permitido = 1024000; // 1 MB
$pasta = '/imagens';

// Check if image is uploaded
if (!empty($prodImg)) {
    $file = getimagesize($prodImg);

    // Check file size
    if ($_FILES['imagem']['size'] > $tamanho_permitido) {
        echo "erro - arquivo muito grande";
        exit();
    }

    // Check file extension
    var_dump(preg_match('/^imagem\/(?:jpg|jpeg|png)$/i', $file['mime']));
    if (preg_match('/^imagem\/(?:jpg|jpeg|png)$/i', $file['mime'])) {
        echo "erro - extensão não permitida";
        exit();
    }

    // Get file extension
    $extensao = str_ireplace("/", "", strchr($file['mime'], "/"));

    // Create new destination path
    $novoDestino = "{$pasta}/cad_prod_" . $nomeArquivo . '_' . uniqid('', true) . '.' . $extensao;
    move_uploaded_file($prodImg, $novoDestino);
} else {
    $novoDestino = null;
}

$sql = "INSERT INTO produto (nome, descricao, quantidade, preco, imagem) VALUES (?, ?, ?, ?, ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ssids", $nome, $descricao, $quantidade, $preco, $novoDestino);

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
