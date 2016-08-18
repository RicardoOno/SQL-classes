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
	idModelo INT PRIMARY KEY NOT NULL IDENTITY(1,1),
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

CREATE TABLE historico (
	idHistorico INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	dtCadastro DATE,
	idResponsavel INT NOT NULL,
	idVeiculo INT NOT NULL)
GO

 /* Comentario */

Alter table Veiculos 
	Add Constraint FK_Veiculos_idCategorias Foreign Key (idCategoria)
	References Categoria(idCategoria)
Go

Alter table Veiculos 
	Add Constraint FK_Veiculos_idModelo Foreign Key (idModelo)
	References Modelo(idModelo)
Go

Alter table Veiculos 
	Add Constraint FK_Veiculos_idMarca Foreign Key (idMarca)
	References Marca(idMarca)
Go

Alter table Veiculos 
	Add Constraint FK_Veiculos_idAnoFabricacao Foreign Key (idAnoFabricacao)
	References anoFabricacao(idAnoFabricacao)
Go

Alter table Modelo 
	Add Constraint FK_Modelos_idMarca Foreign Key (idMarca)
	References Marca(idMarca)
Go

Alter table Responsavel 
	Add Constraint FK_Responsavel_idEndereco Foreign Key (idEndereco)
	References Endereco(idEndereco)
Go

Alter table Responsavel 
	Add Constraint FK_Responsavel_idVeiculo Foreign Key (idVeiculo)
	References Veiculos(idVeiculo)
Go	

Alter table Historico
	Add Constraint FK_Historico_idResponsavel Foreign Key (idResponsavel)
	References Responsavel(idResponsavel)
GO

Alter table Historico
	Add Constraint FK_Historico_idVeiculo Foreign Key (idVeiculo)
	References Veiculos(idVeiculo)
GO