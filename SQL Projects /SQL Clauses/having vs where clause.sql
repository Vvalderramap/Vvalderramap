SELECT * FROM employee_salary
SELECT * FROM employee_demographics
SELECT * FROM parks_departments


--Se está haciendo una consulta de agrupación (group by) + having 
SELECT occupation, AVG(salary) as 'Salario promedio'
FROM employee_salary
WHERE occupation LIKE '%manager'
GROUP BY occupation	
HAVING AVG(salary)>75000
-- usando el having se está 'restringiendo' delimitando los registros que se usaran para la consulta

