-- CRIA BANCO
CREATE DATABASE FatecBD1
GO

-- USAR BANCO
USE FatecBD1
GO

-- CRIANDO A TABELA DE FORNECEDORESUTILIZANDO CONSTRAINTS - NOT NULL, NULL, CHECK, DEFAULT....]
CREATE TABLE Fornecedores (
	Codigo INT PRIMARY KEY IDENTITY(1,1),
	RazaoSocial VARCHAR(80),
	Apelido VARCHAR(30),
	CNPJ BIGINT NOT NULL UNIQUE NONCLUSTERED,
	CPF BIGINT NOT NULL UNIQUE NONCLUSTERED,
	DataCadastro DATETIME DEFAULT GETDATE(),
	Email VARCHAR(100) NOT NULL
)
GO

-- CRIANDO A TABELA PRODUTOS UTILIZANDO CONSTRAINTS
CREATE TABLE Produtos (
	Codigo INT IDENTITY(1,1),
	Descricao VARCHAR(80) NOT NULL,
	DataCadastro DATETIME CONSTRAINT DF_Produtos_DataCadastro DEFAULT GETDATE(),
	Quantidade SMALLINT NOT NULL DEFAULT(0),
	ValorUnitario FLOAT NOT NULL
	 CONSTRAINT PK_Produtos_Codigo PRIMARY KEY (Codigo),
	 CONSTRAINT CK_Produtos_ValorUnitario CHECK (ValorUnitario >= 0)
)
GO

-- INSERINDO DADOS NA TABELA FORNECEDORES
INSERT INTO Fornecedores (RazaoSocial, Apelido, CNPJ, CPF, DataCadastro, Email)
VALUES ('Fornecedor A',
		'F A',
		12345678,
		12341234,
		'2016-09-12',
		'fa@fa.com')
GO

INSERT INTO Fornecedores (RazaoSocial, Apelido, CNPJ, CPF, Email)
VALUES ('Fornecedor B',
		'F B',
		09876543,
		34567890,
		'fb@fb.com')
GO

INSERT INTO Fornecedores ( RazaoSocial, CNPJ, CPF, DataCadastro, Email )
VALUES ('Fornecedor C',
		1234569,
		9836372,
		'2015-01-01',
		'fc@fc.com')
GO

-- CONSULTANDO OS DADOS DA TABELA FORNECEDORES
SELECT Codigo,
		RazaoSocial,
		Apelido,
		CNPJ,
		CPF,
		DataCadastro,
		Email
FROM Fornecedores
GO

-- CONSULTA MAIS ESPECÍFICA
SELECT Codigo,
		-- AS É USADO PARA, DURANTE A EXEC~UÇÃO, EXIBIR UM ROTULO
		RazaoSocial AS 'Razão Social',
		Apelido AS 'Apelido do Fornecedor',
		-- CONVERT PRIMEIRO O TIPO DEPOIS O CAMPO
		CONVERT(CHAR(14), CNPJ) + ' - ' + CONVERT(CHAR(14), CPF) AS 'Documentos 1',
		-- CAST PRIMEIRO O CAMPO DEPOIS O TIPO
		CAST(CPF AS CHAR(14)) + ' - ' + CAST(CNPJ AS CHAR(14)) AS 'Documentos 2',
		DataCadastro 'Data',
		Email
FROM Fornecedores
GO

-- OUTRA CONSULTA
SELECT	Codigo,
		RazaoSocial AS 'Razão Social',
		Apelido AS 'Apelido do Fornecedor',
		-- CONCATENA E NAO PRECISA DECLARAR TIPO
		CONCAT(CNPJ, ' - ', CPF) AS 'Documentos',
		DataCadastro 'Data',
		Email
FROM Fornecedores
ORDER BY Documentos

GO

-- ALTERANDO A TABELA PRODUTOS
ALTER TABLE Produtos
	ADD CodFornecedor INT NOT NULL
GO

-- INSERINDO DADOS NA TABELA DE PRODUTOS
INSERT INTO Produtos ( Descricao, Quantidade, ValorUnitario, CodFornecedor )
VALUES ('Arroz', 10, 12.50, 1)
GO

INSERT INTO Produtos ( Descricao, Quantidade, ValorUnitario, CodFornecedor )
VALUES ( 'Feijão', 123, 5.90, 2)
GO

SELECT * FROM Produtos
GO

-- CRIANDO TABELA DE ESTOQUE
CREATE TABLE Estoques (
	Codigo INT IDENTITY(1,1) PRIMARY KEY,
	CodProduto INT NOT NULL
)
GO

-- ALTERANDO TABELA DE ESTOQUES ADICIONANDO CHAVE ESTRANGEIRA
ALTER TABLE Estoques
ADD CONSTRAINT FK_Estoque_Produtos FOREIGN KEY (CodProduto)
REFERENCES Produtos(Codigo)
GO

-- INSERINDO UM NOVO PRODUTO
INSERT INTO Produtos (Descricao, Quantidade, ValorUnitario, CodFornecedor)
VALUES ('Chocolate', 999, 14.23, 2)
GO

-- INSERINDO DADOS NA TABLEA ESTOQUE
INSERT INTO Estoques (CodProduto)
VALUES (1),(2),(3)
GO




--  SEGUNDA AULA --
CREATE TABLE Pessoas (
	Codigo INT IDENTITY(1,1),
	Nome VARCHAR(80) NOT NULL,
	Sexo CHAR(1) DEFAULT 'M',
	DataCadastro DATE CONSTRAINT DF_Clientes_DataCadastro DEFAULT GETDATE()+1,
	Salario MONEY NOT NULL,
	CONSTRAINT PK_Pessoas_Codigo PRIMARY KEY(Codigo)
)
GO

-- INSERINDO UMA NOVA MASSA DE DADOS NA TABELA PESSOAS
INSERT INTO Pessoas (Nome, Salario)
VALUES ('Funcionario 1', RAND()*1000)
GO 1000

-- CONSULTANDO DADOS DA TABELA PESSOAS
SELECT Codigo, Nome, Sexo, DataCadastro, Salario FROM Pessoas
ORDER BY Salario DESC

-- ATUALIZANDO OS DADOS DA TABELA PESSOAS
UPDATE Pessoas
SET Sexo = 'F'
WHERE Codigo >= 800
GO

SELECT * FROM Pessoas
WHERE Codigo >= 800
GO

UPDATE Pessoas
SET DataCadastro = '2015-05-15',
	Nome = 'Estagiários'
WHERE Codigo BETWEEN 255 AND 479
GO

SELECT * FROM Pessoas
WHERE Codigo BETWEEN 255 AND 479
GO

SELECT * FROM Pessoas
ORDER BY Salario DESC
GO

DELETE FROM Pessoas
WHERE Salario IN (999.3515, 999.0456, 998.1993, 997.6889, 995.2384)
GO

-- EXCLUINDO DADOS NA TABELA PESSOAS
DELETE FROM Pessoas
WHERE Salario <= 900
GO

DELETE FROM Pessoas
WHERE Salario >= 200 OR Sexo = 'F'
GO

-- REMOVENDO TODOS OS DADOS DA TABELA PESSOAS
DELETE FROM Pessoas
GO

-- REMOVENDO TODOS OS DADOS DA TABELA PESSOAS, RECRIANDO TODA ESTRUTURA
TRUNCATE TABLE Pessoas
GO

-- REMOVENDO A TABELA PESSOAS FISICAMENTE
DROP TABLE Pessoas
GO