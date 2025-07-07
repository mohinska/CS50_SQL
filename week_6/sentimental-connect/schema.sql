CREATE TABLE `users` (
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(32) NOT NULL,
    `username` VARCHAR(32) NOT NULL UNIQUE,
    `password` VARCHAR(128) NOT NULL,
    PRIMARY KEY(`id`)
);

CREATE TABLE `schools` (
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(32) NOT NULL,
    `type` ENUM('Elementary School', 'Middle School', 'High School', 'Lower School', 'Upper School', 'College', 'University') NOT NULL,
    `location` VARCHAR(32) NOT NULL,
    `year` YEAR NOT NULL,
    PRIMARY KEY(`id`)
);

CREATE TABLE `companies` (
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(32) NOT NULL,
    `type` ENUM('Education', 'Technology', 'Finance') NOT NULL,
    `location` VARCHAR(32) NOT NULL,
    PRIMARY KEY(`id`)
);

CREATE TABLE `people_connections` (
    `id` INT AUTO_INCREMENT,
    `userA_id` INT,
    `userB_id` INT,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`userA_id`) REFERENCES `users`(`id`),
    FOREIGN KEY(`userB_id`) REFERENCES `users`(`id`)
);

CREATE TABLE `school_connections` (
    `id` INT AUTO_INCREMENT,
    `user_id` INT,
    `school_id` INT,
    `affiliation_start` DATE NOT NULL,
    `affiliation_end` DATE,
    `degree_type` ENUM('BA', 'MA', 'PhD') NOT NULL,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY(`school_id`) REFERENCES `schools`(`id`)
);

CREATE TABLE `company_connections` (
    `id` INT AUTO_INCREMENT,
    `user_id` INT,
    `company_id` INT,
    `affiliation_start` DATE NOT NULL,
    `affiliation_end` DATE,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY(`company_id`) REFERENCES `companies`(`id`)
);
