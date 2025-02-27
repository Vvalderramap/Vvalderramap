SELECT * FROM employee_salary
SELECT * FROM employee_demographics
SELECT * FROM parks_departments


SELECT *
FROM employee_demographics

--Limit is used to delimited the number of registers we'd like to be displayed

SELECT *
FROM employee_demographics
ORDER by age DESC
LIMIT 3

--It looks like Sql microsoft doesn't support limit, so we're gonna use 'top' instead

SELECT TOP 3 *
FROM employee_demographics
ORDER BY age DESC;

--aliasing 
SELECT gender, AVG(age)  avg_age
FROM employee_demographics
GROUP BY gender
HAVING AVG(age)>40

