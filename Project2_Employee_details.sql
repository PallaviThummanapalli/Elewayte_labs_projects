CREATE DATABASE employee_db;
USE employee_db;

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    joining_date DATE,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE attendance (
    att_id INT PRIMARY KEY,
    emp_id INT,
    att_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

INSERT INTO departments VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Sales');

INSERT INTO employees VALUES
(101, 'Pallavi', 2, '2023-01-10'),
(102, 'Ajay', 1, '2023-02-15'),
(103, 'Priya', 3, '2023-03-20');

INSERT INTO attendance VALUES
(1, 101, '2024-03-01', 'Present'),
(2, 101, '2024-03-02', 'Absent'),
(3, 102, '2024-03-01', 'Present'),
(4, 103, '2024-03-01', 'Late');

SELECT e.emp_name, d.dept_name, a.att_date, a.status
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
JOIN attendance a ON e.emp_id = a.emp_id;

SELECT emp_id, COUNT(*) AS total_present
FROM attendance
WHERE status = 'Present'
GROUP BY emp_id;
