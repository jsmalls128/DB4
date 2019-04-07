-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Uni
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Uni
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Uni` DEFAULT CHARACTER SET utf8 ;
USE `Uni` ;

-- -----------------------------------------------------
-- Table `Uni`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Uni`.`department` (
  `DEPTNAME` VARCHAR(45) NULL,
  `DEPTCODE` VARCHAR(45) NOT NULL,
  `DEPTOFFICE` INT NULL,
  `DEPTPHONE` VARCHAR(45) NULL,
  `DEPTCOLLEGE` VARCHAR(45) NULL,
  `COLLEGEDEAN` VARCHAR(45) NULL,
  PRIMARY KEY (`DEPTCODE`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Uni`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Uni`.`student` (
  `SNAME` VARCHAR(45) NULL,
  `SNUM` INT NULL,
  `SSN` INT NOT NULL,
  `SCADDR` VARCHAR(45) NULL,
  `SCPHONE` VARCHAR(45) NULL,
  `SPADDR` VARCHAR(45) NULL,
  `SPPHONE` VARCHAR(45) NULL,
  `BDATE` VARCHAR(45) NULL,
  `SEX` VARCHAR(45) NULL,
  `CLASS` VARCHAR(45) NULL,
  `MAJORDEPTCODE` VARCHAR(45) NOT NULL,
  `MINORDEPTCODE` VARCHAR(45) NOT NULL,
  `PROG` VARCHAR(45) NULL,
  PRIMARY KEY (`SSN`),
  INDEX `fk_student_department_idx` (`MAJORDEPTCODE` ASC) VISIBLE,
  INDEX `fk_student_department1_idx` (`MINORDEPTCODE` ASC) VISIBLE,
  CONSTRAINT `fk_student_department`
    FOREIGN KEY (`MAJORDEPTCODE`)
    REFERENCES `Uni`.`department` (`DEPTCODE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_department1`
    FOREIGN KEY (`MINORDEPTCODE`)
    REFERENCES `Uni`.`department` (`DEPTCODE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Uni`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Uni`.`course` (
  `CNAME` VARCHAR(45) NULL,
  `CDESC` VARCHAR(45) NULL,
  `CNUM` INT NOT NULL,
  `CREDIT` INT NULL,
  `LEVEL` INT NULL,
  `CDEPT` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CNUM`),
  INDEX `fk_course_department1_idx` (`CDEPT` ASC) VISIBLE,
  CONSTRAINT `fk_course_department1`
    FOREIGN KEY (`CDEPT`)
    REFERENCES `Uni`.`department` (`DEPTCODE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Uni`.`section`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Uni`.`section` (
  `INSTUCTORNAME` VARCHAR(45) NULL,
  `SEMESTER` VARCHAR(45) NOT NULL,
  `YEAR` INT NOT NULL,
  `SECOURSE` INT NOT NULL,
  `SECNUM` INT NOT NULL,
  `INSTRUCTOROFFICE` INT NULL,
  INDEX `fk_section_course1_idx` (`SECOURSE` ASC) INVISIBLE,
  PRIMARY KEY (`SECNUM`, `SECOURSE`, `YEAR`, `SEMESTER`),
  CONSTRAINT `fk_section_course1`
    FOREIGN KEY (`SECOURSE`)
    REFERENCES `Uni`.`course` (`CNUM`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Uni`.`grade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Uni`.`grade` (
  `SSN` INT NOT NULL,
  `SEMESTER` VARCHAR(45) NOT NULL,
  `YEAR` INT NOT NULL,
  `SECNUM` INT NOT NULL,
  `SECOURSE` INT NOT NULL,
  `GRADE` VARCHAR(45) NULL,
  INDEX `fk_grade_section1_idx` (`SECNUM` ASC, `SECOURSE` ASC, `YEAR` ASC, `SEMESTER` ASC) INVISIBLE,
  INDEX `fk_grade_student1_idx` (`SSN` ASC) VISIBLE,
  CONSTRAINT `fk_grade_section1`
    FOREIGN KEY (`SECNUM` , `SECOURSE` , `YEAR` , `SEMESTER`)
    REFERENCES `Uni`.`section` (`SECNUM` , `SECOURSE` , `YEAR` , `SEMESTER`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grade_student1`
    FOREIGN KEY (`SSN`)
    REFERENCES `Uni`.`student` (`SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
