SELECT * FROM employee_salary
SELECT * FROM employee_demographics
SELECT * FROM parks_departments

SELECT * 
FROM employee_demographics
INNER JOIN employee_salary
ON employee_demographics.employee_id= employee_salary.employee_id


SELECT * 
FROM employee_demographics
INNER JOIN employee_salary
ON employee_demographics.employee_id= employee_salary.employee_id
 
 --In a JOIN query, the left and right tables are determined by their position in the SQL statement:
--The LEFT table is the one that appears before the JOIN keyword.
--The RIGHT table is the one that appears after the JOIN keyword.

--join multiple tables at once

SELECT * 
FROM employee_demographics dem
INNER JOIN employee_salary sal
ON dem.employee_id= sal.employee_id
INNER JOIN parks_departments pd 
ON sal.dept_id=pd.department_id
