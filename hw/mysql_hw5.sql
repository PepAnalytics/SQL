-- Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
UPDATE users
	SET created_at = NOW() AND updated_at = NOW();
	
-- Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR 
-- и в них долгое время помещались значения в формате "20.10.2017 8:10".
-- Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

ALTER TABLE users MODIFY COLUMN created_at varchar(150);
ALTER TABLE users MODIFY COLUMN updated_at varchar(150);

UPDATE users
	SET created_at = STR_DATE(created_at, '%d.%m.%Y %k:%i'),
	updated_at = STR_DATE(updated_at, '%d.%m.%Y %k:%i');

ALTER TABLE users
	MODIFY COLUMN created_at DATETIME,
	MODIFY COLUMN updated_at DATETIME;

-- В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, 
-- если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, 
-- чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны выводиться в конце, 
-- после всех записей.

SELECT * FROM storehouses_products ORDER BY CASE WHEN value = 0 THEN 200 ELSE value END;

-- Практическое задание теме “Агрегация данных”
-- Подсчитайте средний возраст пользователей в таблице users

SELECT ROUND((AVG(TO_DAYS(NOW()) - TO_DAYS(birthday_at)) / 365.25), 0) AS age_AVG FROM users u;

-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.

SELECT 
	DAYNAME(CONCAT(YEAR(NOW()), '-', SUBSTRING(birthday_at, 6, 10))) AS birthday_in_this_year,
	COUNT(DAYNAME(CONCAT(YEAR(NOW()), '-', SUBSTRING(birthday_at, 6, 10)))) AS count_of_birthday
FROM
	users
GROUP BY
	birthday_in_this_year;
