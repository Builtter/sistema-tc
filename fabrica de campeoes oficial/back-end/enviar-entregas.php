<?php
require_once 'db_config.php';

$conn = new mysqli(DB_SERVERNAME, DB_USERNAME, DB_PASSWORD, DB_NAME, DB_PORT);

if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode(array('status' => 'erro', 'mensagem' => 'Erro na conexão: ' . $conn->connect_error));
    exit;
}

$json = json_decode(file_get_contents('php://input'), true);
$protCompra = $json['protCompra'];

function enviarEntrega($conn, $protCompra){
    //insert entrega
    if(isset($protCompra)){
        $result = $conn->query("SELECT * FROM entrega WHERE idPedido = '$protCompra'");
        if($result->num_rows == 0){
            $status = 'enviado';
            $dataPrevisao = date('Y-m-d', strtotime('+20 days'));
            $stmt = $conn->prepare("INSERT INTO entrega (status, dataPrevisao, idPedido) VALUES (?,?,?)");
            $stmt->bind_param("sss", $status, $dataPrevisao, $protCompra);
            $stmt->execute();

            $retorno = array('status' => 'ok', 'mensagem' => "Produto enviado.");
            http_response_code(200);
            echo json_encode($retorno);
        }else{
            $retorno = array('status' => 'sent', 'mensagem' => "Este pedido já foi enviado.");
             http_response_code(200);
            echo json_encode($retorno);
        }
    } else {
        $retorno = array('status' => 'erro', 'mensagem' => 'Protocolo não encontrado.');
        http_response_code(400);
        echo json_encode($retorno);
    }
}

enviarEntrega($conn, $protCompra);