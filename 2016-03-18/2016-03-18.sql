CREATE DATABASE aula
GO

USE aula
GO

CREATE TABLE funcionarios (
	codigo INT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(80) NOT NULL,
	sexo CHAR(1) CHECK (sexo = 'F' OR sexo = 'M'),
	RG INT NOT NULL UNIQUE NONCLUSTERED,
	CPF INT NOT NULL UNIQUE NONCLUSTERED,
	dataNascimento DATE CHECK (dataNascimento >= '1950-01-01'),
	dataCadastro DATETIME DEFAULT GETDATE(),
	email VARCHAR(100) NULL
	)

GO

CREATE TABLE clientes(
	codigo INT IDENTITY(1,1),
	nome VARCHAR(80),
	sexo CHAR(1),
	RG INT NOT NULL,
	CPF INT NOT NULL,
	dataNascimento DATE,
	dataCadastro DATETIME CONSTRAINT DF_clientes_dataCadastro DEFAULT GETDATE(),
	email VARCHAR(100) NULL
	CONSTRAINT PK_clientes_codigo PRIMARY KEY(codigo),
	CONSTRAINT CK_clientes_sexo CHECK(sexo='F' OR sexo='M'),
	CONSTRAINT UQ_clientes_RG UNIQUE NONCLUSTERED(RG),
	CONSTRAINT UQ_clientes_CPF UNIQUE NONCLUSTERED(CPF),
	CONSTRAINT CK_clientes_dataNascimento CHECK (dataNascimento >= '1950-01-01')
)
GO

ALTER TABLE clientes
ADD CONSTRAINT DF_clientes_sexo DEFAULT 'M' FOR sexo

ALTER TABLE clientes
DROP CONSTRAINT CK_clientes_dataNascimento
GO

ALTER TABLE clientes
ADD CONSTRAINT CK_clientes_dataNascimento
CHECK(dataNascimento >= '1900-01-01')
GO

--  REMOVE TABLE
DROP TABLE clientes

-- ALTERAR TABLE FUNCIOÑÁRIOS E A COLUNA EMAIL
ALTER TABLE funcionarios
ALTER COLUMN email VARCHAR(100) NOT NULL
GO

-- ALTERAR A TABLE FUNCIONARIOS E REMOVER A COLUNA EMAIL
ALTER TABLE funcionarios
DROP COLUMN email
GO

-- INSERINDO DADOS NA TABLEA FUNCIONARIOS
INSERT INTO funcionarios(nome, sexo, RG, CPF, dataNascimento)
VALUES('Matheus', 'M', 500782345, 43543281, '1997-10-06')
GO

--TENTANDO INSERIR DATA MENOR QUE 1950
INSERT INTO funcionarios(nome, sexo, RG, CPF, dataNascimento)
VALUES('Matheus', 'M', 512782345, 44643281, '1949-10-06')
GO

-- ATUALIZAR O VALOR DA COLUNA SEXO
UPDATE funcionarios
SET sexo = 'M'
GO

-- INSERINDO DADOS NA TABLEA FUNCIONARIOS
INSERT INTO funcionarios(nome, sexo, RG, CPF, dataNascimento)
VALUES('Matheus II', 'M', 12132, 2131231, '1997-10-16')
GO

INSERT INTO funcionarios(nome, sexo, RG, CPF, dataNascimento)
VALUES('Carlos', 'M', 231123, 4354281, '1955-10-06')
GO

-- ATUALIZAR O VALOR DA COLUNA SEXO
UPDATE funcionarios
SET nome = 'Chico Dito'
WHERE codigo = '4'
GO

SELECT codigo, nome, sexo, RG, CPF, dataNascimento, dataCadastro
FROM funcionarios
GO

SELECT codigo, nome, sexo, RG, CPF, dataNascimento, dataCadastro
FROM funcionarios
WHERE codigo >= 2
GO

SELECT codigo, nome, sexo, RG, CPF, dataNascimento, dataCadastro
FROM funcionarios
WHERE codigo = 2 OR codigo = 4
GO

SELECT codigo, nome, sexo, RG, CPF, dataNascimento, dataCadastro
FROM funcionarios
WHERE codigo IN (2,4)
GO