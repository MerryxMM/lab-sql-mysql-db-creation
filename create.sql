-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema uni
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema uni
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `uni` DEFAULT CHARACTER SET utf8 ;
USE `uni` ;

-- -----------------------------------------------------
-- Table `uni`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`category` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `category_name` INT NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE INDEX `course_id_UNIQUE` (`category_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`Products` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `name` INT NOT NULL,
  `price` INT NULL,
  `size` VARCHAR(45) NULL,
  `category_category_id` INT NOT NULL,
  PRIMARY KEY (`product_id`, `category_category_id`),
  INDEX `fk_Products_category1_idx` (`category_category_id` ASC) VISIBLE,
  CONSTRAINT `fk_Products_category1`
    FOREIGN KEY (`category_category_id`)
    REFERENCES `uni`.`category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`Suppliers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`Suppliers` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `phone` INT NOT NULL,
  `Products_product_id` INT NOT NULL,
  PRIMARY KEY (`student_id`, `Products_product_id`),
  UNIQUE INDEX `student_id_UNIQUE` (`student_id` ASC) VISIBLE,
  INDEX `fk_Suppliers_Products1_idx` (`Products_product_id` ASC) VISIBLE,
  CONSTRAINT `fk_Suppliers_Products1`
    FOREIGN KEY (`Products_product_id`)
    REFERENCES `uni`.`Products` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`Stores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`Stores` (
  `store_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `manager` VARCHAR(45) NOT NULL,
  `Orders_order_id` INT NOT NULL,
  PRIMARY KEY (`store_id`, `Orders_order_id`),
  UNIQUE INDEX `store_id_UNIQUE` (`store_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`Customer` (
  `customer_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`Orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `quantity` INT NULL,
  `order_date` DATE NULL,
  `Stores_store_id` INT NOT NULL,
  `Stores_Orders_order_id` INT NOT NULL,
  `Customer_customer_id` INT NOT NULL,
  PRIMARY KEY (`order_id`, `Stores_store_id`, `Stores_Orders_order_id`, `Customer_customer_id`),
  UNIQUE INDEX `order_id_UNIQUE` (`order_id` ASC) VISIBLE,
  INDEX `fk_Orders_Stores1_idx` (`Stores_store_id` ASC, `Stores_Orders_order_id` ASC) VISIBLE,
  INDEX `fk_Orders_Customer1_idx` (`Customer_customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Stores1`
    FOREIGN KEY (`Stores_store_id` , `Stores_Orders_order_id`)
    REFERENCES `uni`.`Stores` (`store_id` , `Orders_order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Customer1`
    FOREIGN KEY (`Customer_customer_id`)
    REFERENCES `uni`.`Customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`Orders_has_Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`Orders_has_Products` (
  `Orders_order_id` INT NOT NULL,
  `Products_product_id` INT NOT NULL,
  PRIMARY KEY (`Orders_order_id`, `Products_product_id`),
  INDEX `fk_Orders_has_Products_Products1_idx` (`Products_product_id` ASC) VISIBLE,
  INDEX `fk_Orders_has_Products_Orders_idx` (`Orders_order_id` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_has_Products_Orders`
    FOREIGN KEY (`Orders_order_id`)
    REFERENCES `uni`.`Orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_has_Products_Products1`
    FOREIGN KEY (`Products_product_id`)
    REFERENCES `uni`.`Products` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`Stores_has_Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`Stores_has_Products` (
  `Stores_store_id` INT NOT NULL,
  `Stores_Orders_order_id` INT NOT NULL,
  `Products_product_id` INT NOT NULL,
  PRIMARY KEY (`Stores_store_id`, `Stores_Orders_order_id`, `Products_product_id`),
  INDEX `fk_Stores_has_Products_Products1_idx` (`Products_product_id` ASC) VISIBLE,
  INDEX `fk_Stores_has_Products_Stores1_idx` (`Stores_store_id` ASC, `Stores_Orders_order_id` ASC) VISIBLE,
  CONSTRAINT `fk_Stores_has_Products_Stores1`
    FOREIGN KEY (`Stores_store_id` , `Stores_Orders_order_id`)
    REFERENCES `uni`.`Stores` (`store_id` , `Orders_order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Stores_has_Products_Products1`
    FOREIGN KEY (`Products_product_id`)
    REFERENCES `uni`.`Products` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`Stores_has_Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`Stores_has_Customer` (
  `Stores_store_id` INT NOT NULL,
  `Stores_Orders_order_id` INT NOT NULL,
  `Customer_customer_id` INT NOT NULL,
  PRIMARY KEY (`Stores_store_id`, `Stores_Orders_order_id`, `Customer_customer_id`),
  INDEX `fk_Stores_has_Customer_Customer1_idx` (`Customer_customer_id` ASC) VISIBLE,
  INDEX `fk_Stores_has_Customer_Stores1_idx` (`Stores_store_id` ASC, `Stores_Orders_order_id` ASC) VISIBLE,
  CONSTRAINT `fk_Stores_has_Customer_Stores1`
    FOREIGN KEY (`Stores_store_id` , `Stores_Orders_order_id`)
    REFERENCES `uni`.`Stores` (`store_id` , `Orders_order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Stores_has_Customer_Customer1`
    FOREIGN KEY (`Customer_customer_id`)
    REFERENCES `uni`.`Customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`Stores_has_Suppliers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`Stores_has_Suppliers` (
  `Stores_store_id` INT NOT NULL,
  `Stores_Orders_order_id` INT NOT NULL,
  `Suppliers_student_id` INT NOT NULL,
  PRIMARY KEY (`Stores_store_id`, `Stores_Orders_order_id`, `Suppliers_student_id`),
  INDEX `fk_Stores_has_Suppliers_Suppliers1_idx` (`Suppliers_student_id` ASC) VISIBLE,
  INDEX `fk_Stores_has_Suppliers_Stores1_idx` (`Stores_store_id` ASC, `Stores_Orders_order_id` ASC) VISIBLE,
  CONSTRAINT `fk_Stores_has_Suppliers_Stores1`
    FOREIGN KEY (`Stores_store_id` , `Stores_Orders_order_id`)
    REFERENCES `uni`.`Stores` (`store_id` , `Orders_order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Stores_has_Suppliers_Suppliers1`
    FOREIGN KEY (`Suppliers_student_id`)
    REFERENCES `uni`.`Suppliers` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
