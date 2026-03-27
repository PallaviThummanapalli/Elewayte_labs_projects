CREATE DATABASE library_db;
USE library_db;

CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(50)
);

CREATE TABLE members (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(50)
);

CREATE TABLE loans (
    loan_id INT PRIMARY KEY,
    book_id INT,
    member_id INT,
    issue_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

INSERT INTO books VALUES
(1, 'SQL Basics', 'John'),
(2, 'Database Design', 'Smith'),
(3, 'Learning SQL', 'David');

INSERT INTO members VALUES
(101, 'Pallavi'),
(102, 'Ajay'),
(103, 'Priya');

INSERT INTO loans VALUES
(1, 1, 101, '2024-03-01', '2024-03-10'),
(2, 2, 102, '2024-03-05', NULL),
(3, 3, 103, '2024-03-07', NULL);

SELECT m.member_name, b.title, l.issue_date, l.return_date
FROM loans l
JOIN members m ON l.member_id = m.member_id
JOIN books b ON l.book_id = b.book_id;

SELECT * FROM loans
WHERE return_date IS NULL;
