ALTER TABLE container ADD `abandoned` DATETIME DEFAULT NULL;
ALTER TABLE vehicle ADD `vehicle_texture` text NOT NULL;
ALTER TABLE `player` ADD `temperature` DOUBLE NOT NULL DEFAULT '37' AFTER `alcohol`, ADD `wetness` DOUBLE UNSIGNED NOT NULL DEFAULT '0' AFTER `temperature`;

UPDATE player SET temperature = 37;
UPDATE player SET wetness = 0;
