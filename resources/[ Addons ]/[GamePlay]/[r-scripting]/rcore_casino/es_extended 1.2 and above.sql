INSERT INTO `items` (`name`, `label`, `weight`) VALUES ('casino_beer', 'Casino Beer', '0');
INSERT INTO `items` (`name`, `label`, `weight`) VALUES ('casino_burger', 'Casino Burger', '0');
INSERT INTO `items` (`name`, `label`, `weight`) VALUES ('casino_chips', 'Casino Chips', '0');
INSERT INTO `items` (`name`, `label`, `weight`) VALUES ('casino_coffee', 'Casino Coffee', '0');
INSERT INTO `items` (`name`, `label`, `weight`) VALUES ('casino_coke', 'Casino Kofola', '0');
INSERT INTO `items` (`name`, `label`, `weight`) VALUES ('casino_donut', 'Casino Donut', '0');
INSERT INTO `items` (`name`, `label`, `weight`) VALUES ('casino_ego_chaser', 'Casino Ego Chaser', '0');
INSERT INTO `items` (`name`, `label`, `weight`) VALUES ('casino_luckypotion', 'Casino Lucky Potion', '0');
INSERT INTO `items` (`name`, `label`, `weight`) VALUES ('casino_psqs', 'Casino Ps & Qs', '0');
INSERT INTO `items` (`name`, `label`, `weight`) VALUES ('casino_sandwitch', 'Casino Sandwitch', '0');
INSERT INTO `items` (`name`, `label`, `weight`) VALUES ('casino_sprite', 'Casino Sprite', '0');

INSERT INTO `jobs` (`name`, `label`) VALUES ('casino', 'casino');

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (NULL, 'casino', '0', 'novice', 'novice', '200', '{}', '{}');
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (NULL, 'casino', '1', 'experienced', 'experienced', '200', '{}', '{}');
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (NULL, 'casino', '2', 'boss', 'boss', '200', '{}', '{}');

INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES ('society_casino', 'Diamond Casino', '1');