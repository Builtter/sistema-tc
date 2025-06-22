<?php
require_once 'db_config.php';

$conn = new mysqli(DB_SERVERNAME, DB_USERNAME, DB_PASSWORD, DB_NAME, DB_PORT);

if ($conn->connect_error) {
    die("Erro de conexão: " . $conn->connect_error);
}

// Dados do formulário
$nome = $_POST['nome'];
$email = $_POST['email'];
$telefone = $_POST['telefone'];
$logradouro = $_POST['logradouro'];
$uf = $_POST['uf'];
$endereco = $_POST['logradouro'];
$cpf_cnpj = $_POST['cpf_cnpj'];
$datanasc = $_POST['datanasc'];
$senha = md5($_POST['senha']); 


// Inserir cliente
$stmt = $conn->prepare("INSERT INTO cliente (nome, cpfCnpj, dataNasc, senha) VALUES (?, ?, ?,?)");
$stmt->bind_param("ssss", $nome, $cpf_cnpj, $datanasc, $senha);

if ($stmt->execute()) {
    $idCliente = $stmt->insert_id;

    // Email
    $dtTemp = 0;
    $stmtEmail = $conn->prepare("INSERT INTO email (email, idCliente, cliente_idCliente) VALUES (?, ?, ?)");
    $stmtEmail->bind_param("sii", $email, $idCliente, $dtTemp);
    $stmtEmail->execute();

    // Telefone
    $stmtTel = $conn->prepare("INSERT INTO telefone (numero, idCliente, cliente_idCliente) VALUES (?, ?, ?)");
    $stmtTel->bind_param("sii", $telefone, $idCliente, $dtTemp);
    $stmtTel->execute();

    // Endereço 
    $stmtEnd = $conn->prepare("INSERT INTO endereco (logradouro, complemento, idCliente, idCidade, cliente_idCliente) VALUES (?, '', ?, 1,?)");
    $stmtEnd->bind_param("sii", $endereco, $idCliente, $dtTemp);
    $stmtEnd->execute();

    // estado
    $stmtEstado = $conn->prepare("INSERT INTO estado (UF, descricao, cidade_idCidade, cidade_endereco_idEndereco) VALUES (?, ?,?,?)");
    $stmtEstado->bind_param("ssii", $uf, $uf, $dtTemp, $dtTemp);
    $stmtEstado->execute();
    
    // Usuario
    $stmtUsuario = $conn->prepare("INSERT INTO usuario (idCliente, senha, cliente_idCliente) VALUES (?, ?, ?)");
    $stmtUsuario->bind_param("isi", $idCliente, $senha, $dtTemp);
    $stmtUsuario->execute();

    

    

    echo "<script>alert('Cadastro realizado com sucesso!'); window.location.href='../front-end/login.html';</script>";
} else {
    echo "Erro ao cadastrar: " . $stmt->error;
}


// Verifica se o Estado já existe
$stmtEstado = $conn->prepare("SELECT idEstado FROM Estado WHERE UF = ?");
$stmtEstado->bind_param("s", $uf);
$stmtEstado->execute();
$resultEstado = $stmtEstado->get_result();

if ($resultEstado->num_rows > 0) {
    $rowEstado = $resultEstado->fetch_assoc();
    $idEstado = $rowEstado['idEstado'];
} else {
    // Se não existir, insere novo estado com descrição igual ao UF
    $stmtInsertEstado = $conn->prepare("INSERT INTO Estado (UF, descricao) VALUES (?, ?)");
    $stmtInsertEstado->bind_param("ss", $uf, $uf);
    $stmtInsertEstado->execute();
    $idEstado = $stmtInsertEstado->insert_id;
}

// Verifica se já existe uma cidade genérica "Capital" no estado
$stmtCidade = $conn->prepare("SELECT idCidade FROM Cidade WHERE descricao = 'Capital' AND idEstado = ?");
$stmtCidade->bind_param("i", $idEstado);
$stmtCidade->execute();
$resultCidade = $stmtCidade->get_result();

if ($resultCidade->num_rows > 0) {
    $rowCidade = $resultCidade->fetch_assoc();
    $idCidade = $rowCidade['idCidade'];
} else {
    // Se não existir, insere cidade genérica chamada "Capital"
    $stmtInsertCidade = $conn->prepare("INSERT INTO Cidade (descricao, idEstado) VALUES ('Capital', ?)");
    $stmtInsertCidade->bind_param("i", $idEstado);
    $stmtInsertCidade->execute();
    $idCidade = $stmtInsertCidade->insert_id;
}

$conn->close();

?>
