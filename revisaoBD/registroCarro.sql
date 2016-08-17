CREATE DATABASE registro_carros
GO

USE registro_carros
GO

CREATE TABLE veiculos (
	idVeiculo INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	placa VARCHAR(7) UNIQUE NOT NULL,
	cor VARCHAR(20),
	idCategoria INT NOT NULL,
	idModelo INT NOT NULL,
	idMarca INT NOT NULL,
	idAnoFabricacao INT NOT NULL
)
GO

CREATE TABLE endereco (
	idEndereco INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	rua VARCHAR (150) NOT NULL,
	numero INT NOT NULL,
	cep BIGINT NOT NULL,
	cidade VARCHAR (80) NOT NULL,
	estado CHAR(2)
)
GO

CREATE TABLE categoria (
	idCategoria INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	nomeCategoria VARCHAR (80)
)
GO

CREATE TABLE modelo (
	idResponsavel INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	descricao VARCHAR (150),
	idMarca INT NOT NULL
)

CREATE TABLE responsavel(
	idResponsavel INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	nome VARCHAR (180) NOT NULL,
	dataNascimento DATE,
	sexo CHAR(1) NOT NULL,
	CNH BIGINT NOT NULL,
	telefone BIGINT,
	rg BIGINT NOT NULL,
	cpf BIGINT NOT NULL,
	idEndereco INT NOT NULL,
	idVeiculo INT NOT NULL
)

GO

CREATE TABLE marca (
	idMarca INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	nomeDescricao VARCHAR(100) NOT NULL
)
GO

CREATE TABLE anoFabricacao (
	idAnoFabricacao INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	ano DATE
)
GO

 /* Comentario */