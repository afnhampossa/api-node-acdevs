-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 11-Maio-2022 às 20:30
-- Versão do servidor: 10.4.24-MariaDB
-- versão do PHP: 7.4.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `emprestimo`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `agencia`
--

CREATE TABLE `agencia` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `endereco` varchar(100) DEFAULT NULL,
  `contacto` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `sexo_id` int(100) DEFAULT NULL,
  `endereco` varchar(100) DEFAULT NULL,
  `estado_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `clientes`
--

INSERT INTO `clientes` (`id`, `nome`, `sexo_id`, `endereco`, `estado_id`, `created_at`, `updated_at`) VALUES
(1, 'Angelino Fernando', 1, 'Maputo Cidade', 1, '2022-05-05 18:27:30', '2022-05-05 18:27:30'),
(3, 'Aires', 1, 'Zambezia', 1, '2022-05-10 18:43:20', '2022-05-10 18:43:20');

--
-- Acionadores `clientes`
--
DELIMITER $$
CREATE TRIGGER `tgr_criar_conta` AFTER INSERT ON `clientes` FOR EACH ROW BEGIN

INSERT INTO conta (conta.cliente_id,conta.saldo) VALUES (NEW.id,0);

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `conta`
--

CREATE TABLE `conta` (
  `id` int(11) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `saldo` double(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `conta`
--

INSERT INTO `conta` (`id`, `cliente_id`, `saldo`, `created_at`, `updated_at`) VALUES
(2, 1, 160.00, '2022-05-05 18:27:30', '2022-05-05 18:38:06'),
(4, 3, 0.00, '2022-05-10 18:43:20', '2022-05-10 18:43:20');

-- --------------------------------------------------------

--
-- Estrutura da tabela `deposito_emprestimo`
--

CREATE TABLE `deposito_emprestimo` (
  `id` int(11) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `valor` double(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `deposito_emprestimo`
--

INSERT INTO `deposito_emprestimo` (`id`, `cliente_id`, `valor`, `created_at`, `updated_at`) VALUES
(2, 1, 100.00, '2022-05-05 18:37:17', '2022-05-05 18:37:17'),
(3, 1, 10.00, '2022-05-05 18:37:43', '2022-05-05 18:37:43'),
(4, 1, 50.00, '2022-05-05 18:38:06', '2022-05-05 18:38:06');

--
-- Acionadores `deposito_emprestimo`
--
DELIMITER $$
CREATE TRIGGER `tgr_inserir_emprestimo` AFTER INSERT ON `deposito_emprestimo` FOR EACH ROW BEGIN

UPDATE conta SET conta.saldo = conta.saldo + NEW.valor WHERE conta.cliente_id = NEW.cliente_id;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `estado`
--

CREATE TABLE `estado` (
  `id` int(11) NOT NULL,
  `descricao` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `estado`
--

INSERT INTO `estado` (`id`, `descricao`) VALUES
(1, 'Ativo'),
(2, 'Inativo');

-- --------------------------------------------------------

--
-- Estrutura da tabela `sexo`
--

CREATE TABLE `sexo` (
  `id` int(11) NOT NULL,
  `discricao` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `sexo`
--

INSERT INTO `sexo` (`id`, `discricao`) VALUES
(1, 'Masculino'),
(2, 'Feminino');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `agencia`
--
ALTER TABLE `agencia`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_sexo_id` (`sexo_id`),
  ADD KEY `fk_estado` (`estado_id`);

--
-- Índices para tabela `conta`
--
ALTER TABLE `conta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_cliente_conta` (`cliente_id`);

--
-- Índices para tabela `deposito_emprestimo`
--
ALTER TABLE `deposito_emprestimo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_cliente_deposito` (`cliente_id`);

--
-- Índices para tabela `estado`
--
ALTER TABLE `estado`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `sexo`
--
ALTER TABLE `sexo`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `agencia`
--
ALTER TABLE `agencia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `conta`
--
ALTER TABLE `conta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `deposito_emprestimo`
--
ALTER TABLE `deposito_emprestimo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `estado`
--
ALTER TABLE `estado`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `sexo`
--
ALTER TABLE `sexo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `fk_estado` FOREIGN KEY (`estado_id`) REFERENCES `estado` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_sexo_id` FOREIGN KEY (`sexo_id`) REFERENCES `sexo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `conta`
--
ALTER TABLE `conta`
  ADD CONSTRAINT `fk_cliente_conta` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `deposito_emprestimo`
--
ALTER TABLE `deposito_emprestimo`
  ADD CONSTRAINT `fk_cliente_deposito` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
