CREATE DATABASE AULA20160408;

USE AULA20160408;

-- DECLARANDO UMA NVA VARIAVEL
-- NO SQL AS VARIAVEIS COMEÇAM COM @ (AT)
DECLARE @MinhaVariavel INT;

-- ATRIBUINDO UM VALOR PARA A VARIAVEL
-- A VARIAVEL NA MAIORIA DAS VEZES RECEBERÁ UM VALOR
SET @MinhaVariavel = 1;

-- APRESENTANDO O VALOR DA VARIAVEL
PRINT @MinhaVariavel; --IMPRIME NO FORMATO TEXTO
--OU
SELECT @MinhaVariavel AS 'Valor do Select'; -- INFORMA NO FORMATO DE REGISTRO

-- DECLARANDO UM CONTADOR DE VALORES E APRESENTANDO NA TELA
DECLARE @Contador TINYINT; -- INTEIRO PEQUENO 0 ATÉ 254

SET @Contador = 0;

WHILE @Contador <= 254
	BEGIN
		SELECT @Contador
		SET @Contador = @Contador + 1;
	END

-- CRIANDO UMA VARIAVEL DO TIPO TABELA
DECLARE @MinhaTabela TABLE (
	Codigo INT PRIMARY KEY,
	Texto VARCHAR(MAX),
	Valor1 DECIMAL(18,2) DEFAULT '1.00',
	Valor2 FLOAT,
	ValorTotal AS (Valor1+Valor2)
);

SELECT * FROM @MinhaTabela;

-- INSERINDO DADOS NA TABELAVARIAVEL
DECLARE @ContadordeLinhas INT,
		@MeuTexto VARCHAR(MAX),
		@MeuValor2 FLOAT

SET @ContadordeLinhas = 1;
SET @MeuTexto = 'ESTE É UM PEQUENO TEXTO CRIADO PARA TESTE DE MANIPULAÇÃO DE DADOS NO SQL SERVER COM VARIAVEIS DO TIPO
				TABELA... ESPERO QUE VOCE GOSTE';

WHILE @ContadordeLinhas <= 2000
BEGIN
	SET @MeuValor2 = RAND()*100 -- GERANDO UM VALOR ALEATÓRIO
	INSERT INTO @MinhaTabela (Codigo, Texto, Valor2)
	VALUES (@ContadordeLinhas, @MeuTexto, @MeuValor2)

	set @ContadordeLinhas += 1; -- OPERADOR COMPOSTO
END

-- CONSULTANDO OS DADOS DA TABELA VARIÁVEL
SELECT Codigo, Texto, Valor1,
		Valor2, 
		ValorTotal
FROM @MinhaTabela;

-- CONSULTANDO OS DADOS TABELA VARIAVEL COM ARREDONDAMENTO
SELECT Codigo, Texto, Valor1,
	ROUND(Valor2,2) AS 'Valor 2 Arredondado',
	ROUND(ValorTotal,3) AS 'Valor Total Arredondado'
FROM @MinhaTabela
ORDER BY [Valor Total Arredondado];

DECLARE @Var INT
SET @Var = 1010;

IF @Var < 10
BEGIN
	PRINT 'NUMERO PEQUENO';
	PRINT 'NUMERO MENOR QUE DEZ';
END

ELSE IF @Var = 10
BEGIN
	PRINT 'DEZ';
	PRINT 'NUMERO MEDIO'
END
ELSE
BEGIN
	PRINT 'NUMERO GRANDE';
	PRINT 'NUMERO MAIOR QUE DEZ';
END

-- --- --- --- --- --- --- --- --- ---

DECLARE @b AS INT = 5,
		@C AS INT = 5,
		@D INT = 5,
		@e INT = 56;

SET @b = 5;
SET @b &= 1; --BITWISE AND EQUALS
SET @c = 5;
SET @C |= 1; -- BITWISE OR EQUALS
SET @D ^= 1; -- BITWISE EXCLUSIVE OR EQUALS
SET @e %= 5; -- MODULO EQUALS -- MOD RESTO DA DIVISAO

SELECT @b AS 'b',
		@c AS 'c',
		@d AS 'd', @e AS 'e';



--- --- --- --- --- --- --- --- --- ---
DECLARE @MinhaVariavel INT
SET @MinhaVariavel = 1

DECLARE @Minhatabela TABLE (Codigo INT)

INSERT INTO @MinhaTabela VALUES(1),(2),(3)

SELECT CASE Codigo
	WHEN 1 THEN @MinhaVariavel + 10
	WHEN 2 THEN @MinhaVariavel +2
	WHEN 3 THEN @MinhaVariavel + 3
	END AS Valores
FROM @MinhaTabela



SELECT IIF (@MinhaVariavel <= 1,
			@MinhaVariavel + Codigo,
			@MinhaVariavel - 1) 'IIF - SQL SERVER 2012'
FROM @MinhaTabela