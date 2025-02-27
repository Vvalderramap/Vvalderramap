SELECT * FROM employee_salary
SELECT * FROM employee_demographics
SELECT * FROM parks_departments


--Se est� haciendo una consulta de agrupaci�n (group by) + having 
SELECT occupation, AVG(salary) as 'Salario promedio'
FROM employee_salary
WHERE occupation LIKE '%manager'
GROUP BY occupation	
HAVING AVG(salary)>75000
-- usando el having se est� 'restringiendo' delimitando los registros que se usaran para la consulta

