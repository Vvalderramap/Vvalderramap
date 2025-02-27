-- GROUP BY 

SELECT * FROM employee_demographics
SELECT * FROM employee_salary

--GROUP BY para saber el promedio de edad por genero
SELECT gender, AVG(age) AS 'promedio de edad', MAX(age)
FROM employee_demographics
GROUP BY gender;

--GROUP BY para saber el promedio salarial por genero (inner join)
SELECT employee_demographics.gender, AVG(employee_salary.salary) AS 'salario promedio' 
FROM employee_demographics
INNER JOIN employee_salary ON employee_demographics.employee_id= employee_salary.employee_id
GROUP BY gender

---GROUP BY para determinar el promedio salarial por ocupación 
SELECT occupation, AVG(salary) AS 'Promedio salarial', MAX(age)
FROM employee_salary
GROUP BY occupation;
 