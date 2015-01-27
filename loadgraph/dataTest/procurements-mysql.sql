-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Procurements
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS Procurements ;

-- -----------------------------------------------------
-- Schema Procurements
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS Procurements DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE Procurements ;

-- -----------------------------------------------------
-- Table Procurements.People
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Procurements.People (
  pk_person INT NOT NULL,
  name_person VARCHAR(45) NOT NULL,
  birthday DATE NOT NULL,
  PRIMARY KEY (pk_person))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Procurements.Ministry
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Procurements.Ministry (
  pk_ministry INT NOT NULL,
  name_ministry VARCHAR(150) NOT NULL,
  PRIMARY KEY (pk_ministry))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Procurements.Departments
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Procurements.Departments (
  pk_department INT NOT NULL,
  fk_ministry INT NOT NULL,
  depart_name VARCHAR(150) NOT NULL,
  PRIMARY KEY (pk_department),
  INDEX fk_department_Main_Depart1_idx (fk_ministry ASC),
  CONSTRAINT fk_Depart_Main_Agency1
    FOREIGN KEY (fk_ministry)
    REFERENCES Procurements.Ministry (pk_ministry)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Procurements.Procurements
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Procurements.Procurements (
  pk_procurement INT NOT NULL,
  fk_department INT NOT NULL,
  publication_date DATE NULL,
  homologation_date DATE NULL,
  PRIMARY KEY (pk_procurement),
  INDEX fk_Procurements_Depart1_idx (fk_department ASC),
  CONSTRAINT fk_Procurements_Depart1
    FOREIGN KEY (fk_department)
    REFERENCES Procurements.Departments (pk_department)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Procurements.Procurements_Items
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Procurements.Procurements_Items (
  pk_procurement_item INT NOT NULL,
  fk_procurement INT NOT NULL,
  num_item INT NOT NULL,
  final_price DECIMAL(18,2) NOT NULL,
  item_description VARCHAR(150) NOT NULL,
  PRIMARY KEY (pk_procurement_item),
  INDEX fk_Itens_Licitacoes_Licitacoes1_idx (fk_procurement ASC),
  CONSTRAINT fk_Itens_Licitacoes_Licitacoes1
    FOREIGN KEY (fk_procurement)
    REFERENCES Procurements.Procurements (pk_procurement)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Procurements.Companies
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Procurements.Companies (
  pk_company INT NOT NULL,
  company_name VARCHAR(150) NOT NULL,
  open_date DATE NOT NULL,
  close_date DATE NULL,
  PRIMARY KEY (pk_company))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Procurements.Attendees
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Procurements.Attendees (
  fk_company INT NOT NULL,
  fk_procurement_item INT NOT NULL,
  PRIMARY KEY (fk_company, fk_procurement_item),
  INDEX fk_Participantes_Itens_Licitacoes1_idx (fk_procurement_item ASC),
  CONSTRAINT fk_Participantes_Empresas1
    FOREIGN KEY (fk_company)
    REFERENCES Procurements.Companies (pk_company)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Participantes_Itens_Licitacoes1
    FOREIGN KEY (fk_procurement_item)
    REFERENCES Procurements.Procurements_Items (pk_procurement_item)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Procurements.Partner_Qualification
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Procurements.Partner_Qualification (
  pk_partner_qualification INT NOT NULL,
  partner_qualification VARCHAR(60) NOT NULL,
  PRIMARY KEY (pk_partner_qualification))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Procurements.People_Partners
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Procurements.People_Partners (
  fk_person_partner INT NOT NULL,
  fk_company INT NOT NULL,
  fk_partner_qualification INT NOT NULL,
  PRIMARY KEY (fk_person_partner, fk_company),
  INDEX fk_Soicios_Empresas_Empresas1_idx (fk_company ASC),
  INDEX fk_People_Partners_Partner_Qualification1_idx (fk_partner_qualification ASC),
  CONSTRAINT fk_Soicios_Empresas_Socios
    FOREIGN KEY (fk_person_partner)
    REFERENCES Procurements.People (pk_person)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Soicios_Empresas_Empresas1
    FOREIGN KEY (fk_company)
    REFERENCES Procurements.Companies (pk_company)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_People_Partners_Partner_Qualification1
    FOREIGN KEY (fk_partner_qualification)
    REFERENCES Procurements.Partner_Qualification (pk_partner_qualification)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Procurements.Companies_Partners
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Procurements.Companies_Partners (
  fk_company INT NOT NULL,
  fk_company_partner INT NOT NULL,
  fk_partner_qualification INT NOT NULL,
  PRIMARY KEY (fk_company, fk_company_partner),
  INDEX fk_Companies_Partners_Companies2_idx (fk_company_partner ASC),
  INDEX fk_Companies_Partners_Partner_Qualification1_idx (fk_partner_qualification ASC),
  CONSTRAINT fk_Companies_Partners_Companies1
    FOREIGN KEY (fk_company)
    REFERENCES Procurements.Companies (pk_company)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Companies_Partners_Companies2
    FOREIGN KEY (fk_company_partner)
    REFERENCES Procurements.Companies (pk_company)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Companies_Partners_Partner_Qualification1
    FOREIGN KEY (fk_partner_qualification)
    REFERENCES Procurements.Partner_Qualification (pk_partner_qualification)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Procurements.Telephone
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Procurements.Telephone (
  pk_telephone INT NOT NULL,
  telephone_number VARCHAR(12) NOT NULL,
  PRIMARY KEY (pk_telephone))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Procurements.CompaniesTelephones
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Procurements.CompaniesTelephones (
  fk_telephone INT NOT NULL,
  fk_company INT NOT NULL,
  PRIMARY KEY (fk_telephone, fk_company),
  INDEX fk_CompanyTelephones_Companies1_idx (fk_company ASC),
  CONSTRAINT fk_CompanyTelephones_Telephone1
    FOREIGN KEY (fk_telephone)
    REFERENCES Procurements.Telephone (pk_telephone)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_CompanyTelephones_Companies1
    FOREIGN KEY (fk_company)
    REFERENCES Procurements.Companies (pk_company)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Procurements.PeopleTelephones
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Procurements.PeopleTelephones (
  fk_telephone INT NOT NULL,
  fk_person INT NOT NULL,
  PRIMARY KEY (fk_telephone, fk_person),
  INDEX fk_PeopleCompanies_Telephone1_idx (fk_telephone ASC),
  CONSTRAINT fk_PeopleCompanies_People1
    FOREIGN KEY (fk_person)
    REFERENCES Procurements.People (pk_person)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_PeopleCompanies_Telephone1
    FOREIGN KEY (fk_telephone)
    REFERENCES Procurements.Telephone (pk_telephone)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table Procurements.People
-- -----------------------------------------------------
START TRANSACTION;
USE Procurements;
INSERT INTO Procurements.People (pk_person, name_person, birthday) VALUES (1, 'PEOPLE A', '1970-01-20');
INSERT INTO Procurements.People (pk_person, name_person, birthday) VALUES (2, 'PEOPLE B', '1980-02-02');
INSERT INTO Procurements.People (pk_person, name_person, birthday) VALUES (3, 'PEOPLE C', '1977-12-30');
INSERT INTO Procurements.People (pk_person, name_person, birthday) VALUES (4, 'PEOPLE D', '1956-06-29');
INSERT INTO Procurements.People (pk_person, name_person, birthday) VALUES (5, 'PEOPLE E', '1967-09-04');
INSERT INTO Procurements.People (pk_person, name_person, birthday) VALUES (6, 'PEOPLE F', '1976-09-10');
INSERT INTO Procurements.People (pk_person, name_person, birthday) VALUES (7, 'PEOPLE G', '1965-08-23');
INSERT INTO Procurements.People (pk_person, name_person, birthday) VALUES (8, 'PEOPLE H', '1964-03-28');
INSERT INTO Procurements.People (pk_person, name_person, birthday) VALUES (9, 'PEOPLE I', '1976-04-18');
INSERT INTO Procurements.People (pk_person, name_person, birthday) VALUES (10, 'PEOPLE J', '1954-07-23');

COMMIT;

-- -----------------------------------------------------
-- Data for table Procurements.Telephone
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO Procurements.Telephone (pk_telephone, telephone_number) VALUES (1, '55550001');
INSERT INTO Procurements.Telephone (pk_telephone, telephone_number) VALUES (2, '55550002');
INSERT INTO Procurements.Telephone (pk_telephone, telephone_number) VALUES (3, '55550003');
INSERT INTO Procurements.Telephone (pk_telephone, telephone_number) VALUES (4, '55550004');
INSERT INTO Procurements.Telephone (pk_telephone, telephone_number) VALUES (5, '55550005');
INSERT INTO Procurements.Telephone (pk_telephone, telephone_number) VALUES (6, '55550006');
INSERT INTO Procurements.Telephone (pk_telephone, telephone_number) VALUES (7, '55550007');

COMMIT;

-- -----------------------------------------------------
-- Data for table Procurements.TelephonePeople
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO Procurements.PeopleTelephones (fk_telephone, fk_company) VALUES (1, 1);
INSERT INTO Procurements.PeopleTelephones (fk_telephone, fk_company) VALUES (2, 2);
INSERT INTO Procurements.PeopleTelephones (fk_telephone, fk_company) VALUES (3, 3);
INSERT INTO Procurements.PeopleTelephones (fk_telephone, fk_company) VALUES (2, 4);

COMMIT;

-- -----------------------------------------------------
-- Data for table Procurements.Ministry
-- -----------------------------------------------------
START TRANSACTION;
USE Procurements;
INSERT INTO Procurements.Ministry (pk_ministry, name_ministry) VALUES (1, 'MINISTRY A');
INSERT INTO Procurements.Ministry (pk_ministry, name_ministry) VALUES (2, 'MINISTRY B');
INSERT INTO Procurements.Ministry (pk_ministry, name_ministry) VALUES (3, 'MINISTRY C');
INSERT INTO Procurements.Ministry (pk_ministry, name_ministry) VALUES (4, 'MINISTRY D');

COMMIT;

-- -----------------------------------------------------
-- Data for table Procurements.Companies
-- -----------------------------------------------------
START TRANSACTION;
USE Procurements;
INSERT INTO Procurements.Companies (pk_company, company_name, open_date, close_date) VALUES (1, 'COMPANY A', '1979-01-22', '9999-12-31');
INSERT INTO Procurements.Companies (pk_company, company_name, open_date, close_date) VALUES (2, 'COMPANY B', '1945-10-12', '9999-12-31');
INSERT INTO Procurements.Companies (pk_company, company_name, open_date, close_date) VALUES (3, 'COMPANY C', '1989-09-22', '9999-12-31');
INSERT INTO Procurements.Companies (pk_company, company_name, open_date, close_date) VALUES (4, 'COMPANY D', '1969-07-03', '2014-02-23');
INSERT INTO Procurements.Companies (pk_company, company_name, open_date, close_date) VALUES (5, 'COMPANY E', '1967-06-04', '9999-12-31');
INSERT INTO Procurements.Companies (pk_company, company_name, open_date, close_date) VALUES (6, 'COMPANY F', '1983-12-01', '9999-12-31');
INSERT INTO Procurements.Companies (pk_company, company_name, open_date, close_date) VALUES (7, 'COMPANY G', '1934-06-09', '2013-03-02');
INSERT INTO Procurements.Companies (pk_company, company_name, open_date, close_date) VALUES (8, 'COMPANY H', '1999-02-12', '9999-12-31');
INSERT INTO Procurements.Companies (pk_company, company_name, open_date, close_date) VALUES (9, 'COMPANY I', '2000-05-29', '9999-12-31');
INSERT INTO Procurements.Companies (pk_company, company_name, open_date, close_date) VALUES (10, 'COMPANY J', '2010-06-16', '9999-12-31');

COMMIT;

-- -----------------------------------------------------
-- Data for table Procurements.TelephoneCompanies
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO Procurements.CompaniesTelephones (fk_telephone, fk_company) VALUES (1, 1);
INSERT INTO Procurements.CompaniesTelephones (fk_telephone, fk_company) VALUES (2, 2);
INSERT INTO Procurements.CompaniesTelephones (fk_telephone, fk_company) VALUES (3, 3);
INSERT INTO Procurements.CompaniesTelephones (fk_telephone, fk_company) VALUES (2, 4);
INSERT INTO Procurements.CompaniesTelephones (fk_telephone, fk_company) VALUES (4, 5);
INSERT INTO Procurements.CompaniesTelephones (fk_telephone, fk_company) VALUES (5, 6);
INSERT INTO Procurements.CompaniesTelephones (fk_telephone, fk_company) VALUES (1, 7);
INSERT INTO Procurements.CompaniesTelephones (fk_telephone, fk_company) VALUES (4, 8);
INSERT INTO Procurements.CompaniesTelephones (fk_telephone, fk_company) VALUES (6, 9);
INSERT INTO Procurements.CompaniesTelephones (fk_telephone, fk_company) VALUES (7, 10);

COMMIT;

-- -----------------------------------------------------
-- Data for table Procurements.Partner_Qualification
-- -----------------------------------------------------
START TRANSACTION;
USE Procurements;
INSERT INTO Procurements.Partner_Qualification (pk_partner_qualification, partner_qualification) VALUES (1, 'ADMINISTRATOR');
INSERT INTO Procurements.Partner_Qualification (pk_partner_qualification, partner_qualification) VALUES (2, 'SHAREHOLD');
INSERT INTO Procurements.Partner_Qualification (pk_partner_qualification, partner_qualification) VALUES (3, 'DIRECTOR');
INSERT INTO Procurements.Partner_Qualification (pk_partner_qualification, partner_qualification) VALUES (4, 'PARTNER');

COMMIT;

-- -----------------------------------------------------
-- Data for table Procurements.Departments
-- -----------------------------------------------------
START TRANSACTION;
USE Procurements;
INSERT INTO Procurements.Departments (pk_department, fk_ministry, depart_name) VALUES (1, 1, 'DEPARTMENT A');
INSERT INTO Procurements.Departments (pk_department, fk_ministry, depart_name) VALUES (2, 1, 'DEPARTMENT B');
INSERT INTO Procurements.Departments (pk_department, fk_ministry, depart_name) VALUES (3, 2, 'DEPARTMENT C');
INSERT INTO Procurements.Departments (pk_department, fk_ministry, depart_name) VALUES (4, 2, 'DEPARTMENT D');
INSERT INTO Procurements.Departments (pk_department, fk_ministry, depart_name) VALUES (5, 3, 'DEPARTMENT E');
INSERT INTO Procurements.Departments (pk_department, fk_ministry, depart_name) VALUES (6, 3, 'DEPARTMENT F');
INSERT INTO Procurements.Departments (pk_department, fk_ministry, depart_name) VALUES (7, 4, 'DEPARTMENT G');
INSERT INTO Procurements.Departments (pk_department, fk_ministry, depart_name) VALUES (8, 4, 'DEPARTMENT H');

COMMIT;

-- -----------------------------------------------------
-- Data for table Procurements.Procurements
-- -----------------------------------------------------
START TRANSACTION;
USE Procurements;
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (1, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (2, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (3, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (4, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (5, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (6, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (7, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (8, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (9, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (10, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (11, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (12, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (13, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (14, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (15, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (16, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (17, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (18, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (19, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (20, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (21, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (22, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (23, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (24, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (25, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (26, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (27, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (28, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (29, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');
INSERT INTO Procurements.Procurements (pk_procurement, fk_department, publication_date, homologation_date) VALUES (30, FLOOR(1 + (RAND( ) * 8) ), date_sub(curdate(), INTERVAL FLOOR(1 + (RAND( ) * 1000) ) DAY), '999-12-31');

UPDATE Procurements.Procurements SET homologation_date = date_add(publication_date, INTERVAL FLOOR(1 + (RAND( ) * 100) ) DAY);

COMMIT;

-- -----------------------------------------------------
-- Data for table Procurements.Procurements_items
-- -----------------------------------------------------
START TRANSACTION;
USE Procurements;

INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (1, 1, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (2, 1, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (3, 1, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (4, 2, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (5, 2, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (6, 2, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (7, 3, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (8, 3, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (9, 3, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (10, 4, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (11, 4, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (12, 4, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (13, 5, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (14, 5, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (15, 5, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (16, 6, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (17, 6, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (18, 6, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (19, 7, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (20, 7, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (21, 7, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (22, 8, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (23, 8, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (24, 8, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (25, 9, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (26, 9, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (27, 9, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (28, 10, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (29, 10, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (30, 10, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (31, 11, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (32, 11, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (33, 11, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (34, 12, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (35, 12, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (36, 12, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (37, 13, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (38, 13, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (39, 13, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (40, 14, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (41, 14, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (42, 14, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (43, 15, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (44, 15, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (45, 15, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (46, 16, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (47, 16, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (48, 16, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (49, 17, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (50, 17, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (51, 17, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (52, 18, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (53, 18, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (54, 18, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (55, 19, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (56, 19, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (57, 19, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (58, 20, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (59, 20, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (60, 20, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (61, 21, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (62, 21, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (63, 21, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (64, 22, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (65, 22, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (66, 22, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (67, 23, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (68, 23, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (69, 23, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (70, 24, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (71, 24, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (72, 24, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (73, 25, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (74, 25, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (75, 25, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (76, 26, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (77, 26, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (78, 26, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (79, 27, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (80, 27, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (81, 27, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (82, 28, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (83, 28, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (84, 28, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (85, 29, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (86, 29, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (87, 29, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (88, 30, 1, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (89, 30, 2, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));
INSERT INTO Procurements.Procurements_items (pk_procurement_item, fk_procurement, num_item, final_price, item_description) VALUES (90, 30, 3, CAST(1 + (RAND( ) * 90000) AS DECIMAL(18,2)), CONCAT('ITEM ', CAST(FLOOR(1 + (RAND( ) * 50)) AS CHAR(50))));

COMMIT;

-- -----------------------------------------------------
-- Data for table Procurements.People_Partners
-- -----------------------------------------------------
START TRANSACTION;
USE Procurements;

INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1, 1);
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 2, 1);
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 3, 1);
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 4, 1);
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 5, 1);
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 6, 1);
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 7, 1);
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 8, 1);
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 9, 1);
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 10, 1);

INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.People_Partners (fk_person_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));

COMMIT;

-- -----------------------------------------------------
-- Data for table Procurements.Companies_Partners
-- -----------------------------------------------------
START TRANSACTION;
USE Procurements;

INSERT INTO Procurements.Companies_Partners (fk_company_partner, fk_company, fk_partner_qualification) VALUES (1, 2, 2 + (RAND( ) * 4));
INSERT INTO Procurements.Companies_Partners (fk_company_partner, fk_company, fk_partner_qualification) VALUES (2, 3, 2 + (RAND( ) * 4));
INSERT INTO Procurements.Companies_Partners (fk_company_partner, fk_company, fk_partner_qualification) VALUES (3, 4, 2 + (RAND( ) * 4));
INSERT INTO Procurements.Companies_Partners (fk_company_partner, fk_company, fk_partner_qualification) VALUES (4, 5, 2 + (RAND( ) * 4));
INSERT INTO Procurements.Companies_Partners (fk_company_partner, fk_company, fk_partner_qualification) VALUES (1, 6, 2 + (RAND( ) * 4));
INSERT INTO Procurements.Companies_Partners (fk_company_partner, fk_company, fk_partner_qualification) VALUES (6, 7, 2 + (RAND( ) * 4));
INSERT INTO Procurements.Companies_Partners (fk_company_partner, fk_company, fk_partner_qualification) VALUES (7, 8, 2 + (RAND( ) * 4));

INSERT INTO Procurements.Companies_Partners (fk_company_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.Companies_Partners (fk_company_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.Companies_Partners (fk_company_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.Companies_Partners (fk_company_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.Companies_Partners (fk_company_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.Companies_Partners (fk_company_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.Companies_Partners (fk_company_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.Companies_Partners (fk_company_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.Companies_Partners (fk_company_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));
INSERT INTO Procurements.Companies_Partners (fk_company_partner, fk_company, fk_partner_qualification) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 10), 2 + (RAND( ) * 4));

COMMIT;

-- -----------------------------------------------------
-- Data for table Procurements.Attendees
-- -----------------------------------------------------
START TRANSACTION;
USE Procurements;

INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 2);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 3);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 4);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 5);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 6);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 7);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 8);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 9);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 10);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 11);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 12);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 13);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 14);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 15);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 16);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 17);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 18);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 19);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 20);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 21);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 22);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 23);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 24);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 25);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 26);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 27);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 28);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 29);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 30);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 31);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 32);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 33);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 34);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 35);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 36);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 37);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 38);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 39);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 40);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 41);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 42);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 43);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 44);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 45);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 46);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 47);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 48);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 49);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 50);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 51);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 52);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 53);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 54);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 55);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 56);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 57);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 58);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 59);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 60);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 61);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 62);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 63);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 64);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 65);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 66);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 67);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 68);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 69);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 70);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 71);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 72);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 73);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 74);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 75);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 76);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 77);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 78);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 79);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 80);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 81);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 82);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 83);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 84);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 85);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 86);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 87);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 89);
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 90);

INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));
INSERT INTO Procurements.Attendees (fk_company, fk_procurement_item) VALUES (1 + (RAND( ) * 10), 1 + (RAND( ) * 90));

COMMIT;

