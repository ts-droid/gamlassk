-- Create roles table
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int AUTO_INCREMENT NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text,
  `permissions` json NOT NULL,
  `isCustom` int NOT NULL DEFAULT 1,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `roles_id` PRIMARY KEY(`id`),
  CONSTRAINT `roles_name_unique` UNIQUE(`name`)
);

-- Add roleId column to users table if it doesn't exist
ALTER TABLE `users` ADD COLUMN `roleId` int;

-- Insert default roles
INSERT INTO `roles` (`name`, `description`, `permissions`, `isCustom`) VALUES
  ('huvudadmin', 'Huvudadministratör med full åtkomst', '["manage_all", "manage_roles", "manage_users", "manage_news", "manage_members", "view_members"]', 0),
  ('nyhetsadmin', 'Administratör för nyhetshantering', '["manage_news"]', 0),
  ('medlemsadmin', 'Administratör för medlemshantering', '["manage_members", "view_members"]', 0)
ON DUPLICATE KEY UPDATE `description` = VALUES(`description`), `permissions` = VALUES(`permissions`);
