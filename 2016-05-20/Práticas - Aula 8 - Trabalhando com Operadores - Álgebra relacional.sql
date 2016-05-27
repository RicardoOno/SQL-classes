-- Criando o Banco de Dados - AlgebraRelacional --
Create Database AlgebraRelacional
Go

-- Acessando o Banco de Dados - AlgebraRelacional --
Use AlgebraRelacional
Go

-- Criando a Tabela Cargos --
Create Table Cargos
(CodigoCargo Char(2) Primary Key Not Null,
  DescricaoCargo Varchar(50) Not Null,
  VlrSalario Numeric(6,2) Not Null)
Go

-- Criando a Tabela Departamentos --
Create Table Departamentos
(CodigoDepartamento Char(2) Primary Key Not Null,
 DescricaoDepartamento Varchar(30) Not Null,
 RamalTel SmallInt Not Null)
Go

-- Criando a Tabela Funcionarios --
Create Table Funcionarios 
(NumeroRegistro Int Primary Key Not Null,
 NomeFuncionario Varchar(80) Not Null,
 DtAdmissao Date Default GetDate(),
 Sexo Char(1) Not Null Default 'M',
 CodigoCargo Char(2) Not Null,
 CodigoDepartamento Char(2) Not Null)
Go

-- Criando os relacionamentos --
Alter Table Funcionarios
 Add Constraint [FK_Funcionarios_Cargos] Foreign Key (CodigoCargo)
  References Cargos(CodigoCargo)
Go

Alter Table Funcionarios
 Add Constraint [FK_Funcionarios_Departamentos] Foreign Key (CodigoDepartamento)
  References Departamentos(CodigoDepartamento)
Go

-- Inserindo os Dados --
Insert Into Cargos (CodigoCargo, DescricaoCargo, VlrSalario)
Values ('C1', 'Aux.Vendas', 350.00), 
			('C2', 'Vigia', 400.00),
			('C3', 'Vendedor', 800.00),
			('C4', 'Aux.Cobrança', 250.00), 
			('C5', 'Gerente', 1000.00), 
			('C6', 'Diretor', 2500.00),
			('C7', 'Presidente', 2500.00)
Go

Insert Into Departamentos (CodigoDepartamento,DescricaoDepartamento,RamalTel)
Values ('D1', 'Assist.Técnica', 2246),
			('D2', 'Estoque', 2589),
			('D3', 'Administração', 2772),
			('D4', 'Segurança', 1810),
			('D5', 'Vendas', 2599),
			('D6', 'Cobrança', 2688)
Go


Insert Into Funcionarios (NumeroRegistro, NomeFuncionario, DtAdmissao, Sexo, CodigoCargo, CodigoDepartamento)
Values (101, 'Luis Sampaio', '2003-08-10', 'M', 'C3', 'D5'),
			(104, 'Carlos Pereira', '2004-03-02', 'M', 'C4', 'D6'),
			(134, 'Jose Alves', '2002-05-03', 'M', 'C5', 'D1'),
			(121, 'Luis Paulo Souza', '2001-12-10', 'M', 'C3', 'D5'),
			(195, 'Marta Silveira', '2002-01-05', 'F', 'C1', 'D5'),
			(139, 'Ana Luiza', '2003-01-12', 'F', 'C4', 'D6'),
			(123, 'Pedro Sergio', '2003-06-29', 'M', 'C7', 'D3'),
			(148, 'Larissa Silva', '2002-06-01', 'F', 'C4', 'D6'),
			(115, 'Roberto Fernandes', '2003-10-15', 'M', 'C3', 'D5'),
			(22, 'Sergio Nogueira', '2000-02-10', 'M', 'C2', 'D4')
Go

-- Exemplo - Operador - Projeção -- Qual o nome e data de admissão dos funcionários? --
Select NomeFuncionario, DtAdmissao From Funcionarios
Go

-- Exemplo - Operador - Seleção/Restrição -- Quais os funcionários de sexo masculino? --
Select  NumeroRegistro, NomeFuncionario, DtAdmissao, 
            Sexo, CodigoCargo, CodigoDepartamento 
From Funcionarios
Where Sexo = 'M'
Go

-- Exemplo - Operadores - Projeção e Seleção -- Quais os nomes e data de admissão dos funcionários de sexo masculino? --
Select NomeFuncionario, DtAdmissao From Funcionarios
Where Sexo = 'M'
Go

-- Exemplo - Operador - Produto Cartesiano - Trazer as informações dos funcionários e de seus cargos: Linhas de Funcionarios X Linhas de Cargos --
Select  F.NumeroRegistro, 
			F.NomeFuncionario, 
			F.DtAdmissao, 
            F.Sexo, 
			F.CodigoCargo, 
			F.CodigoDepartamento 
From Funcionarios F Cross Join Cargos C
Order By F.NumeroRegistro Desc
Go

-- Exemplo - Operador - União -- Combinação de Tabelas e Linhas entre selects distintos --
Select CodigoCargo, DescricaoCargo, VlrSalario
From Cargos
Where CodigoCargo In ('C1','C3','C5','C7')

Union

Select CodigoCargo, DescricaoCargo, VlrSalario
From Cargos
Where CodigoCargo In ('C2','C4','C6')
Go

Select CodigoCargo, DescricaoCargo, VlrSalario
From Cargos
Where CodigoCargo In ('C1','C3','C5','C7')

Union All

Select CodigoCargo, DescricaoCargo, VlrSalario
From Cargos
Where CodigoCargo In ('C2','C4','C6')

Union All

Select CodigoCargo, DescricaoCargo, VlrSalario
From Cargos
Where CodigoCargo In ('C2','C4','C6')
Go

-- Exemplo - Operador - Intersecção -- Combinação de Tabelas e Linhas entre selects distintos sem repetição de dados no resultado --
Select CodigoCargo, DescricaoCargo, VlrSalario
From Cargos
Where CodigoCargo In ('C2','C4','C6')

Intersect 

Select CodigoCargo, DescricaoCargo, VlrSalario
From Cargos
Where CodigoCargo In ('C2','C3','C6','C7')
Go

-- Exemplo - Operador - Diferença - Linhas existentes em uma Tabela que não existem em outra --
Insert Into Cargos (CodigoCargo, DescricaoCargo, VlrSalario)
Values ('C8', 'Aux.Vendas II', 550.00)
Go

Select  F.NumeroRegistro, 
			F.NomeFuncionario, 
			F.DtAdmissao, 
            F.Sexo, 
			F.CodigoCargo, 
			F.CodigoDepartamento 
From Funcionarios F 
Where Exists (Select CodigoCargo From Cargos)
Go

-- Exemplo - Operador - Junção - Combinação de Linhas e Colunas entre tabelas que possuem algum tipo de vínculo relacional --
Select  F.NumeroRegistro, 
			F.NomeFuncionario, 
			F.DtAdmissao, 
            F.Sexo, 
			F.CodigoCargo, 
			F.CodigoDepartamento 
From Funcionarios F Inner Join Cargos C
                                  On F.CodigoCargo = C.CodigoCargo
Order By F.NomeFuncionario, F.CodigoCargo Asc
Go

-- Exemplo - Operador - Divisão - Relação Completa de todos os dados da Tabela da Esquerda com todos os dados da Tabela da Direita --
Create Table Projetos
 (CodigoProjeto Char(8) Primary Key Not Null,
  DescricaoProjeto Varchar(50) Not Null)
Go

Create Table Equipe
(Codigo Int Primary Key Identity(1,1) Not Null,
 NumeroRegistroFuncionario Int Not Null,
 CodigoProjeto Char(8) Not Null)
Go

-- Criando os relacionamentos --
Alter Table Equipe
 Add Constraint [FK_Equipe_Funcionarios] Foreign Key (NumeroRegistroFuncionario)
  References Funcionarios(NumeroRegistro)
Go

Alter Table Equipe
 Add Constraint [FK_Equipe_Projetos] Foreign Key (CodigoProjeto)
  References Projetos(CodigoProjeto)
Go

-- Inserindos os Dados --
Insert Into Projetos (CodigoProjeto, DescricaoProjeto)
Values ('Projeto1', 'Suporte'),
            ('Projeto2', 'Manutenção'),
			('Projeto3', 'Desenvolvimento')
Go

Insert Into Equipe (NumeroRegistroFuncionario, CodigoProjeto)
Values ('101', 'Projeto1'),
			('104', 'Projeto1'),
			('134', 'Projeto1'),
			('101', 'Projeto2'),
			('104', 'Projeto2'),
			('101', 'Projeto3')
Go

Select E.NumeroRegistroFuncionario, 
		   E.CodigoProjeto,
		   P.DescricaoProjeto
From Equipe E Inner Join Projetos P
						 On E.CodigoProjeto = P.CodigoProjeto
Where E.CodigoProjeto = 'Projeto1'
Go

-- Exemplo - Operador - Renomeação --
sp_rename 'Cargos','NovosCargos'
Go

Select * from NovosCargos

-- Exemplo - Operador - Atribuição --
Select  F.NumeroRegistro As 'Número de Registro', 
			F.NomeFuncionario, 
			F.DtAdmissao As 'Data de Admissão',
            F.Sexo, 
			F.CodigoCargo, 
			F.CodigoDepartamento,
			Data=(Select GetDate()) -- Atribuindo um valor para uma coluna
From Funcionarios F Inner Join NovosCargos C
                                  On F.CodigoCargo = C.CodigoCargo
Order By F.NomeFuncionario, F.CodigoCargo Asc
Go