-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
SELECT id,name,birthday_at FROM users u;

SELECT * FROM orders o ;

INSERT  INTO orders (user_id)
SELECT id
FROM users WHERE name = 'Геннадий';

INSERT  INTO orders (user_id)
SELECT id
FROM users WHERE name = 'Наталья';

INSERT  INTO orders (user_id)
SELECT id
FROM users WHERE name = 'Александр';

INSERT  INTO orders (user_id)
SELECT id
FROM users WHERE name = 'Сергей';

SELECT * FROM users
WHERE id IN (SELECT user_id FROM orders);

-- Выведите список товаров products и разделов catalogs, который соответствует товару.
SELECT id, name, price, catalog_id FROM products;
SELECT * FROM catalogs;

SELECT id, name, price,
	(SELECT name FROM catalogs WHERE id = products.catalog_id)
FROM  products;
