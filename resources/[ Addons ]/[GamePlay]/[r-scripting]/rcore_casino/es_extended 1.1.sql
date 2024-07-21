INSERT INTO `items` (`name`, `label`, `limit`) VALUES ('casino_beer', 'Casino Beer', '-1');
INSERT INTO `items` (`name`, `label`, `limit`) VALUES ('casino_burger', 'Casino Burger', '-1');
INSERT INTO `items` (`name`, `label`, `limit`) VALUES ('casino_chips', 'Casino Chips', '-1');
INSERT INTO `items` (`name`, `label`, `limit`) VALUES ('casino_coffee', 'Casino Coffee', '-1');
INSERT INTO `items` (`name`, `label`, `limit`) VALUES ('casino_coke', 'Casino Kofola', '-1');
INSERT INTO `items` (`name`, `label`, `limit`) VALUES ('casino_donut', 'Casino Donut', '-1');
INSERT INTO `items` (`name`, `label`, `limit`) VALUES ('casino_ego_chaser', 'Casino Ego Chaser', '-1');
INSERT INTO `items` (`name`, `label`, `limit`) VALUES ('casino_luckypotion', 'Casino Lucky Potion', '-1');
INSERT INTO `items` (`name`, `label`, `limit`) VALUES ('casino_psqs', 'Casino Ps & Qs', '-1');
INSERT INTO `items` (`name`, `label`, `limit`) VALUES ('casino_sandwitch', 'Casino Sandwitch', '-1');
INSERT INTO `items` (`name`, `label`, `limit`) VALUES ('casino_sprite', 'Casino Sprite', '-1');


INSERT INTO `jobs` (`name`, `label`) VALUES ('casino', 'casino');

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (NULL, 'casino', '0', 'novice', 'novice', '200', '{}', '{}');
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (NULL, 'casino', '1', 'experienced', 'experienced', '200', '{}', '{}');
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (NULL, 'casino', '2', 'boss', 'boss', '200', '{}', '{}');

INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES ('society_casino', 'Diamond Casino', '1');
