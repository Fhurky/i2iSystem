Answer1:----------------------------------------------------

ALTER TABLE employees
ADD COLUMN MAX_SALARY DECIMAL(10, 2);

UPDATE employees
SET MAX_SALARY = (SELECT MAX(salary) FROM employees);

DELETE FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);


Answer2:--------------------------------------------------

CREATE INDEX DPR_NAME_IDX
ON DEPARTMENTS (DEPARTMENT_NAME);

ALTER TABLE employees
ADD CONSTRAINT CNSTR_SALARY
CHECK (salary BETWEEN 1000 AND 100000);

DROP INDEX DPR_NAME_IDX;

ALTER TABLE employees
ENABLE CONSTRAINT CNSTR_SALARY;

ALTER TABLE employees
DISABLE CONSTRAINT CNSTR_SALARY;

ALTER TABLE employees
DROP CONSTRAINT CNSTR_SALARY;


Answer3:--------------------------------------------------

CREATE TABLE distinct_departments AS
SELECT DISTINCT department_id
FROM EMPLOYEES;

MERGE INTO distinct_departments dd
USING DEPARTMENTS d
ON (dd.department_id = d.department_id)
WHEN MATCHED THEN
    UPDATE SET dd.department_name = d.department_name
WHEN NOT MATCHED THEN
    INSERT (department_id, department_name)
    VALUES (d.department_id, d.department_name);


Answer4:----------------------------------------------------

SELECT 
    e.first_name,
    e.last_name,
    e.job_id,
    e.department_id,
    d.department_name,
    j.job_title,
    j.min_salary,
    j.max_salary,
    CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM 
    EMPLOYEES e
JOIN 
    DEPARTMENTS d ON e.department_id = d.department_id
JOIN 
    JOBS j ON e.job_id = j.job_id
WHERE 
    e.job_id LIKE 'S%';


Answer5.1:----------------------------------------------------

BEGIN TRANSACTION;

UPDATE employees
SET salary = salary * 1.1
WHERE department_id = 10;

INSERT INTO log (event, description)
VALUES ('Salary Update', 'Increased salary by 10% for department 10');

COMMIT;

Answer5.2---------------------------------------------------------

BEGIN TRANSACTION;

UPDATE employees
SET salary = salary * 1.1
WHERE department_id = 10;

-- Suppose there is an error in the next operation
ROLLBACK;

