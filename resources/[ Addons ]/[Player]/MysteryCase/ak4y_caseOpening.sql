CREATE TABLE IF NOT EXISTS `ak4y_caseopening` (
  `#` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL DEFAULT '0',
  `goldcoin` int(11) NOT NULL DEFAULT 0,
  `silvercoin` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`#`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS `ak4y_caseopening_codes` (
  `code` varchar(255) DEFAULT NULL,
  `creditCount` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

