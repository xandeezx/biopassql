CREATE DATABASE bioPass;
USE bioPass;

CREATE TABLE Endereco (
    idEndereco int PRIMARY KEY AUTO_INCREMENT,
    UF char(2),
    cidade varchar(50),
    bairro varchar(50),
    rua varchar(100),
    numero varchar(10),
    cep varchar(10)
);

CREATE TABLE Usuario (
    idUsuario int PRIMARY KEY AUTO_INCREMENT,
    nome varchar(100) NOT NULL,
    senha varchar(100) NOT NULL,
    email varchar(100) NOT NULL UNIQUE,
    telefone varchar(20),
    idEndereco int,
    FOREIGN KEY (idEndereco) REFERENCES Endereco(idEndereco)
	ON DELETE SET NULL 
	ON UPDATE CASCADE
);

CREATE TABLE Cliente (
    CPF varchar(14) PRIMARY KEY,
    idUsuario INT UNIQUE,
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
	ON DELETE CASCADE 
	ON UPDATE CASCADE
);

CREATE TABLE Vendedor (
    CNPJ varchar(18) PRIMARY KEY,
    tipo varchar(20) NOT NULL,
    idUsuario INT UNIQUE,
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
	ON DELETE CASCADE 
    ON UPDATE CASCADE
);

CREATE TABLE Loja (
    idLoja int PRIMARY KEY AUTO_INCREMENT,
    nome varchar(100),
    site varchar(100),
    descricao text,
    praticasSustentaveis varchar(255),
    idVendedor varchar(18),
    FOREIGN KEY (idVendedor) REFERENCES Vendedor(CNPJ)
	ON DELETE SET NULL 
    ON UPDATE CASCADE
);

CREATE TABLE Produto (
    idProduto int PRIMARY KEY AUTO_INCREMENT,
    nome varchar(100),
    estoque int,
    preco decimal(10,2),
    descricao text
);

CREATE TABLE TipoSustentavel (
    idTipoSustentavel int PRIMARY KEY AUTO_INCREMENT,
    nome varchar(50)
);

CREATE TABLE Categoria (
    idCategoria int PRIMARY KEY AUTO_INCREMENT,
    nome varchar(50)
);

CREATE TABLE Produto_TipoSustentavel (
    idProduto int,
    idTipoSustentavel int,
    PRIMARY KEY (idProduto, idTipoSustentavel),
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
	ON DELETE CASCADE 
    ON UPDATE CASCADE,
    FOREIGN KEY (idTipoSustentavel) REFERENCES TipoSustentavel(idTipoSustentavel)
	ON DELETE CASCADE 
    ON UPDATE CASCADE
);

CREATE TABLE Produto_Categoria (
    idProduto int,
    idCategoria int,
    PRIMARY KEY (idProduto, idCategoria),
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
	ON DELETE CASCADE 
    ON UPDATE CASCADE,
    FOREIGN KEY (idCategoria) REFERENCES Categoria(idCategoria)
	ON DELETE CASCADE 
    ON UPDATE CASCADE
);

CREATE TABLE Loja_Produto (
    idLoja int,
    idProduto int,
    PRIMARY KEY (idLoja, idProduto),
    FOREIGN KEY (idLoja) REFERENCES Loja(idLoja)
	ON DELETE CASCADE 
    ON UPDATE CASCADE,
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
	ON DELETE CASCADE 
    ON UPDATE CASCADE
);

CREATE TABLE Carrinho (
    idCarrinho int PRIMARY KEY AUTO_INCREMENT,
    quantidade int,
    precoUnitario decimal(10,2)
);

CREATE TABLE Pedido (
    idPedido INT PRIMARY KEY AUTO_INCREMENT,
    subtotal decimal(10,2),
    status varchar(25)
);

CREATE TABLE FormaPag (
    idFormaPag int PRIMARY KEY AUTO_INCREMENT,
    tipo varchar(50),
    valorPago decimal(10,2),
    qtdParcelas int,
    idPedido int,
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido)
	ON DELETE CASCADE 
    ON UPDATE CASCADE
);

CREATE TABLE ConteudoEducativo (
    idConteudoEducativo int PRIMARY KEY AUTO_INCREMENT,
    tipo varchar(25),
    titulo varchar(100),
    descricao text,
    URL text,
    status varchar(50),
    motivoRejeicao text,
    dataPublicacao date
);

CREATE TABLE UsuarioConteudo (
    idUsuarioConteudo int PRIMARY KEY AUTO_INCREMENT,
    idUsuario int,
    idConteudoEducativo int,
    dataEnvio date,
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
	ON DELETE CASCADE 
    ON UPDATE CASCADE,
    FOREIGN KEY (idConteudoEducativo) REFERENCES ConteudoEducativo(idConteudoEducativo)
	ON DELETE CASCADE 
    ON UPDATE CASCADE
);

CREATE TABLE Feedback (
    idFeedback int PRIMARY KEY AUTO_INCREMENT,
    idProduto int,
    idCliente varchar(14),
    comentario text,
    anexo text,
    estrelas INT,
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
	ON DELETE CASCADE 
    ON UPDATE CASCADE,
    FOREIGN KEY (idCliente) REFERENCES Cliente(CPF)
	ON DELETE CASCADE 
    ON UPDATE CASCADE
);
