-- клиент с парихмхером проживают в одном городе
DROP PROCEDURE IF EXISTS barbar_offers;
DELIMITER //

CREATE PROCEDURE barbar_offers(for_user_id BIGINT UNSIGNED)
BEGIN
	SELECT p2.user_id
	FROM profiles p1
	JOIN profiles p2 on p1.hometown = p2.hometown 
	WHERE p1.user_id = for_user_id
		and p2.user_id != for_user_id
	;

END//

DELIMITER ;

-- 	клиент часто записывался к этому парихмахеру
DROP PROCEDURE IF EXISTS barbar_offers;
DELIMITER //
CREATE PROCEDURE barbar_offers(for_user_id BIGINT UNSIGNED)
BEGIN
	SELECT client_id , COUNT(barber_id) as barber_id_count
	FROM appointments
	GROUP BY client_id 
	ORDER BY barber_id_count DESC 
END//

DELIMITER ;



