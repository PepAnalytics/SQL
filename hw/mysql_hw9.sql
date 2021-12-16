-- В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

SELECT * FROM shop.users;
SELECT * FROM sample.users;

START TRANSACTION;
INSERT INTO sample.users SELECT * FROM shop.users WHERE id = 1;
DELETE FROM shop.users WHERE id = 1;
COMMIT;

-- Создайте представление, которое выводит название name товарной позиции из таблицы products и 
-- соответствующее название каталога name из таблицы catalogs.
CREATE VIEW pro_cat_names (product_name, catalog_name)
	AS SELECT 
		products.name, 
		catalogs.name
	FROM 
		products
	JOIN 
		catalogs
	ON 
		products.catalog_id = catalogs.id;
	
SELECT * FROM pro_cat_names;

-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"
-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, 
-- в зависимости от текущего времени суток. С 6:00 до 12:00
--  функция должна возвращать фразу "Доброе утро",
--  с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
--  с 18:00 до 00:00 — "Добрый вечер",
--  с 00:00 до 6:00 — "Доброй ночи".
DELIMITER //
CREATE FUNCTION hello()
RETURNS TINYTEXT NOT DETERMINISTIC
BEGIN
	DECLARE hour INT;
	SET hour = HOUR(NOW());
	CASE
		WHEN hour BETWEEN 0 AND 5 THEN 
			RETURN "Доброй ночи";
		WHEN hour BETWEEN 6 AND 11 THEN 
			RETURN "Доброе утро";
		WHEN hour BETWEEN 12 AND 7 THEN 
			RETURN "Добрыйй день";
		WHEN hour BETWEEN 18 AND 23 THEN 
			RETURN "Добрый вечер";
	END CASE;
END//

CALL hello();

-- В таблице products есть два текстовых поля: name с названием товара и description с его описанием.
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
-- При попытке присвоить полям NULL-значение необходимо отменить операцию
DELIMITER //
CREATE TRIGGER error_name_descript BEFORE INSERT ON products
FOR EACH ROW BEGIN
	IF NEW.name IS NULL AND NEW.description IS NULL 
		THEN SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Поле name и description неккоректны';
	END IF;
END//

-- ПРОВЕРКА
INSERT INTO products 
	(name, description, price, catalog_id)
VALUES
	(NULL, NULL, 2222.00, 2)
