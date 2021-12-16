-- Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, 
-- который больше всех общался с выбранным пользователем (написал ему сообщений).

SELECT 
	from_user_id
	, concat(users.firstname, ' ', users.lastname) AS name
	, count(*) AS 'messages count'
FROM messages 
JOIN users on users.id = messages.from_user_id
WHERE to_user_id = 1
GROUP BY from_user_id
ORDER BY count(*) desc
limit 1;

-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..
select count(*) as likes_count
from likes
where media_id in (
	select id 
	from media 
	where user_id in ( 
		select 
			user_id
		-- 	, birthday
		from profiles as p
		where  YEAR(CURDATE()) - YEAR(birthday) < 10
	)
);

-- Определить кто больше поставил лайков (всего): мужчины или женщины.

SELECT  gender, COUNT(*) as gender_like_count
from likes
join profiles on likes.user_id = profiles.user_id 
group by gender;
