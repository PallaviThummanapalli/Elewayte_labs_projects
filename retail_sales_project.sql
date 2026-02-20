CREATE DATABASE retail_sales_db;
USE retail_sales_db;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    email VARCHAR(100),
    city VARCHAR(50),
    created_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price INT
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers VALUES
(1, 'Pallavi', 'pallavi@gmail.com', 'Hyderabad', '2023-01-10'),
(2, 'Ajay', 'ajay@gmail.com', 'Bangalore', '2023-02-12'),
(3, 'Priya', 'priya@gmail.com', 'Chennai', '2023-03-05'),
(4, 'Ramu', 'ramu@gmail.com', 'Delhi', '2023-04-01'),
(5, 'Sitaraa', 'sitaraa@gmail.com', 'Mumbai', '2023-05-20');

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 60000),
(102, 'Mobile', 'Electronics', 30000),
(103, 'Headphones', 'Accessories', 3000),
(104, 'Keyboard', 'Accessories', 1500);

INSERT INTO orders VALUES
(1001, 1, 101, 1, '2024-01-05'),
(1002, 1, 103, 2, '2024-01-15'),
(1003, 2, 102, 1, '2024-02-10'),
(1004, 3, 104, 3, '2024-02-18'),
(1005, 3, 101, 1, '2024-03-02'),
(1006, 4, 103, 5, '2024-03-12'),
(1007, 2, 101, 1, '2024-03-25');

SELECT 
    p.product_name,
    SUM(o.quantity) AS total_units_sold
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_units_sold DESC;

SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    SUM(o.quantity * p.price) AS monthly_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month;

SELECT c.customer_id, c.customer_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

SELECT 
    c.customer_id,
    c.customer_name,
    SUM(o.quantity * p.price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
HAVING total_spent > 50000
ORDER BY total_spent DESC;

SELECT 
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.quantity * p.price) AS lifetime_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.customer_name;
