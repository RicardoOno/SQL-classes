Use AlgebraRelacional
Go

-- Criando as Tabelas --
Create Table Marca
(Marca_Cod Int Primary Key Identity(1,1),
 Marca_Desc Varchar(100) Not Null)
Go

Create Table Modelo
(Modelo_Cod Int Primary Key Identity(1,1),
 Modelo_Desc Varchar(100) Not Null)
Go

Create Table Automovel
(Auto_Cod Int Primary Key Identity(1,1),
 Marca_Cod Int Not Null,
 Modelo_Cod Int Not Null,
 Auto_Nome Varchar(100) Not Null)
Go

Create Table Cliente
(Cliente_Cod Int Primary Key Identity(1,1),
 Cliente_Nome Varchar(100) Not Null,
 Cliente_Email Varchar(200) Null,
 Cliente_CPF Int Default 0,
 Cliente_Endereco Varchar(200) Null,
 Cliente_Numero SmallInt Null,
 Cliente_Complemento Varchar(100) Null,
 Cliente_Cidade Varchar(80) Default 'São Roque',
 Cliente_Estado Char(2) Default 'SP',
 DT_Cadastro Date Default GetDate())
Go

Create Table Locacao
(Locacao_Cod Int Primary Key Identity(1,1),
 Auto_Cod Int Not Null,
 Cliente_Cod Int Not Null,
 Locacao_KM Numeric(8,2) Not Null,
 DT_Cadastro Date Default GetDate())
Go

-- Criando os Relacionamentos --
Alter Table Automovel
 Add Constraint FK_Automovel_Marca Foreign Key (Marca_Cod)
  References Marca(Marca_Cod)
Go

Alter Table Automovel
 Add Constraint FK_Automovel_Modelo Foreign Key (Modelo_Cod)
  References Modelo(Modelo_Cod)
Go

Alter Table Locacao
 Add Constraint FK_Locacao_Automovel Foreign Key (Auto_Cod)
  References Automovel(Auto_Cod)
Go

Alter Table Locacao
 Add Constraint FK_Locacao_Cliente Foreign Key (Cliente_Cod)
  References Cliente(Cliente_Cod)
Go


-- Realizar o Insert --
Insert Into Marca Values ('Fiat'),('Ford'),('GM')
Go

Insert Into Marca Values ('Hyundai')
Go


Insert Into Modelo Values ('1.4'),('1.0'),('1.6')
Go

Insert Into Automovel (Marca_Cod, Modelo_Cod, Auto_Nome)
Values (1,1,'Palio'),
       (1,2,'Fiat 147'),
	   (2,3,'Fiesta'),
	   (3,1,'Onix LT'),
	   (3,2,'Cruze'),
	   (2,1,'Ka')
Go
	
Insert Into Automovel (Marca_Cod, Modelo_Cod, Auto_Nome)
Values (4, 1, 'Fuscao')
	
Insert Into Automovel (Marca_Cod, Modelo_Cod, Auto_Nome)
Values (9, 4, 'HB20 Plus')
					
					
Select * from Marca

Select * from Modelo						  

-- Resposta 1 --
Select Min(Auto_Cod) As ValorMinimo,
	   Max(Auto_Cod) As ValorMaximo,
	   Count(Auto_Cod) As Contador2,
	   Sum(Auto_Cod) As Somatoria,
	   AVG(Auto_Cod) As Media
From Automovel
Go

-- Resposta 2 --
Select A.Auto_Nome, 
       Mo.Modelo_Desc, 
	   Ma.Marca_Desc
From Automovel A Right Join Modelo As Mo
				  On A.Modelo_Cod = Mo.Modelo_Cod
				 Right Join Marca Ma
				  On A.Marca_Cod = Ma.Marca_Cod
Order By A.Auto_Cod ASC
Go

-- Respsta 3 --
Select A.Auto_Nome As 'Automóvel', 
       Mo.Modelo_Desc As 'Modelo', 
	   Ma.Marca_Desc As 'Marca'
From Automovel A Inner Join Modelo As Mo
				  On A.Modelo_Cod = Mo.Modelo_Cod
				 Inner Join Marca Ma
				  On A.Marca_Cod = Ma.Marca_Cod
Order By A.Auto_Nome ASC
Go

