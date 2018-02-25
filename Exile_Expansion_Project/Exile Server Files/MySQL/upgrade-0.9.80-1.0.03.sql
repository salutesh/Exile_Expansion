ALTER TABLE `construction` CHANGE `last_updated_at` `last_updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `container` CHANGE `last_updated_at` `last_updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `vehicle` CHANGE `last_updated_at` `last_updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;