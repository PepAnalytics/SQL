--Представления о роли юзера на плоащдке (парихмахеры:beginner,middle,master), (клиенты:newmember,nofirst,classikclient,premiumclient,vipclient)

CREATE VIEW user_rol (id, firstname , lastname, roles)
	AS SELECT 
		users.id, 
		users.firstname, 
		users.lastname,
		roles.name 
	FROM 
		users
	INNER JOIN
		user_roles
		ON users.id = user_roles.user_id 
	INNER JOIN 
		roles
		ON	user_roles.role_id = roles.id
	ORDER BY roles.name;
		
-- проверка
SELECT * FROM user_rol;

-- представления о записях к мастерам 
CREATE VIEW appoint (time_app, barber_firstname , barber_lastname )
	AS SELECT
		appointments.start_time,
		users.firstname, 
		users.lastname
	FROM 
		appointments
	INNER JOIN
		users
		ON users.id = appointments.barber_id
	ORDER BY appointments.start_time DESC;

-- проверка
SELECT * FROM appoint;
		

	
