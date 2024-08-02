Answer1:

SELECT 
    department_id,
    LISTAGG(first_name || ' ' || last_name, '; ') WITHIN GROUP (ORDER BY first_name, last_name) AS employees
FROM 
    employees
GROUP BY 
    department_id;


Answer2:

SELECT 
    e1.employee_id,
    e1.job_id,
    e1.hiredate,
    e1.salary AS current_salary,
    NVL(LAG(e1.salary, 1) OVER (PARTITION BY e1.job_id ORDER BY e1.hiredate), 0) AS preceding_salary,
    NVL(LEAD(e1.salary, 1) OVER (PARTITION BY e1.job_id ORDER BY e1.hiredate), 0) AS following_salary,
    (NVL(LAG(e1.salary, 1) OVER (PARTITION BY e1.job_id ORDER BY e1.hiredate), 0) +
     NVL(LEAD(e1.salary, 1) OVER (PARTITION BY e1.job_id ORDER BY e1.hiredate), 0)) AS total_preceding_following_salary
FROM 
    employees e1
ORDER BY 
    e1.job_id, e1.hiredate;


Answer3:

WITH RankedSalaries AS (
    SELECT 
        employee_id,
        department_id,
        salary,
        ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rn
    FROM 
        employees
)
SELECT 
    employee_id,
    department_id,
    salary
FROM 
    RankedSalaries
WHERE 
    rn > 1  -- Exclude the highest salaried employee (rn = 1)
ORDER BY 
    department_id,
    salary DESC;


Answer4:

WITH HireOrder AS (
    SELECT 
        employee_id,
        first_name,
        last_name,
        hiredate,
        EXTRACT(YEAR FROM hiredate) AS hire_year,
        ROW_NUMBER() OVER (ORDER BY EXTRACT(YEAR FROM hiredate), hiredate) AS hire_order
    FROM 
        employees
)
SELECT 
    employee_id,
    first_name,
    last_name,
    hiredate,
    hire_year,
    hire_order
FROM 
    HireOrder
ORDER BY 
    hire_year, hire_order;


Answer5:

WITH EmployeeSalaries AS (
    SELECT 
        employee_id,
        first_name,
        last_name,
        salary,
        hiredate,
        LAG(salary) OVER (ORDER BY hiredate) AS prev_salary,
        LEAD(salary) OVER (ORDER BY hiredate) AS next_salary
    FROM 
        employees
)
SELECT 
    employee_id,
    first_name,
    last_name,
    salary,
    prev_salary,
    next_salary
FROM 
    EmployeeSalaries
ORDER BY 
    hiredate;
