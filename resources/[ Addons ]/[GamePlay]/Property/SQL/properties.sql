CREATE TABLE `properties_build` (
	`propertyID` INT(11) NOT NULL AUTO_INCREMENT,
	`propertyOwner` VARCHAR(100) NULL DEFAULT '-' COLLATE 'utf8mb4_general_ci',
	`ownerName` VARCHAR(100) NULL DEFAULT '-' COLLATE 'utf8mb4_general_ci',
	`propertyLabel` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`propertyInteriors` INT(11) NULL DEFAULT NULL,
	`propertyEntering` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`propertyGarage` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`propertyRented` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`garageInteriors` INT(11) NULL DEFAULT NULL,
	`data` LONGTEXT NULL DEFAULT '{}' COLLATE 'utf8mb4_general_ci',
	`dataMoney` LONGTEXT NULL DEFAULT '{"dirtycash":{"count":0},"money":{"count":0}}' COLLATE 'utf8mb4_general_ci',
	`maxStorage` INT(11) NULL DEFAULT NULL,
	`ownerList` LONGTEXT NULL DEFAULT '{}' COLLATE 'utf8mb4_general_ci',
	PRIMARY KEY (`propertyID`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=1
;

-- CREATE TABLE `properties_vehicles` (
-- 	`propertyID` INT(11) NULL DEFAULT NULL,
-- 	`plate` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
-- 	`data_vehicle` LONGTEXT NOT NULL COLLATE 'utf8mb4_general_ci',
-- 	`stored` INT(11) NULL DEFAULT '1'
-- )
-- COLLATE='utf8mb4_general_ci'
-- ENGINE=InnoDB
-- ;

-- INSERT INTO `addon_account` (name, label, shared) VALUES
--   ('society_realestateagent','Agent immobilier',1)
-- ;

-- INSERT INTO `jobs` (name, label) VALUES
--   ('realestateagent','Agent immobilier')
-- ;

-- INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
--   ('realestateagent',0,'location','Location',10,'{}','{}'),
--   ('realestateagent',1,'vendeur','Vendeur',25,'{}','{}'),
--   ('realestateagent',2,'gestion','Gestion',40,'{}','{}'),
--   ('realestateagent',3,'boss','Patron',0,'{}','{}')
-- ;




