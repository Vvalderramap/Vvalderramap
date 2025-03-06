--Cargamos nuestras tabla hotel_bookings
SELECT * FROM hotel_bookings;

--si queremos ver el número total de bookings por mes podemos usar la función groupby con la variable 'arrival_date_month'
--como en nuestro dataset no está especificado el mes por número, tenemos que usar el argumento 'CASE'
SELECT arrival_date_month, COUNT(*) AS booking_mes
FROM hotel_bookings
GROUP BY arrival_date_month
ORDER BY CASE arrival_date_month
    WHEN 'January' THEN 1
    WHEN 'February' THEN 2
    WHEN 'March' THEN 3
    WHEN 'April' THEN 4
    WHEN 'May' THEN 5
    WHEN 'June' THEN 6
    WHEN 'July' THEN 7
    WHEN 'August' THEN 8
    WHEN 'September' THEN 9
    WHEN 'October' THEN 10
    WHEN 'November' THEN 11
    WHEN 'December' THEN 12
END;

--si se desea crear la columna del número del mes, tenemos que usar el argumento UPDATE y ALTER TABLE que modificará
--permanentemente nuestra tabla: 
ALTER TABLE hotel_bookings ADD month_number INT;
UPDATE hotel_bookings
SET month_number = CASE arrival_date_month
    WHEN 'January' THEN 1
    WHEN 'February' THEN 2
    WHEN 'March' THEN 3
    WHEN 'April' THEN 4
    WHEN 'May' THEN 5
    WHEN 'June' THEN 6
    WHEN 'July' THEN 7
    WHEN 'August' THEN 8
    WHEN 'September' THEN 9
    WHEN 'October' THEN 10
    WHEN 'November' THEN 11
    WHEN 'December' THEN 12
END;

--verificamos que la columna haya sido creada 
SELECT * FROM hotel_bookings;

--ahora, podemos organizarlo usando DESC, para que posicione de primero los meses con mayor número de booking
SELECT month_number, arrival_date_month, COUNT(*) AS booking_mes
FROM hotel_bookings
GROUP BY month_number, arrival_date_month
ORDER BY booking_mes DESC;
-- Con la consulta anterior podemos ver que el ranking de los mejores meses para los hoteles (mayor demanda)
--son agosto, julio y mayo, respectivamente, con más de 11mil reservaciones por mes.

--sin embargo, hemos sumado en su totalidad todo los registros
SELECT COUNT(*) AS total_booking
FROM hotel_bookings;
--es decir, 119390 registros

--Entonces, descartemos las reservas que fueron canceladas, que están registradas como 1 en la variable 'is_canceled'
SELECT COUNT(*)
FROM hotel_bookings
WHERE is_canceled = '1';
--nos deja un total de 44224

--si quisieramos, por ej ver el porcentaje de las reservas canceladas y las reservas no lo fueron
--podríamos usar una combinación de CASE, COUNT y SUM

	SELECT 
    COUNT(*) AS total_reservas,
    SUM(CASE WHEN is_canceled = '1' THEN 1 ELSE 0 END) AS canceladas,
    SUM(CASE WHEN is_canceled = '0' THEN 1 ELSE 0 END) AS no_canceladas,
    ROUND(100.0 * SUM(CASE WHEN is_canceled = '1' THEN 1 ELSE 0 END) / COUNT(*), 2) AS pct_canceladas,
    ROUND(100.0 * SUM(CASE WHEN is_canceled = '0' THEN 1 ELSE 0 END) / COUNT(*), 2) AS pct_no_canceladas
FROM hotel_bookings;

--con un % de cancelación de 37% vs no_canceladas de 63%
--Ahora calcular el porcentaje de cancelación por tipo de hotel: si es un city hotel o resort hotel 
	SELECT hotel, 
    COUNT(*) AS total_reservas,
    SUM(CASE WHEN is_canceled = '1' THEN 1 ELSE 0 END) AS canceladas,
    SUM(CASE WHEN is_canceled = '0' THEN 1 ELSE 0 END) AS no_canceladas,
    ROUND(100.0 * SUM(CASE WHEN is_canceled = '1' THEN 1 ELSE 0 END) / COUNT(*), 2) AS pct_canceladas,
    ROUND(100.0 * SUM(CASE WHEN is_canceled = '0' THEN 1 ELSE 0 END) / COUNT(*), 2) AS pct_no_canceladas
FROM hotel_bookings
GROUP BY hotel;
--Podemos ver, por ejemplo, que el Resort Hotel tiene un porcentaje de cancelación menor al City Hotel 

--Ahora, sería interesante ver que mes se frecuenta más con un mayor lead time, es decir, anticipación de compra
SELECT month_number, arrival_date_month, AVG(lead_time) as anticipación_promedio
FROM hotel_bookings
GROUP BY month_number, arrival_date_month 
ORDER BY AVG(lead_time) DESC;
--De lo anterior podemos concluir que, a pesar que agosto julio y mayo son los meses con mayor demanda (mayor num de booking)
--los usuarios suelen comprar con mayor anticipación para los meses septiembre, julio y junio, lo que podría ayudar a 
--generar promociones de early booking para otros periodos en especifico para estimular la demanda


--Segmentación de clientes 
SELECT DISTINCT(customer_type)
FROM hotel_bookings
--Hay 4 tipo de clientes: group, contract, transient, transient-party

-- % de participación de las reservas de acuerdo al tipo de clientes 
SELECT  
    'Transient' AS customer_type,  
    COUNT(*) AS total_reservas,  
    ROUND(100.0 * SUM(CASE WHEN customer_type = 'Transient' THEN 1 ELSE 0 END) / COUNT(*), 2) AS pct_reservas  
FROM hotel_bookings  
UNION ALL  
SELECT  
    'Group',  
    COUNT(*),  
    ROUND(100.0 * SUM(CASE WHEN customer_type = 'Group' THEN 1 ELSE 0 END) / COUNT(*), 2)  
FROM hotel_bookings  
UNION ALL  
SELECT  
    'Contract',  
    COUNT(*),  
    ROUND(100.0 * SUM(CASE WHEN customer_type = 'Contract' THEN 1 ELSE 0 END) / COUNT(*), 2)  
FROM hotel_bookings  
UNION ALL  
SELECT  
    'Transient-Party',  
    COUNT(*),  
    ROUND(100.0 * SUM(CASE WHEN customer_type = 'Transient-Party' THEN 1 ELSE 0 END) / COUNT(*), 2)  
FROM hotel_bookings
ORDER BY pct_reservas DESC;  


