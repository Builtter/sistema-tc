-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Tempo de geração: 22/06/2025 às 19:40
-- Versão do servidor: 9.1.0
-- Versão do PHP: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `fabrica_db`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `adm`
--

DROP TABLE IF EXISTS `adm`;
CREATE TABLE IF NOT EXISTS `adm` (
  `idAdmin` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `senha` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefone` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`idAdmin`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Despejando dados para a tabela `adm`
--

INSERT INTO `adm` (`idAdmin`, `nome`, `email`, `senha`, `telefone`) VALUES
(6, 'master', 'fabricadecampeoestcc@gmail.com', '6797f82f504379e72c59879b12594d39', '62911112222');

-- --------------------------------------------------------

--
-- Estrutura para tabela `categoria`
--

DROP TABLE IF EXISTS `categoria`;
CREATE TABLE IF NOT EXISTS `categoria` (
  `idCategoria` int NOT NULL AUTO_INCREMENT,
  `tipo` varchar(50) DEFAULT NULL,
  `dimensoes` varchar(100) DEFAULT NULL,
  `produto_idProduto` int NOT NULL,
  PRIMARY KEY (`idCategoria`),
  KEY `fk_categoria_produto1_idx` (`produto_idProduto`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `cidade`
--

DROP TABLE IF EXISTS `cidade`;
CREATE TABLE IF NOT EXISTS `cidade` (
  `idCidade` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) DEFAULT NULL,
  `idEstado` int DEFAULT NULL,
  `endereco_idEndereco` int NOT NULL,
  PRIMARY KEY (`idCidade`,`endereco_idEndereco`),
  KEY `idEstado` (`idEstado`),
  KEY `fk_cidade_endereco1_idx` (`endereco_idEndereco`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Despejando dados para a tabela `cidade`
--

INSERT INTO `cidade` (`idCidade`, `descricao`, `idEstado`, `endereco_idEndereco`) VALUES
(5, 'Capital', 11, 0),
(6, 'Capital', 12, 0),
(7, 'Capital', 14, 0),
(8, 'Capital', 15, 0),
(9, 'Capital', 17, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `cliente`
--

DROP TABLE IF EXISTS `cliente`;
CREATE TABLE IF NOT EXISTS `cliente` (
  `idCliente` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) DEFAULT NULL,
  `cpfCnpj` varchar(20) DEFAULT NULL,
  `dataNasc` date DEFAULT NULL,
  `senha` varchar(100) NOT NULL,
  PRIMARY KEY (`idCliente`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

--
-- Despejando dados para a tabela `cliente`
--

INSERT INTO `cliente` (`idCliente`, `nome`, `cpfCnpj`, `dataNasc`, `senha`) VALUES
(14, 'Teste', '77788899944', '2025-05-01', 'd54d1702ad0f8326224b817c796763c9'),
(15, 'ademirzinho', '0112578964', '2025-05-30', 'e10adc3949ba59abbe56e057f20f883e'),
(16, 'saul', '0123456789', '2024-02-01', '81dc9bdb52d04dc20036dbd8313ed055'),
(17, 'usuario', '77788899944', '2025-05-08', '827ccb0eea8a706c4c34a16891f84e7b'),
(18, 'Rogers', '77788899944', '2025-05-07', '827ccb0eea8a706c4c34a16891f84e7b'),
(19, 'Default', '77788899944', '2025-05-03', '3dba52fcf7afd1d73a04c9ea70de6416');

-- --------------------------------------------------------

--
-- Estrutura para tabela `email`
--

DROP TABLE IF EXISTS `email`;
CREATE TABLE IF NOT EXISTS `email` (
  `idEmail` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) DEFAULT NULL,
  `idCliente` int DEFAULT NULL,
  `cliente_idCliente` int NOT NULL,
  PRIMARY KEY (`idEmail`),
  KEY `idCliente` (`idCliente`),
  KEY `fk_email_cliente1_idx` (`cliente_idCliente`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

--
-- Despejando dados para a tabela `email`
--

INSERT INTO `email` (`idEmail`, `email`, `idCliente`, `cliente_idCliente`) VALUES
(11, 'teste@teste.com', 21, 0),
(12, 'juninho@gmail', 22, 0),
(13, 'saulmateusinho@gmail.com', 23, 0),
(14, 'teste@teste.com', 24, 0),
(15, 'userdefault@gmail.com', 25, 0),
(16, 'fabricadecampeoestcc@gmail.com', 26, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `endereco`
--

DROP TABLE IF EXISTS `endereco`;
CREATE TABLE IF NOT EXISTS `endereco` (
  `idEndereco` int NOT NULL AUTO_INCREMENT,
  `logradouro` varchar(100) DEFAULT NULL,
  `complemento` varchar(50) DEFAULT NULL,
  `idCliente` int DEFAULT NULL,
  `idCidade` int DEFAULT NULL,
  `cliente_idCliente` int NOT NULL,
  PRIMARY KEY (`idEndereco`),
  KEY `idCliente` (`idCliente`),
  KEY `idCidade` (`idCidade`),
  KEY `fk_endereco_cliente_idx` (`cliente_idCliente`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

--
-- Despejando dados para a tabela `endereco`
--

INSERT INTO `endereco` (`idEndereco`, `logradouro`, `complemento`, `idCliente`, `idCidade`, `cliente_idCliente`) VALUES
(11, 'go', '', 21, 1, 0),
(12, 'go', '', 22, 1, 0),
(13, NULL, '', 23, 1, 0),
(14, 'R340', '', 24, 1, 0),
(15, 'R340', '', 25, 1, 0),
(16, 'R340', '', 26, 1, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `entrega`
--

DROP TABLE IF EXISTS `entrega`;
CREATE TABLE IF NOT EXISTS `entrega` (
  `idEntrega` varchar(200) NOT NULL,
  `status` varchar(50) DEFAULT NULL,
  `dataPrevisao` date DEFAULT NULL,
  `idPedido` varchar(200) NOT NULL,
  `idEndereco` int NOT NULL,
  PRIMARY KEY (`idEntrega`),
  KEY `fk_entrega_pedido1_idx` (`idPedido`),
  KEY `fk_entrega_endereco1_idx` (`idEndereco`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Despejando dados para a tabela `entrega`
--

INSERT INTO `entrega` (`idEntrega`, `status`, `dataPrevisao`, `idPedido`, `idEndereco`) VALUES
('33', 'enviado', '2025-06-23', '2025-05-26#6835111b3373f', 0),
('34', 'enviado', '2025-06-23', '2025-05-26#6835111b3373f', 0),
('35', 'enviado', '2025-06-23', '2025-05-29#6838ee1093ae3', 0),
('36', 'enviado', '2025-06-23', '2025-05-30#68392e4f4a345', 0),
('37', 'enviado', '2025-06-23', '2025-05-29#6838e962c840a', 0),
('38', 'enviado', '2025-06-27', '2025-05-29#6838e67fda04d', 0),
('39', 'enviado', '2025-06-27', '2025-06-07#68445f6ab0605', 0),
('40', 'enviado', '2025-07-05', '2025-05-29#6838ec3493981', 0),
('41', 'enviado', '2025-07-05', '2025-06-15#684f5bfc6d417', 0),
('42', 'enviado', '2025-07-07', '2025-05-29#6838e9c96a890', 0),
('43', 'enviado', '2025-07-09', '2025-06-17#6850eec3dae93', 0),
('44', 'enviado', '2025-07-09', '2025-06-16#6850cc2c4bed3', 0),
('45', 'enviado', '2025-07-09', '2025-05-29#6838ed0e6fa82', 0),
('46', 'enviado', '2025-07-09', '2025-05-29#6838eecbb9221', 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `estado`
--

DROP TABLE IF EXISTS `estado`;
CREATE TABLE IF NOT EXISTS `estado` (
  `idEstado` int NOT NULL AUTO_INCREMENT,
  `UF` char(2) DEFAULT NULL,
  `descricao` varchar(100) DEFAULT NULL,
  `cidade_idCidade` int NOT NULL,
  `cidade_endereco_idEndereco` int NOT NULL,
  PRIMARY KEY (`idEstado`,`cidade_idCidade`,`cidade_endereco_idEndereco`),
  KEY `fk_estado_cidade1_idx` (`cidade_idCidade`,`cidade_endereco_idEndereco`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

--
-- Despejando dados para a tabela `estado`
--

INSERT INTO `estado` (`idEstado`, `UF`, `descricao`, `cidade_idCidade`, `cidade_endereco_idEndereco`) VALUES
(5, 'AL', 'AL', 0, 0),
(6, 'SP', 'SP', 0, 0),
(7, 'SP', 'SP', 0, 0),
(8, 'RJ', 'RJ', 0, 0),
(9, 'PA', 'PA', 0, 0),
(10, 'PA', 'PA', 0, 0),
(11, 'PR', 'PR', 0, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `estoque`
--

DROP TABLE IF EXISTS `estoque`;
CREATE TABLE IF NOT EXISTS `estoque` (
  `idEstoque` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) DEFAULT NULL,
  `idAdmin` int NOT NULL,
  `quantidade` decimal(10,0) NOT NULL,
  `idProduto` int NOT NULL,
  PRIMARY KEY (`idEstoque`),
  KEY `fk_estoque_adm1_idx` (`idAdmin`),
  KEY `fk_estoque_produto1_idx` (`idProduto`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

--
-- Despejando dados para a tabela `estoque`
--

INSERT INTO `estoque` (`idEstoque`, `descricao`, `idAdmin`, `quantidade`, `idProduto`) VALUES
(1, '123', 0, 0, 0),
(2, '112', 0, 0, 0),
(3, '123123', 0, 0, 0),
(4, 'aa', 0, 0, 0),
(5, '1111', 0, 0, 0),
(6, 'Des', 0, 0, 0),
(7, '123123', 0, 0, 0),
(8, '111', 0, 0, 0),
(9, '111', 0, 0, 0),
(10, '123', 0, 0, 0),
(11, '12123', 0, 0, 0),
(12, '111', 0, 0, 0),
(13, '123', 0, 0, 0),
(14, '123', 0, 0, 0),
(15, '123', 0, 0, 0),
(16, '123', 0, 0, 0),
(17, '123', 0, 0, 0),
(18, '123', 0, 0, 0),
(19, '123', 0, 0, 0),
(20, '123', 0, 0, 0),
(21, '123', 0, 0, 0),
(22, 'Auto Colante', 0, 0, 0),
(23, 'Caneta Tinteiro Cor Azul', 0, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `pedido`
--

DROP TABLE IF EXISTS `pedido`;
CREATE TABLE IF NOT EXISTS `pedido` (
  `idPedido` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(200) DEFAULT NULL,
  `quantidade` int DEFAULT NULL,
  `idEstoque` int DEFAULT NULL,
  `idCliente` int NOT NULL,
  `dtPedido` varchar(45) DEFAULT NULL,
  `vlCompra` decimal(11,2) DEFAULT NULL,
  `avaliaCompra` int DEFAULT NULL,
  `protCompra` varchar(200) DEFAULT NULL,
  `tipoPagamento` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`idPedido`),
  KEY `idEstoque` (`idEstoque`),
  KEY `fk_pedido_cliente1_idx` (`idCliente`)
) ENGINE=MyISAM AUTO_INCREMENT=162 DEFAULT CHARSET=latin1;

--
-- Despejando dados para a tabela `pedido`
--

INSERT INTO `pedido` (`idPedido`, `descricao`, `quantidade`, `idEstoque`, `idCliente`, `dtPedido`, `vlCompra`, `avaliaCompra`, `protCompra`, `tipoPagamento`) VALUES
(161, 'Etiqueta Adesiva Térmica', 1, 1, 26, '2025-06-15 20:08:36', 8.90, 5, '2025-06-15#684f5274c3284', 'cartao'),
(160, 'Etiqueta BOPP Transparente', 1, 3, 26, '2025-06-07 12:53:08', 20.90, 1, '2025-06-07#6844606413a36', 'pix'),
(159, 'Etiqueta Papel Couchê', 10, 2, 26, '2025-06-07 12:48:58', 199.00, 5, '2025-06-07#68445f6ab0605', 'debito'),
(73, 'convite para eventos', 1, 9, 24, '2025-05-26 21:37:32', 19.99, 1, '2025-05-26#6835094c12df1', 'debito'),
(74, 'banner', 1, 5, 24, '2025-05-15 21:43:06', 59.99, 4, '2025-05-26#68350a9abb060', 'pix'),
(75, 'logo time', 1, 6, 24, '2025-05-26 21:44:04', 80.99, 5, '2025-05-26#68350ad4881aa', 'debito'),
(76, 'Etiqueta Adesiva Térmica', 1, 1, 24, '2025-05-26 21:48:14', 8.90, 2, '2025-05-26#68350bce637e2', 'pix'),
(77, 'banner', 1, 5, 24, '2025-05-15 21:48:52', 59.99, 5, '2025-05-26#68350bf40e527', 'pix'),
(78, 'Etiqueta Adesiva Térmica', 1, 1, 24, '2025-05-26 21:49:17', 8.90, 5, '2025-05-26#68350c0d0e23a', 'cartao'),
(79, 'Etiqueta Papel Couchê', 1, 2, 24, '2025-05-26 21:49:17', 19.90, 5, '2025-05-26#68350c0d0e23a', 'debito'),
(80, 'Etiqueta Adesiva Térmica', 1, 1, 25, '2025-05-26 21:51:08', 8.90, 5, '2025-05-26#68350c7cef16f', 'pix'),
(81, 'Etiqueta Papel Couchê', 2, 2, 25, '2025-05-26 21:51:08', 39.80, 5, '2025-05-26#68350c7cef16f', 'debito'),
(82, 'Etiqueta Adesiva Térmica', 1, 1, 25, '2025-05-26 21:52:02', 8.90, 5, '2025-05-26#68350cb2cacd3', 'cartao'),
(83, 'Etiqueta Papel Couchê', 2, 2, 25, '2025-05-26 21:52:02', 39.80, 5, '2025-05-26#68350cb2cacd3', 'pix'),
(84, 'convite para eventos', 1, 9, 25, '2025-05-16 21:52:02', 19.99, 5, '2025-05-26#68350cb2cacd3', 'debito'),
(85, 'Etiqueta Adesiva Térmica', 1, 1, 25, '2025-05-26 21:53:19', 8.90, 5, '2025-05-26#68350cff71d27', 'debito'),
(86, 'Etiqueta Papel Couchê', 2, 2, 25, '2025-05-26 21:53:19', 39.80, 5, '2025-05-26#68350cff71d27', 'pix'),
(87, 'convite para eventos', 1, 9, 25, '2025-05-26 21:53:19', 19.99, 5, '2025-05-26#68350cff71d27', 'debito'),
(88, 'Etiqueta Adesiva Térmica', 1, 1, 25, '2025-05-26 21:56:51', 8.90, 4, '2025-05-26#68350dd3c496b', 'cartao'),
(89, 'Etiqueta Adesiva Térmica', 1, 1, 25, '2025-05-26 22:07:49', 8.90, 5, '2025-05-26#683510654fc49', 'pix'),
(90, 'Etiqueta Adesiva Térmica', 1, 1, 25, '2025-05-26 22:08:26', 8.90, 5, '2025-05-26#6835108a5edde', 'debito'),
(91, 'Etiqueta Adesiva Térmica', 1, 1, 25, '2025-05-26 22:10:51', 8.90, 3, '2025-05-26#6835111b3373f', 'pix'),
(92, 'Etiqueta Papel Couchê', 1, 2, 25, '2025-05-30 22:10:51', 19.90, 3, '2025-05-26#6835111b3373f', 'debito'),
(93, 'banner', 1, 5, 25, '2025-05-26 22:14:49', 59.99, 5, '2025-05-26#6835120967738', 'cartao'),
(94, 'Etiqueta Papel Couchê', 1, 2, 25, '2025-05-26 22:36:35', 19.90, 5, '2025-05-26#6835172351400', 'cartao');

-- --------------------------------------------------------

--
-- Estrutura para tabela `pedido_produto`
--

DROP TABLE IF EXISTS `pedido_produto`;
CREATE TABLE IF NOT EXISTS `pedido_produto` (
  `idPedido` int NOT NULL,
  `idProduto` int NOT NULL,
  `qtd` decimal(10,0) DEFAULT NULL,
  `idEstoque` int NOT NULL,
  PRIMARY KEY (`idPedido`,`idProduto`),
  KEY `fk_pedido_has_produto_produto1_idx` (`idProduto`),
  KEY `fk_pedido_has_produto_pedido1_idx` (`idPedido`),
  KEY `fk_pedido_produto_estoque1_idx` (`idEstoque`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `produto`
--

DROP TABLE IF EXISTS `produto`;
CREATE TABLE IF NOT EXISTS `produto` (
  `idProduto` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) DEFAULT NULL,
  `descricao` varchar(200) DEFAULT NULL,
  `preco` decimal(10,2) DEFAULT NULL,
  `imagem` varchar(255) DEFAULT NULL,
  `idCategoria` int DEFAULT NULL,
  `quantidade` int DEFAULT NULL,
  PRIMARY KEY (`idProduto`),
  KEY `idCategoria` (`idCategoria`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

--
-- Despejando dados para a tabela `produto`
--

INSERT INTO `produto` (`idProduto`, `nome`, `descricao`, `preco`, `imagem`, `idCategoria`, `quantidade`) VALUES
(6, 'Etiqueta Adesiva Térmica', 'Etiqueta', 8.00, NULL, NULL, 1420),
(7, 'Etiqueta Papel Couchê', 'Etiqueta', 19.00, NULL, NULL, 1283),
(8, 'Etiqueta BOPP Transparente', 'Etiqueta', 20.00, NULL, NULL, 1973),
(9, 'cartão visita', 'Cartão', 11.00, NULL, NULL, 2901),
(10, 'banner', 'banner', 59.00, NULL, NULL, 4946),
(11, 'logo em geral', 'Logo', 80.99, NULL, NULL, 2937),
(12, 'cartão aniverssario', 'Cartão', 10.90, NULL, NULL, 500),
(13, 'embalagem', 'embalagem', 37.90, NULL, NULL, 9),
(14, 'convites para eventos', 'Convite', 19.99, NULL, NULL, 9);

-- --------------------------------------------------------

--
-- Estrutura para tabela `telefone`
--

DROP TABLE IF EXISTS `telefone`;
CREATE TABLE IF NOT EXISTS `telefone` (
  `idTelefone` int NOT NULL AUTO_INCREMENT,
  `numero` varchar(15) DEFAULT NULL,
  `idCliente` int DEFAULT NULL,
  `cliente_idCliente` int NOT NULL,
  PRIMARY KEY (`idTelefone`),
  KEY `idCliente` (`idCliente`),
  KEY `fk_telefone_cliente1_idx` (`cliente_idCliente`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Despejando dados para a tabela `telefone`
--

INSERT INTO `telefone` (`idTelefone`, `numero`, `idCliente`, `cliente_idCliente`) VALUES
(10, '99911112222', 21, 0),
(11, '123456789', 22, 0),
(12, '123456789', 23, 0),
(13, '99911112222', 24, 0),
(14, '99911112222', 25, 0),
(15, '99911112222', 26, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuario`
--

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `idUsuario` int NOT NULL AUTO_INCREMENT,
  `idCliente` int DEFAULT NULL,
  `senha` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cliente_idCliente` int NOT NULL,
  PRIMARY KEY (`idUsuario`),
  KEY `idCliente` (`idCliente`),
  KEY `fk_usuario_cliente1_idx` (`cliente_idCliente`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Despejando dados para a tabela `usuario`
--

INSERT INTO `usuario` (`idUsuario`, `idCliente`, `senha`, `cliente_idCliente`) VALUES
(1, 21, 'd54d1702ad0f8326224b817c796763c9', 0),
(2, 22, 'e10adc3949ba59abbe56e057f20f883e', 0),
(3, 23, '81dc9bdb52d04dc20036dbd8313ed055', 0),
(4, 24, '827ccb0eea8a706c4c34a16891f84e7b', 0),
(5, 25, '827ccb0eea8a706c4c34a16891f84e7b', 0),
(6, 26, '827ccb0eea8a706c4c34a16891f84e7b', 0);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
