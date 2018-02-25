ALTER TABLE territory DROP COLUMN `flag_steal_message`;
ALTER TABLE player ADD `money` INT NOT NULL DEFAULT '0' AFTER `account_uid`;
ALTER TABLE vehicle ADD  `money` INT unsigned NOT NULL DEFAULT '0';
ALTER TABLE container ADD `money` INT unsigned NOT NULL DEFAULT '0';
ALTER TABLE account ADD `locker` INT NOT NULL DEFAULT '0' AFTER `deaths`;

UPDATE account SET `locker` = `money`;

ALTER TABLE account DROP COLUMN `money`;

ALTER TABLE construction ADD `deleted_at` DATETIME DEFAULT NULL;
ALTER TABLE `construction` ADD COLUMN `damage` TINYINT UNSIGNED NULL DEFAULT '0' AFTER `pin_code`;
ALTER TABLE territory ADD `deleted_at` DATETIME DEFAULT NULL;
ALTER TABLE container ADD `deleted_at` DATETIME DEFAULT NULL;
ALTER TABLE vehicle ADD `deleted_at` DATETIME DEFAULT NULL;
ALTER TABLE `territory`ADD COLUMN `xm8_protectionmoney_notified` TINYINT(1) NOT NULL DEFAULT '0' AFTER `last_paid_at`;

ALTER TABLE `account` DROP FOREIGN KEY `account_ibfk_1`;
ALTER TABLE `clan` DROP FOREIGN KEY `clan_ibfk_1`;

DROP TABLE IF EXISTS `clan`;
DROP TABLE IF EXISTS `clan_map_marker`;

CREATE TABLE IF NOT EXISTS `clan` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `leader_uid` varchar(32) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `leader_uid` (`leader_uid`),
  CONSTRAINT `clan_ibfk_1` FOREIGN KEY (`leader_uid`) REFERENCES `account` (`uid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `clan_map_marker` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `clan_id` int(11) unsigned NOT NULL,
  `markerType` tinyint(4) NOT NULL DEFAULT '-1',
  `positionArr` text NOT NULL,
  `color` varchar(255) NOT NULL,
  `icon` varchar(255) NOT NULL,
  `iconSize` float unsigned NOT NULL,
  `label` varchar(255) NOT NULL,
  `labelSize` float unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `clan_id` (`clan_id`),
  CONSTRAINT `clan_map_marker_ibfk_1` FOREIGN KEY (`clan_id`) REFERENCES `clan` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE account ADD CONSTRAINT `account_ibfk_1` FOREIGN KEY (`clan_id`) REFERENCES `clan` (`id`) ON DELETE SET NULL;