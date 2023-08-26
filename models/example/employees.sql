WITH e AS (
  SELECT
    employee_id,
    first_name,
    last_name,
    email,
    phone_number,
    hire_date,
    department_id,
    salary
  FROM  
    `satu-data-staging-dev.superstore.employees`
    --{{ source('superstore','employees')}}
),
d AS (
  SELECT
  department_id,
  department_name
  FROM 
    `satu-data-staging-dev.dbt_project.departments`
    --{{ source('superstore','departments')}}
)

SELECT
  e.employee_id,
  CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
  e.email,
  e.phone_number,
  e.hire_date,
  d.department_name,
  e.salary
FROM
  e
LEFT JOIN d ON e.department_id = d.department_id
WHERE e.phone_number IS NOT NULL