DROP DATABASE IF EXISTS barber;
CREATE DATABASE barber;

USE barber;

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS users;
CREATE TABLE users(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	firstname VARCHAR(50),
	lastname VARCHAR(50),
	email VARCHAR(120) UNIQUE,
	password_hash VARCHAR (125),
	remember_token VARCHAR (125),
	phone BIGINT UNSIGNED UNIQUE,
	INDEX users_firstname_lastname_idx(firstname, lastname)
);


DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles(
	user_id BIGINT UNSIGNED NOT NULL UNIQUE,
	gender CHAR(1),
	birhday DATE,
	photo_id BIGINT UNSIGNED NULL,
	created_at DATETIME DEFAULT NOW(),
	hometown VARCHAR(100),
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types(
	id SERIAL,
    name VARCHAR(255),
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS media;
CREATE TABLE media(
	id SERIAL,
    media_type_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
  	body text,
    filename VARCHAR(255),	
    size INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (media_type_id) REFERENCES media_types(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS likes;
CREATE TABLE likes(
	id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_id) REFERENCES media (id)
);

DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
	id SERIAL,
	from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(),
    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS comments;
CREATE TABLE comments(
	id SERIAL,
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	media_id BIGINT UNSIGNED NOT NULL,
	comment TEXT,
	FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id),
    FOREIGN KEY (media_id) REFERENCES media (id)
);

DROP TABLE IF EXISTS roles;
CREATE TABLE roles (
	id SERIAL, 
	name VARCHAR (100) UNIQUE,
	slug VARCHAR (100),
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS user_roles;
CREATE TABLE user_roles(
	user_id BIGINT UNSIGNED NOT NULL,
	role_id BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (role_id) REFERENCES roles(id)
);

DROP TABLE IF EXISTS permissions;
CREATE TABLE permissions(
	id SERIAL,
	key_permission BIGINT UNSIGNED NOT NULL,
	table_name VARCHAR (100),
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS permission_role;
CREATE TABLE permission_role (
	permission_id BIGINT UNSIGNED NOT NULL,
	role_id BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (permission_id) REFERENCES permissions(id),
	FOREIGN KEY (role_id) REFERENCES roles(id)
);

DROP TABLE IF EXISTS services;
CREATE TABLE services(
	id SERIAL,
	name VARCHAR (125),
	price SMALLINT UNSIGNED,
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS appointments;
CREATE TABLE appointments(
	id SERIAL,
	barber_id BIGINT UNSIGNED NOT NULL,
	client_id BIGINT UNSIGNED NOT NULL,
	start_time DATETIME,
	end_time DATETIME,
	FOREIGN KEY (barber_id) REFERENCES users(id),
	FOREIGN KEY (client_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS service_appointments;
CREATE TABLE service_appointments(
	id SERIAL,
	id_appointment BIGINT UNSIGNED NOT NULL,
	service_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY (id_appointment) REFERENCES appointments(id),
	FOREIGN KEY (service_id) REFERENCES services(id)
);

DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions(
	id SERIAL,
	id_appointment BIGINT UNSIGNED NOT NULL,
	summary BIGINT UNSIGNED NOT NULL,
	discount BIGINT UNSIGNED NOT NULL,
	total BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (id_appointment) REFERENCES appointments(id)
);

SET FOREIGN_KEY_CHECKS=1;



