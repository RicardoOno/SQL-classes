-- Acessando o Banco de Dados --
Use FatecBD1
Go

-- Criando a Tabela Fornecedores utilizando Constrainst - Not Null, Null, Check, Default e Unique --
Create Table Fornecedores
(Codigo Int Primary Key Identity(1,1),
 RazaoSocial Varchar(80) Not Null,
 Apelido VarChar(30),
 CNPJ BigInt Not Null Unique NonClustered,
 CPF BigInt Not Null Unique NonClustered,
 DataCadastro DateTime Default GetDate(),
 Email Varchar(100) Not Null)
Go

-- Criando a Tabela Produtos utilizando Constrainst - Not Null, Null, Check, Default e Unique --
Create Table Produtos
(Codigo Int Identity(1,1),
 Descricao Varchar(80) Not Null,
 DataCadastro DateTime Constraint DF_Produtos_DataCadastro Default GetDate(),
 Quantidade SmallInt Not Null Default (0),
 ValorUnitario Float Not Null 
  Constraint PK_Produtos_Codigo Primary Key (Codigo),
  Constraint CK_Produtos_ValorUnitario Check (ValorUnitario >=0))
Go

-- Adicionando a Coluna CodFornecedor na Tabela Produtos --
Alter Table Produtos
 Add CodFornecedor Int Not Null
Go

-- Estabelecendo o Relacionamento entre as Tabelas Produtos e Fornecedores --
Alter Table Produtos
 Add Constraint [FK_Produtos_Fornecedores] Foreign Key (CodFornecedor)
  References Fornecedores(Codigo)
Go

-- Inserindo dados na Tabela Fornecedores --
Insert Into Fornecedores (RazaoSocial, Apelido, CNPJ, CPF, DataCadastro, Email)
Values ('Fornecedor Fatec', 
              'Fornec Fatec', 
			  14397991003, 
			  28877143805, 
			  '2015-03-10',
			  'fornecedora@fornec.com.br')
Go

Insert Into Fornecedores (RazaoSocial, Apelido, CNPJ, CPF, DataCadastro, Email)
Values ('Fornecedor B', 'Fornec B', 14397991002, 28877148804, '2015-03-10','fornecedorb@fornec.com.br')
Go

Insert Into Fornecedores (RazaoSocial, Apelido, CNPJ, CPF, DataCadastro, Email)
Values ('Fornecedor C', 'Fornec C', 14397991003, 28877148806, '2015-03-10','fornecedorc@fornec.com.br')
Go

-- Consultando os dados da Tabela Fornecedores --
Select Codigo, RazaoSocial, 
       Apelido, CNPJ, 
	   CPF, DataCadastro, 
	   Email 
From Fornecedores
Order By CNPJ
Go

-- Inserindo dados na Tabela Produtos --
Insert Into Produtos (Descricao, Quantidade, ValorUnitario, CodFornecedor)
Values ('Arroz', 10, 12.50,1),
            ('Feijão', 100, 22.50,2)
Go

-- Consultando os dados da Tabela Produtos --
Select Codigo, 
           Descricao, 
           DataCadastro, 
           Round(Quantidade,2) As 'Quantidade', 
		   Round(ValorUnitario,-1) As 'Valor Unitário', 
	       CodFornecedor
From Produtos
Go

-- Trabalhando com Junção de Dados -- Inner Join --
Select P.Codigo, 
           P.Descricao,
           P.DataCadastro,
	       F.Codigo As 'Codigo Fornecedor',
	       F.RazaoSocial As 'Razão Social',
	       F.CNPJ As 'CNPJ Fornecedor'
From Produtos P Inner Join Fornecedores F
                 On P.CodFornecedor = F.Codigo
Go


Select * From Produtos
Where Codigo = 3

-- Trabalhando com Junção de Dados -- Inner Join --
Select P.Codigo, P.Descricao,
       P.DataCadastro,
	   F.Codigo As 'Codigo Fornecedor',
	   F.RazaoSocial As 'Razão Social',
	   F.CNPJ As 'CNPJ Fornecedor'
From Produtos P Inner Join Fornecedores F
                 On P.CodFornecedor = F.Codigo
				 
Select P.Codigo, P.Descricao,
       P.DataCadastro,
	   P.CodFornecedor As 'Codigo Fornecedor',
	   F.RazaoSocial As 'Razão Social',
	   F.CNPJ As 'CNPJ Fornecedor'
From Produtos P Inner Join Fornecedores F
                 On P.CodFornecedor = F.Codigo

-- Trabalhando com Left Join --
Insert Into Fornecedores (RazaoSocial, Apelido, CNPJ, CPF, DataCadastro, Email)
Values ('Fornecedor XXX', 
                'Fornec XXXx', 
				14397991007, 
				28877148807, 
				2015-03-24,
				'fornecedorxxx@fornexxx.com.br')


Select P.Codigo, 
            P.Descricao,
            P.DataCadastro,
	        F.RazaoSocial As 'Razão Social',
	        F.CNPJ As 'CNPJ Fornecedor',
	        F.Codigo As 'Código do Fornecedor'
From Produtos P Right Join Fornecedores F
                 On P.CodFornecedor = F.Codigo



Create Table Estoques
 (Codigo Int Identity(1,1) Primary Key,
  CodProduto Int Not Null)

Insert Into Estoques (CodProduto)
Values (1100),
              (2397),
			  (25655)

Select * from Estoques

-- Trabalhando com Right Join --
Select P.Codigo, 
            P.Descricao,
            P.DataCadastro,
	        P.CodFornecedor As 'Codigo Fornecedor em produtos',
	        F.RazaoSocial As 'Razão Social',
	        F.CNPJ As 'CNPJ Fornecedor',
	        F.Codigo As 'Código do Fornecedor em Fornecedores',
	        E.Codigo As 'Código do Estoque'
From Produtos  Inner Join Fornecedores F
                                   On P.CodFornecedor = F.Codigo
								   And P.Quantidade >=10
								 Right Join Estoques E
								  On E.CodProduto = P.Codigo
--Where P.Codigo Is Not Null
Order By P.Codigo


Select * from Produtos
Union All
Select * from produtos P1