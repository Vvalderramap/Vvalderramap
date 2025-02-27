--tables: 
SELECT * FROM employee_demographics
SELECT * FROM employee_salary
SELECT * FROM parks_departments

--UNION clause 
-- by default, when using 'UNION', it uses UNION DISTINCT by default. which means only distinct value (between tables) will be displayed
SELECT first_name, last_name
FROM employee_demographics
UNION  
SELECT first_name, last_name
FROM employee_salary

-- if we use 'UNION ALL' it will bring everything from each table (potential duplicates)
SELECT first_name, last_name
FROM employee_demographics
UNION ALL
SELECT first_name, last_name
FROM employee_salary

-- USE CASE
SELECT first_name, last_name
FROM employee_demographics
UNION ALL
SELECT first_name, last_name
FROM employee_salary

SELECT first_name, last_name, 'old man' as LABEL
FROM employee_demographics
WHERE age >40 and gender='Male'
UNION 
SELECT first_name, last_name, 'old lady' as LABEL
FROM employee_demographics
WHERE age >40 and gender='Female'
UNION
SELECT first_name, last_name, 'highly paid employee' as LABEL
FROM employee_salary
WHERE salary >70000
