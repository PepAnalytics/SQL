USE barbar;

-- Предварительно обновить данные
UPDATE appointments 
set client_id = FLOOR( 1 + RAND( ) *100 )
WHERE client_id > 15;



UPDATE appointments 
set barber_id = FLOOR( 1 + RAND( ) *15 );



--  выборка парихмахеров по стрижкам с 2000 по сегодняшний день
SELECT appointments.barber_id , users.firstname , users.lastname 
FROM appointments JOIN users  ON appointments.barber_id = users.id 
WHERE start_time BETWEEN '2000-01-01' AND NOW() 
ORDER BY appointments.id 

-- выборка клиентов по стрижкам с 2000 по сегодняшний день
SELECT appointments.client_id , users.firstname , users.lastname 
FROM appointments JOIN users  ON appointments.client_id = users.id 
WHERE start_time BETWEEN '2000-01-01' AND NOW() 
ORDER BY appointments.id 


-- количество походов в парихмахерскую каждого клиента
SELECT COUNT(*) as number_for_analytics,client_id
FROM appointments
GROUP BY client_id
ORDER BY number_for_analytics DESC 


