SQL BASICS --> PostgreSQL

creating the table->

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(50),
    salary NUMERIC,
    created_at TIMESTAMP DEFAULT NOW()
);
------------------------------------------------------------------
inserting ->

INSERT INTO employees (name, role, salary)  --inserting a row
VALUES ('Nithi', 'Developer', 60000);  

INSERT INTO employees (name, role, salary)  --Insert with multiple rows
VALUES 
('ram', 'Tester', 45000),
('Meera', 'Manager', 80000);

INSERT INTO employees (name, salary)  --Insert with returning
VALUES ('Ajay ganesh', 55000)
RETURNING id;  --after inserting gives the newly generated id

------------------------------------------------------------------
READ (SELECT)  -->

SELECT * FROM employees;

--Select columns

SELECT name, salary FROM employees;

--Filter rows

SELECT * FROM employees WHERE salary > 50000;

--Sorting

SELECT * FROM employees ORDER BY salary DESC;

--Limit results

SELECT * FROM employees LIMIT 5;

--Count rows

SELECT COUNT(*) FROM employees;

--LIKE search

SELECT * FROM employees WHERE name LIKE 'N%';

------------------------------------------------------------------
UPDATE (MODIFY DATA)  -->

--Update a single row

UPDATE employees
SET salary = 65000
WHERE id = 1;

--Update multiple columns

UPDATE employees
SET name = 'Nithi Kumar', role = 'Senior Dev'
WHERE id = 1;

--Update all rows (careful)

UPDATE employees
SET salary = salary + 5000;

--Update and return updated row

UPDATE employees
SET role = 'Lead'
WHERE id = 3
RETURNING *;

------------------------------------------------------------------

DELETE (REMOVE DATA)  -->

--Delete a row

DELETE FROM employees WHERE id = 1;

--Delete multiple rows

DELETE FROM employees WHERE salary < 40000;

--Delete all rows

DELETE FROM employees;

--Delete and return deleted rows

DELETE FROM employees
WHERE role = 'Tester'
RETURNING *;

------------------------------------------------------------------

TABLE MANAGEMENT -->

-- Show table structure in postgres shell

\d employees

--Drop table

DROP TABLE employees;

--Drop only data but keep structure

TRUNCATE TABLE employees;

--Add a column email?

ALTER TABLE employees ADD COLUMN email VARCHAR(100);

--Modify column data type?

ALTER TABLE employees ALTER COLUMN salary TYPE INT;

--Rename column

ALTER TABLE employees RENAME COLUMN role TO job_role;

------------------------------------------------------------------


CONSTRAINT COMMANDS for crud practice -->  these constraint queries only runs if without violations^

--Adding NOT NULL

ALTER TABLE employees ALTER COLUMN salary SET NOT NULL;

--Adding UNIQUE

ALTER TABLE employees ADD CONSTRAINT unique_email UNIQUE (email);

--Add CHECK

ALTER TABLE employees ADD CONSTRAINT check_salary CHECK (salary > 0);

------------------------------------------------------------------
TRANSACTION COMMANDS

BEGIN;
UPDATE employees SET salary = salary + 5000 WHERE id = 2;
DELETE FROM employees WHERE id = 3;

COMMIT;

--Rollback  --before commiting
ROLLBACK;

------------------------------------------------------------------
