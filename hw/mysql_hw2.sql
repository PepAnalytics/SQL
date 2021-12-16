-- 1.Установите СУБД MySQL. Создайте в домашней директории файл .my.cnf, задав в нем логин и пароль, 
-- который указывался при установке.
[mysql]
user=root
password=

-- 2.Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name.
mysql -u root -p 
CREATE DATABASE example;
USE example;
CREATE TABLE users (
	id INT, 
	name VARCHAR(255)
);

-- 3. Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample.
CREATE DATABASE sample;
mysqldump -u root -p example > sample.sql
mysql -u root -p sample < sample.sql  
mysql -u root -p
SHOW DATABASES;
DESCRIBE sample.users;

