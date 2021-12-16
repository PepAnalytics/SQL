DELIMITER //
CREATE TRIGGER before_insert_appointments BEFORE INSERT ON appointments FOR EACH ROW 
	BEGIN 
		IF NEW.barber_id = client_id 
			THEN THEN SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Мастер не может быть клиентом у себя';
	END;

END //
			
INSERT INTO appointments 
VALUES
	(1,1, 1, '2021-09-07 22:44:20', '2021-09-07 22:44:20');