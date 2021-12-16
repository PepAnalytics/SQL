-- i. Заполнить все таблицы БД vk данными (по 10-100 записей в каждой таблице)
script_hw4.mysql

-- ii. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке
SELECT DISTINCT firstname
FROM users;

-- iii. Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false). 
-- Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1)

ALTER TABLE profiles ADD is_active BIT DEFAULT false NULL;

UPDATE profiles
SET is_active = 1
WHERE YEAR(CURRENT_TIMESTAMP) - YEAR(birthday) - (RIGHT(CURRENT_TIMESTAMP, 5) < RIGHT(birthday, 5)) < 18;

ALTER TABLE profiles ADD age bigint(5);

UPDATE profiles
SET age = YEAR(CURRENT_TIMESTAMP) - YEAR(birthday) - (RIGHT(CURRENT_TIMESTAMP, 5) < RIGHT(birthday, 5));

-- iv. Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней)
DELETE FROM messages
WHERE created_at > now();