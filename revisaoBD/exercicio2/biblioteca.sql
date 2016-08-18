CREATE DATABASE biblioteca
GO

USE biblioteca
GO

Create table curso
(
	idCurso Int Not Null Primary Key Identity (1,1),
	nomeCurso Varchar(150) Not Null,
	dtInicio Date Not Null,
	dtFim Date Not Null
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

Create Table lingua
(
	idLingua Int Primary Key Not Null Identity(1,1),
	nomeLingua Varchar(150) Not Null
)

Create Table midia
(
	idMidia Int Primary Key Not Null Identity(1,1),
	descMidia Varchar(150) Not Null
)

Create table usuario
(
	idUsuario int primary key not null identity(1,1),
	nome varchar(150) not null,
	dtNasc date not null,
	sexo char(1) not null,
	ra bigint not null,
	telefone bigint not null,
	rg bigint not null,
	cpf bigint not null,
	idEndereco int not null,
	idCurso int not null
)

create table nacionalidade
(
	idNacionalidade int not null primary key identity(1,1),
	descNacionalidade varchar(150)
)

create table classificacao
(
	idClassificacao int not null primary key identity(1,1),
	descClassificacao varchar(150) not null
)

create table obra
(
	idObra int not null primary key identity(1,1),
	nomeObra varchar(150) not null,
	isbn bigint not null,
	editora varchar(150) not null,
	idLingua int not null,
	idMidia int not null,
	idClassificacao int not null,
	idAutor int not null
)

create table autor
(
	idAutor int not null primary key identity(1,1),
	nomeAutor varchar(150) not null,
	sexo char(1),
	dtNasc date not null,
	idNacionalidade int not null
)

create table emprestimo
(
	idEmprestime int not null primary key identity(1,1),
	idUsuario int not null,
	idObra int not null
)

alter table usuario
add constraint FK_usuario_idEndereco foreign key (idEndereco)
references endereco(idEndereco)

alter table usuario
add constraint FK_usuario_idCurso foreign key (idCurso)
references curso(idCurso)

alter table obra
add constraint FK_obra_idLingua foreign key (idLingua)
references lingua(idLingua)

alter table obra
add constraint FK_obra_idMidia foreign key (idMidia)
references midia(idMidia)

alter table obra
add constraint FK_obra_idClassificacao foreign key (idClassificacao)
references classificacao(idClassificacao)

alter table obra
add constraint FK_obra_idAutor foreign key (idAutor)
references autor(idAutor)

alter table autor
add constraint FK_autor_idNacionalidade foreign key (idNacionalidade)
references nacionalidade(idNacionalidade)

alter table emprestimo
add constraint FK_emprestimo_idUsuario foreign key (idUsuario)
references usuario(idUsuario)

alter table emprestimo
add constraint FK_emprestimo_idObra foreign key (idObra)
references obra(idObra)