<?php
$responsavel = 'fabricadecampeoestcc@gmail.com';
$senhaApp = 'rbwt qqkz hqfb xeyr';

// Dados do formulário
$data = json_decode(file_get_contents('php://input'), true);
$protocolo = $data['data'] ?? "NO_PROTOCOL";

session_start();
$globalUsuario = $_SESSION['usuario'];

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

require '../vendor/autoload.php';

//Create an instance; passing `true` enables exceptions
$mail = new PHPMailer(true);


$email = $globalUsuario['email'];
$nomeUser = $globalUsuario['nome'];

try {
    $mail->SMTPDebug = SMTP::DEBUG_SERVER;                      //Enable verbose debug output
    $mail->isSMTP();                                            //Send using SMTP
    $mail->Host       = 'smtp.gmail.com';
    $mail->SMTPAuth   = true;                                   //Enable SMTP authentication
    $mail->Username   = $responsavel;                           // Seu e-mail
    $mail->Password   = $senhaApp;                              // Senha de aplicativo (gerada pelo Google)
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;            //Enable implicit TLS encryption
    $mail->Port       = 465; //ou 587

    //Recipients
    $mail->setFrom($responsavel, 'Mailer'); //email de envio 
    if (isset($email)) {
        $mail->addAddress($email, 'Cliente');
    } else {
        $mail->addReplyTo($responsavel, 'Email erro envio - ' . $protocolo);   //Email de resposta 
    }

    //Content
    $mail->isHTML(true);                                    //Set email format to HTML
    $mail->Subject = 'Protocolo de compra - Fabrica de Campeões';                 //Assunto
    $mail->Body    = 'Obrigado por comprar conosco, seu protocolo de compra é: <b>' . $protocolo . '</b>';
    $mail->AltBody = 'Protocolo de compra com Fabrica de Campeões';

    // Envia o e-mail
    $mail->send();

    echo 'Message has been sent';
} catch (Exception $e) {
    echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
}
