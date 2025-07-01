-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema MR-BioPass
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema MR-BioPass
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `MR-BioPass` DEFAULT CHARACTER SET utf8 ;
USE `MR-BioPass` ;

-- -----------------------------------------------------
-- Table `MR-BioPass`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MR-BioPass`.`Usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `senha` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `telefone` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `telefone_UNIQUE` (`telefone` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MR-BioPass`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MR-BioPass`.`Cliente` (
  `Usuario_idUsuario` INT NOT NULL,
  `CPF` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`Usuario_idUsuario`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Usuario`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `MR-BioPass`.`Usuario` (`idUsuario`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MR-BioPass`.`Vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MR-BioPass`.`Vendedor` (
  `Usuario_idUsuario` INT NOT NULL,
  `CPF_CNPJ` VARCHAR(20) NOT NULL,
  `tipo` ENUM('Empresa', 'Empreendedor') NOT NULL,
  PRIMARY KEY (`Usuario_idUsuario`),
  UNIQUE INDEX `CPF_CNPJ_UNIQUE` (`CPF_CNPJ` ASC) VISIBLE,
  CONSTRAINT `fk_Vendedor_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `MR-BioPass`.`Usuario` (`idUsuario`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MR-BioPass`.`Carrinho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MR-BioPass`.`Carrinho` (
  `idCarrinho` INT NOT NULL AUTO_INCREMENT,
  `dataCriacao` DATETIME NOT NULL,
  `statusCarrinho` ENUM('Ativo', 'Excluído', 'Finalizado') NOT NULL,
  PRIMARY KEY (`idCarrinho`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MR-BioPass`.`Cliente_cria_Carrinho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MR-BioPass`.`Cliente_cria_Carrinho` (
  `Cliente_Usuario_idUsuario` INT NOT NULL,
  `Carrinho_idCarrinho` INT NOT NULL,
  PRIMARY KEY (`Cliente_Usuario_idUsuario`, `Carrinho_idCarrinho`),
  INDEX `fk_Cliente_has_Carrinho_Carrinho1_idx` (`Carrinho_idCarrinho` ASC) VISIBLE,
  INDEX `fk_Cliente_has_Carrinho_Cliente1_idx` (`Cliente_Usuario_idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_has_Carrinho_Cliente1`
    FOREIGN KEY (`Cliente_Usuario_idUsuario`)
    REFERENCES `MR-BioPass`.`Cliente` (`Usuario_idUsuario`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_has_Carrinho_Carrinho1`
    FOREIGN KEY (`Carrinho_idCarrinho`)
    REFERENCES `MR-BioPass`.`Carrinho` (`idCarrinho`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MR-BioPass`.`Loja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MR-BioPass`.`Loja` (
  `idLoja` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `site` VARCHAR(100) NOT NULL,
  `praticasSustentaveis` VARCHAR(200) NOT NULL,
  `descricao` VARCHAR(350) NULL,
  `Vendedor_Usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`idLoja`),
  INDEX `fk_Loja_Vendedor1_idx` (`Vendedor_Usuario_idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Loja_Vendedor1`
    FOREIGN KEY (`Vendedor_Usuario_idUsuario`)
    REFERENCES `MR-BioPass`.`Vendedor` (`Usuario_idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MR-BioPass`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MR-BioPass`.`Produto` (
  `idProduto` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `estoque` INT UNSIGNED NOT NULL,
  `preco` DECIMAL(10,2) UNSIGNED ZEROFILL NOT NULL,
  `descricao` VARCHAR(350) NULL,
  `Loja_idLoja` INT NOT NULL,
  PRIMARY KEY (`idProduto`),
  INDEX `fk_Produto_Loja1_idx` (`Loja_idLoja` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_Loja1`
    FOREIGN KEY (`Loja_idLoja`)
    REFERENCES `MR-BioPass`.`Loja` (`idLoja`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MR-BioPass`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MR-BioPass`.`Categoria` (
  `idCategoria` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MR-BioPass`.`TipoSustentavel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MR-BioPass`.`TipoSustentavel` (
  `idTipoSustentavel` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idTipoSustentavel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MR-BioPass`.`ItemCarrinho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MR-BioPass`.`ItemCarrinho` (
  `Carrinho_idCarrinho` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `precoUnitario` DECIMAL(10,2) UNSIGNED ZEROFILL NOT NULL,
  `quantidade` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Carrinho_idCarrinho`, `Produto_idProduto`),
  INDEX `fk_Carrinho_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Carrinho_has_Produto_Carrinho1_idx` (`Carrinho_idCarrinho` ASC) VISIBLE,
  CONSTRAINT `fk_Carrinho_has_Produto_Carrinho1`
    FOREIGN KEY (`Carrinho_idCarrinho`)
    REFERENCES `MR-BioPass`.`Carrinho` (`idCarrinho`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Carrinho_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `MR-BioPass`.`Produto` (`idProduto`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MR-BioPass`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MR-BioPass`.`Pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `prazoEntrega` INT UNSIGNED NOT NULL,
  `valorFrete` DECIMAL(10,2) UNSIGNED ZEROFILL NOT NULL,
  `subtotal` DECIMAL(10,2) UNSIGNED ZEROFILL NOT NULL,
  `statusPedido` ENUM('Pendente', 'Finalizado', 'Cancelado') NOT NULL,
  `Carrinho_idCarrinho` INT NOT NULL,
  PRIMARY KEY (`idPedido`),
  INDEX `fk_Pedido_Carrinho1_idx` (`Carrinho_idCarrinho` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Carrinho1`
    FOREIGN KEY (`Carrinho_idCarrinho`)
    REFERENCES `MR-BioPass`.`Carrinho` (`idCarrinho`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MR-BioPass`.`FormaPag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MR-BioPass`.`FormaPag` (
  `idFormaPag` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NOT NULL,
  `valorPago` DECIMAL(10,2) UNSIGNED ZEROFILL NOT NULL,
  `qtdParcelas` INT UNSIGNED NULL,
  `Pedido_idPedido` INT NOT NULL,
  PRIMARY KEY (`idFormaPag`),
  INDEX `fk_FormaPag_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_FormaPag_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `MR-BioPass`.`Pedido` (`idPedido`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MR-BioPass`.`Feedback`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MR-BioPass`.`Feedback` (
  `idFeedback` INT NOT NULL AUTO_INCREMENT,
  `data` DATETIME NOT NULL,
  `comentario` VARCHAR(350) NULL,
  `estrelas` TINYINT NOT NULL,
  `Cliente_Usuario_idUsuario` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  PRIMARY KEY (`idFeedback`),
  INDEX `fk_Feedback_Cliente1_idx` (`Cliente_Usuario_idUsuario` ASC) VISIBLE,
  INDEX `fk_Feedback_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Feedback_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Feedback_Cliente1`
    FOREIGN KEY (`Cliente_Usuario_idUsuario`)
    REFERENCES `MR-BioPass`.`Cliente` (`Usuario_idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Feedback_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `MR-BioPass`.`Produto` (`idProduto`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Feedback_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `MR-BioPass`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MR-BioPass`.`Produto_possui_Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MR-BioPass`.`Produto_possui_Categoria` (
  `Produto_idProduto` INT NOT NULL,
  `Categoria_idCategoria` INT NOT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Categoria_idCategoria`),
  INDEX `fk_Produto_has_Categoria_Categoria1_idx` (`Categoria_idCategoria` ASC) VISIBLE,
  INDEX `fk_Produto_has_Categoria_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Categoria_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `MR-BioPass`.`Produto` (`idProduto`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Categoria_Categoria1`
    FOREIGN KEY (`Categoria_idCategoria`)
    REFERENCES `MR-BioPass`.`Categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MR-BioPass`.`Produto_possui_TipoSustentavel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MR-BioPass`.`Produto_possui_TipoSustentavel` (
  `Produto_idProduto` INT NOT NULL,
  `TipoSustentavel_idTipoSustentavel` INT NOT NULL,
  PRIMARY KEY (`Produto_idProduto`, `TipoSustentavel_idTipoSustentavel`),
  INDEX `fk_Produto_has_TipoSustentavel_TipoSustentavel1_idx` (`TipoSustentavel_idTipoSustentavel` ASC) VISIBLE,
  INDEX `fk_Produto_has_TipoSustentavel_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_TipoSustentavel_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `MR-BioPass`.`Produto` (`idProduto`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_TipoSustentavel_TipoSustentavel1`
    FOREIGN KEY (`TipoSustentavel_idTipoSustentavel`)
    REFERENCES `MR-BioPass`.`TipoSustentavel` (`idTipoSustentavel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MR-BioPass`.`Endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MR-BioPass`.`Endereco` (
  `Usuario_idUsuario` INT NOT NULL,
  `UF` CHAR(2) NOT NULL,
  `cidade` VARCHAR(100) NOT NULL,
  `rua` VARCHAR(100) NOT NULL,
  `comp` VARCHAR(45) NULL,
  `CEP` VARCHAR(9) NOT NULL,
  `numero` INT NOT NULL,
  `bairro` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Usuario_idUsuario`),
  CONSTRAINT `fk_Endereco_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `MR-BioPass`.`Usuario` (`idUsuario`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MR-BioPass`.`ConteudoEducativo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MR-BioPass`.`ConteudoEducativo` (
  `idConteudoEducativo` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(350) NULL,
  `URL` VARCHAR(250) NULL,
  `dataPublicacao` DATETIME NOT NULL,
  `tipo` ENUM('Artigo', 'Vídeo', 'Dica') NOT NULL,
  PRIMARY KEY (`idConteudoEducativo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MR-BioPass`.`UsuarioConteudo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MR-BioPass`.`UsuarioConteudo` (
  `ConteudoEducativo_idConteudoEducativo` INT NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  `motivoRejeicao` VARCHAR(100) NULL,
  `dataEnvio` DATETIME NOT NULL,
  `status` ENUM('Pendente', 'Aceito', 'Rejeitado') NOT NULL,
  PRIMARY KEY (`ConteudoEducativo_idConteudoEducativo`, `Usuario_idUsuario`),
  INDEX `fk_ConteudoEducativo_has_Usuario_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
  INDEX `fk_ConteudoEducativo_has_Usuario_ConteudoEducativo1_idx` (`ConteudoEducativo_idConteudoEducativo` ASC) VISIBLE,
  CONSTRAINT `fk_ConteudoEducativo_has_Usuario_ConteudoEducativo1`
    FOREIGN KEY (`ConteudoEducativo_idConteudoEducativo`)
    REFERENCES `MR-BioPass`.`ConteudoEducativo` (`idConteudoEducativo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ConteudoEducativo_has_Usuario_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `MR-BioPass`.`Usuario` (`idUsuario`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
