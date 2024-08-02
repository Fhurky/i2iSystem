// Answer 1
SELECT 
    e.employee_id,
    e.first_name,
    d.department_name
FROM 
    HR.EMPLOYEES e
INNER JOIN 
    HR.DEPARTMENTS d
ON 
    e.department_id = d.department_id;



// Answer 2
SELECT 
    EMP.employee_id,
    MAN.employee_id AS manager_id
FROM 
    HR.EMPLOYEES EMP
JOIN 
    HR.EMPLOYEES MAN 
ON 
    EMP.manager_id = MAN.employee_id;



// Answer 3
SELECT 
    SUBSTR(phone_number, 1, 3) AS Operator,
    COUNT(*) AS Total
FROM 
    HR.EMPLOYEES
GROUP BY 
    SUBSTR(phone_number, 1, 3);

     
//Answer 4    
CREATE TABLE HR.emp (
  employee_id NUMBER(10),
  first_name VARCHAR2(25),
  last_name VARCHAR2(25),
  email VARCHAR2(25),
  phone_number VARCHAR2(25),
  hire_date DATE,
  job_id VARCHAR2(10),
  salary NUMBER(10,2),
  commision_pct NUMBER(3,2),
  manager_id NUMBER(10),
  department_id NUMBER(10)
);
 
    
INSERT INTO HR.emp (
  employee_id,
  first_name,
  last_name,
  email,
  phone_number,
  hire_date,
  job_id,
  salary,
  commision_pct,
  manager_id,
  department_id
) VALUES (
  9999,               
  'John',             
  'Doe',              
  'john.doe@example.com',
  '123-456-7890',    
  SYSDATE,           
  'IT_PROG',         
  5000,              
  0.10,              
  101,             
  20               
);

UPDATE HR.emp
SET 
  phone_number = '987-654-3210',  
  salary = 5500                  
WHERE 
  employee_id = 9999;           

DELETE FROM HR.emp
WHERE employee_id = 9999;        


//Answer 5  

SELECT 
    INITCAP(SUBSTR(first_name, 1, 1) || RPAD('*', LENGTH(first_name) - 1, '*')),
    INITCAP(SUBSTR(last_name, 1, 1) || RPAD('*', LENGTH(last_name) - 1, '*')) 
FROM 
    HR.EMPLOYEES;
