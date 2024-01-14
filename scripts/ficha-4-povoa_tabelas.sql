-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ficha3
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ficha3
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ficha3` DEFAULT CHARACTER SET utf8 ;
USE `ficha3` ;

-- -----------------------------------------------------
-- Table `ficha3`.`aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ficha3`.`aluno` (
  `idaluno` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `nif` VARCHAR(45) NOT NULL,
  `nome_enc_edu` VARCHAR(45) NOT NULL,
  `nome_pai` VARCHAR(45) NULL,
  `nome_mae` VARCHAR(45) NULL,
  PRIMARY KEY (`idaluno`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE,
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ficha3`.`departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ficha3`.`departamento` (
  `iddepartamento` INT NOT NULL,
  `designacao` VARCHAR(45) NULL,
  PRIMARY KEY (`iddepartamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ficha3`.`docente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ficha3`.`docente` (
  `iddocente` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `categoria` VARCHAR(45) NULL,
  `departamento_iddepartamento1` INT NOT NULL,
  PRIMARY KEY (`iddocente`),
  INDEX `fk_docente_departamento1_idx` (`departamento_iddepartamento1` ASC) VISIBLE,
  CONSTRAINT `fk_docente_departamento1`
    FOREIGN KEY (`departamento_iddepartamento1`)
    REFERENCES `ficha3`.`departamento` (`iddepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ficha3`.`ciclo estudos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ficha3`.`ciclo estudos` (
  `idciclo estudos` INT NOT NULL,
  `grau` VARCHAR(45) NULL,
  PRIMARY KEY (`idciclo estudos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ficha3`.`curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ficha3`.`curso` (
  `idcurso` INT NOT NULL,
  `designacao` VARCHAR(45) NULL,
  `ano_letivo` INT(2) NULL,
  `docente_iddocente` INT NOT NULL,
  `ciclo estudos_idciclo estudos` INT NOT NULL,
  PRIMARY KEY (`idcurso`, `docente_iddocente`),
  INDEX `fk_curso_docente1_idx` (`docente_iddocente` ASC) VISIBLE,
  INDEX `fk_curso_ciclo estudos1_idx` (`ciclo estudos_idciclo estudos` ASC) VISIBLE,
  CONSTRAINT `fk_curso_docente1`
    FOREIGN KEY (`docente_iddocente`)
    REFERENCES `ficha3`.`docente` (`iddocente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_curso_ciclo estudos1`
    FOREIGN KEY (`ciclo estudos_idciclo estudos`)
    REFERENCES `ficha3`.`ciclo estudos` (`idciclo estudos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ficha3`.`UC`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ficha3`.`UC` (
  `idUC` INT NOT NULL,
  `designacao` VARCHAR(45) NULL,
  `ECTs` INT NULL,
  `curso_idcurso` INT NOT NULL,
  PRIMARY KEY (`idUC`, `curso_idcurso`),
  INDEX `fk_UC_curso1_idx` (`curso_idcurso` ASC) VISIBLE,
  CONSTRAINT `fk_UC_curso1`
    FOREIGN KEY (`curso_idcurso`)
    REFERENCES `ficha3`.`curso` (`idcurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ficha3`.`telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ficha3`.`telefone` (
  `idtelefone` INT NOT NULL,
  `numero` CHAR(9) NOT NULL,
  `aluno_idaluno` INT NOT NULL,
  PRIMARY KEY (`idtelefone`),
  UNIQUE INDEX `numero_UNIQUE` (`numero` ASC) VISIBLE,
  INDEX `fk_telefone_aluno_idx` (`aluno_idaluno` ASC) VISIBLE,
  CONSTRAINT `fk_telefone_aluno`
    FOREIGN KEY (`aluno_idaluno`)
    REFERENCES `ficha3`.`aluno` (`idaluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ficha3`.`semestre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ficha3`.`semestre` (
  `aluno_idaluno` INT NOT NULL,
  `UC_idUC` INT NOT NULL,
  `nota final` DECIMAL NULL,
  `data inicio` DATE NULL,
  `data fim` DATE NULL,
  PRIMARY KEY (`aluno_idaluno`, `UC_idUC`),
  INDEX `fk_aluno_has_UC_UC1_idx` (`UC_idUC` ASC) VISIBLE,
  INDEX `fk_aluno_has_UC_aluno1_idx` (`aluno_idaluno` ASC) VISIBLE,
  CONSTRAINT `fk_aluno_has_UC_aluno1`
    FOREIGN KEY (`aluno_idaluno`)
    REFERENCES `ficha3`.`aluno` (`idaluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_aluno_has_UC_UC1`
    FOREIGN KEY (`UC_idUC`)
    REFERENCES `ficha3`.`UC` (`idUC`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ficha3`.`inscricao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ficha3`.`inscricao` (
  `aluno_idaluno` INT NOT NULL,
  `curso_idcurso` INT NOT NULL,
  `curso_docente_iddocente` INT NOT NULL,
  `curso_ciclo estudos_idciclo estudos` INT NOT NULL,
  PRIMARY KEY (`aluno_idaluno`, `curso_idcurso`, `curso_docente_iddocente`, `curso_ciclo estudos_idciclo estudos`),
  INDEX `fk_aluno_has_curso_curso1_idx` (`curso_idcurso` ASC, `curso_docente_iddocente` ASC, `curso_ciclo estudos_idciclo estudos` ASC) VISIBLE,
  INDEX `fk_aluno_has_curso_aluno1_idx` (`aluno_idaluno` ASC) VISIBLE,
  CONSTRAINT `fk_aluno_has_curso_aluno1`
    FOREIGN KEY (`aluno_idaluno`)
    REFERENCES `ficha3`.`aluno` (`idaluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_aluno_has_curso_curso1`
    FOREIGN KEY (`curso_idcurso` , `curso_docente_iddocente`)
    REFERENCES `ficha3`.`curso` (`idcurso` , `docente_iddocente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ficha3`.`inscricao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ficha3`.`inscricao` (
  `aluno_idaluno` INT NOT NULL,
  `curso_idcurso` INT NOT NULL,
  `curso_docente_iddocente` INT NOT NULL,
  PRIMARY KEY (`aluno_idaluno`, `curso_idcurso`, `curso_docente_iddocente`),
  INDEX `fk_aluno_has_curso_curso2_idx` (`curso_idcurso` ASC, `curso_docente_iddocente` ASC) VISIBLE,
  INDEX `fk_aluno_has_curso_aluno2_idx` (`aluno_idaluno` ASC) VISIBLE,
  CONSTRAINT `fk_aluno_has_curso_aluno2`
    FOREIGN KEY (`aluno_idaluno`)
    REFERENCES `ficha3`.`aluno` (`idaluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_aluno_has_curso_curso2`
    FOREIGN KEY (`curso_idcurso` , `curso_docente_iddocente`)
    REFERENCES `ficha3`.`curso` (`idcurso` , `docente_iddocente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ficha3`.`lecciona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ficha3`.`lecciona` (
  `UC_idUC` INT NOT NULL,
  `UC_curso_idcurso` INT NOT NULL,
  `docente_iddocente` INT NOT NULL,
  `horas semanais` VARCHAR(45) NULL,
  PRIMARY KEY (`UC_idUC`, `UC_curso_idcurso`, `docente_iddocente`),
  INDEX `fk_UC_has_docente_docente1_idx` (`docente_iddocente` ASC) VISIBLE,
  INDEX `fk_UC_has_docente_UC1_idx` (`UC_idUC` ASC, `UC_curso_idcurso` ASC) VISIBLE,
  CONSTRAINT `fk_UC_has_docente_UC1`
    FOREIGN KEY (`UC_idUC` , `UC_curso_idcurso`)
    REFERENCES `ficha3`.`UC` (`idUC` , `curso_idcurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_UC_has_docente_docente1`
    FOREIGN KEY (`docente_iddocente`)
    REFERENCES `ficha3`.`docente` (`iddocente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
