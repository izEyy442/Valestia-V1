INSERT INTO `items` (`name`, `label`, `limit`) VALUES
	('weed', 'Weed', 50),
	('weed_pooch', 'Pochon de weed', 10),
	('coke', 'Coke', 50),
	('coke_pooch', 'Pochon de coke', 10),
	('meth', 'Meth', 50),
	('meth_pooch', 'Pochon de meth', 10)
;

CREATE TABLE `drugss` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`owner` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`type` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`value` INT(11) NULL DEFAULT NULL,
	`data` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`storage` LONGTEXT NULL DEFAULT '{}' COLLATE 'utf8mb4_general_ci',
	`production` LONGTEXT NULL DEFAULT '{}' COLLATE 'utf8mb4_general_ci',
	`password` MEDIUMINT(9) NULL DEFAULT NULL,
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=1
;
