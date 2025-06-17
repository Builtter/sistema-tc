<?php
require_once 'db_config.php';

$conn = new mysqli(DB_SERVERNAME, DB_USERNAME, DB_PASSWORD, DB_NAME, DB_PORT);

if ($conn->connect_error) {
    die("Erro de conexão: " . $conn->connect_error);
}

// Dados do formulário
$itens = json_decode(file_get_contents('php://input'), true);

if (isset($_SERVER['HTTP_X_REQUESTED_WITH']) && $_SERVER['HTTP_X_REQUESTED_WITH'] == 'XMLHttpRequest') {
    $carrinho = json_decode($_POST['itens'], true);
    $itens = $carrinho;
}

session_start();
$globalUsuario = $_SESSION['usuario'];

function cadastrarPedidoCarrinho($conn, $itens) {  
    global $globalUsuario;
    $idCliente = $globalUsuario['idCliente'];
    date_default_timezone_set('America/Sao_Paulo');
    $dtHoraPedido = date('Y-m-d H:i:s');
    $dtPedido = date('Y-m-d');
    
    // Gera um id_compra para ser cadastrado no banco
    $protCompra = uniqid($dtPedido . '#');
    if ($idCliente == null) {
        http_response_code(401);
        echo "Usuário não autenticado.";
        exit;
    }

    $notaCompra = ($itens['rating'] == null) ? 0 : $itens['rating'];
    global $quantidadeAtual;
    foreach ($itens['itens'] as $item) {
        $idEstoque = $item['id'];
        $descricao = $item['nome'];
        $quantidade = $item['quantidade'];
        $vlCompra = $item['total'];

        $stmt = $conn->prepare("INSERT INTO pedido (idCliente, descricao, quantidade, dtPedido, idEstoque, vlCompra, avaliaCompra, protCompra) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("isisisis", $idCliente, $descricao, $quantidade, $dtHoraPedido, $idEstoque, $vlCompra, $notaCompra, $protCompra);
        $stmt->execute();

        // Consultar quantidade atual do produto
        $sqlConsultaQtd = "SELECT quantidade FROM produto WHERE idProduto = ?";
        $stmt = $conn->prepare($sqlConsultaQtd);
        $stmt->bind_param("i", $idEstoque);
        $stmt->execute();
        $stmt->bind_result($quantidadeAtual);
        $stmt->fetch();
        $stmt->close();

        // Atualizar quantidade do produto
        $novaQuantidade = $quantidadeAtual - $quantidade;
        $sqlUpdate = "UPDATE produto SET quantidade = ? WHERE idProduto = ?";
        $stmtUpdate = $conn->prepare($sqlUpdate);
        $stmtUpdate->bind_param("ii", $novaQuantidade, $idEstoque);
        $stmtUpdate->execute();
    }

    http_response_code(200);
    echo $protCompra;
}

cadastrarPedidoCarrinho($conn, $itens);