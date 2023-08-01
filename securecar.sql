DROP DATABASE if EXISTS `securecar`;

CREATE DATABASE if NOT EXISTS `securecar`;

USE `securecar`;

CREATE TABLE if NOT EXISTS `users`(
	`id` INTEGER PRIMARY KEY AUTO_INCREMENT,
	
	`full_name` VARCHAR(155) NOT NULL,
	`email` VARCHAR(255) NOT NULL UNIQUE,
	`birth` DATE NOT NULL,
	
	`cpf` VARCHAR(72) NOT NULL,
	`password` VARCHAR(72) NOT NULL
);

CREATE TABLE if NOT EXISTS `users_validation`(
	`id` INTEGER PRIMARY KEY AUTO_INCREMENT,
	
	`validation_code` CHAR(4) NOT NULL,
	`is_validated` TINYINT NOT NULL DEFAULT 0,
	
	`user_id` INTEGER,
	FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
);

CREATE TABLE if NOT EXISTS `users_token`(
	`id` INTEGER PRIMARY KEY AUTO_INCREMENT,
	
	`token` VARCHAR(72) NOT NULL,
	
	`user_id` INTEGER,
	FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
);