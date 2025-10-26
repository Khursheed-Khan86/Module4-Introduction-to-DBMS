-- EXTRA LAB PRACTISE FOR DATABASE CONCEPTS 
-- 1. Introduction to SQL
-- Lab 3: Create a database called library_db and a table books with columns: book_id, 
-- title, author, publisher, year_of_publication, and price. Insert five records into 
-- the table. 
create database library_db;
use library_db;
create table books(book_id int primary key AUTO_INCREMENT,title varchar(50),Author varchar(50),publisher varchar(50),year_of_publication int ,price float);
drop table books;
INSERT INTO books (title, author, publisher, year_of_publication, price)
VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 'Scribner', 1925, 95),
('To Kill a Mockingbird', 'Harper Lee', 'J.B. Lippincott & Co.', 1960, 200),
('1984', 'George Orwell', 'Secker & Warburg', 1949, 100),
('Pride and Prejudice', 'Jane Austen', 'T. Egerton', 1813,99),
('The Catcher in the Rye', 'J.D. Salinger', 'Little, Brown and Company', 1951, 350);

-- Lab 4: Create a table members in library_db with columns: member_id, member_name, 
-- date_of_membership, and email. Insert five records into this table. 
create table members(member_id int primary key auto_increment,member_name varchar(100),date_of_membership date,email varchar(100) );

INSERT INTO members (member_name, date_of_membership, email)
VALUES
('Amit Sharma', '2022-05-10', 'amit.sharma@example.com'),
('Neha Patel', '2023-06-15', 'neha.patel@example.com'),
('Rohit Verma', '2024-01-20', 'rohit.verma@example.com'),
('Sneha Iyer', '2021-03-08', 'sneha.iyer@example.com'),
('Arjun Mehta', '2024-07-25', 'arjun.mehta@example.com');

-- 2. SQL Syntax 
-- Lab 3: Retrieve all members who joined the library before 2022. Use appropriate SQL syntax 
-- with WHERE and ORDER BY. 
select *from members where date_of_membership < '2022-01-01'
ORDER BY date_of_membership ASC;

-- Lab 4: Write SQL queries to display the titles of books published by a specific author. Sort the 
-- results by year_of_publication in descending order. 
use library_db;
 select title from books where publisher= 'Scribner' order by year_of_publication  desc;

-- 3. SQL Constraints
-- Lab 3: Add a CHECK constraint to ensure that the price of books in the books table is 
-- greater than 0. 

ALTER TABLE books
ADD CONSTRAINT chk_price_positive
CHECK (price > 0);
SHOW CREATE TABLE books;

 -- Lab 4: Modify the members table to add a UNIQUE constraint on the email column, 
-- ensuring that each member has a unique email address.
ALTER TABLE members
ADD CONSTRAINT unique_email
unique(email);
SHOW CREATE TABLE members;

-- 4. Main SQL Commands and Sub-commands (DDL)
-- Lab 3: Create a table authors with the following columns: author_id, first_name, 
-- last_name, and country. Set author_id as the primary key.
create table authors(author_id int primary key,first_name varchar(50),last_name varchar(50),country varchar(20));

-- Lab 4: Create a table publishers with columns: publisher_id, publisher_name, 
-- contact_number, and address. Set publisher_id as the primary key and 
-- contact_number as unique. 
create table publishers(publisher_id int primary key,publisher_name varchar(50),contact_number varchar(50) unique,address varchar(100));

-- 5. ALTER Command
-- Lab 3: Add a new column genre to the books table. Update the genre for all existing 
-- records. 
ALTER TABLE books
ADD COLUMN genre VARCHAR(50);
DESCRIBE books;
UPDATE books
SET genre = 'Fiction'
WHERE book_id = 1;

UPDATE books
SET genre = 'Science'
WHERE book_id = 2;

UPDATE books
SET genre = 'Technology'
WHERE book_id = 3;

UPDATE books
SET genre = 'History'
WHERE book_id = 4;

UPDATE books
SET genre = 'Education'
WHERE book_id = 5;
SELECT * FROM books;

-- Lab 4: Modify the members table to increase the length of the email column to 100 
-- characters.
ALTER TABLE members
MODIFY COLUMN email VARCHAR(100);

-- 6. DROP Command
-- Lab 3: Drop the publishers table from the database after verifying its structure. 
DESCRIBE publishers;
DROP TABLE publishers;
-- Lab 4: Create a backup of the members table and then drop the original members table.
CREATE TABLE members_backup AS
SELECT * FROM members;
SELECT * FROM members_backup;
DROP TABLE members;
SHOW TABLES;
CREATE TABLE members AS
SELECT * FROM members_backup;
DROP TABLE members_backup;
-- 7. Data Manipulation Language (DML)
-- Lab 4: Insert three new authors into the authors table, then update the last name of one of 
-- the authors.
INSERT INTO authors (author_id, first_name, last_name)
VALUES
(1, 'Arundhati', 'Roy'),
(2, 'Chetan', 'Bhagat'),
(3, 'Ruskin', 'Bond');
set sql_safe_updates =0;
UPDATE authors
SET last_name = 'Sharma'
WHERE first_name = 'Chetan';
-- Lab 5: Delete a book from the books table where the price is higher than $100. 
delete  from books where price>'100';
-- 8. UPDATE Command
-- Lab 3: Update the year_of_publication of a book with a specific book_id.
UPDATE books
SET year_of_publication = 2022   -- new year
WHERE book_id = 3;
-- Lab 4: Increase the price of all books published before 2015 by 10%. 
select *from books;
UPDATE books
SET price = price + (price* 0.10)
WHERE year_of_publication < 2015;
-- 9. DELETE Command 
-- Lab 3: Remove all members who joined before 2020 from the members table.
SELECT * FROM members
WHERE date_of_membership < '2022-01-01';
DELETE FROM members
WHERE date_of_membership < '2020-01-01';

-- Lab 4: Delete all books that have a NULL value in the author column. 
delete from books where author=null;
-- 10. Data Query Language (DQL)
-- Lab 4: Write a query to retrieve all books with price between $50 and $100.
select *from books where price between 100 and 120;

-- Lab 5: Retrieve the list of books sorted by author in ascending order and limit the results 
-- to the top 3 entries. 
SELECT * FROM books
ORDER BY author ASC
LIMIT 3;

-- 11. Data Control Language (DCL)
-- Lab 3: Grant SELECT permission to a user named librarian on the books table.
CREATE USER 'librarian'@'localhost' IDENTIFIED BY 'StrongPassword123';
GRANT SELECT ON library_db.books TO 'librarian'@'localhost';

-- Lab 4: Grant INSERT and UPDATE permissions to the user admin on the members table.
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'StrongPassword1234';
GRANT INSERT, UPDATE ON library_db.members TO 'admin'@'localhost';

-- 12. REVOKE Command
-- Lab 3: Revoke the INSERT privilege from the user librarian on the books table.
REVOKE INSERT ON library_db.books FROM 'librarian'@'localhost';

-- 13. Transaction Control Language (TCL)
-- Lab 3: Use COMMIT after inserting multiple records into the books table, then make another 
-- insertion and perform a ROLLBACK. 
use library_db;

INSERT INTO books (book_id, title, author, publisher, year_of_publication, price,genre)
VALUES 
(5, 'The Time Machine', 'H.G. Wells', 'Penguin', 1895, 300.00,'physics'),
(6, 'The Alchemist', 'Paulo Coelho', 'HarperCollins', 1988, 450.00,'history'),
(7, '1984', 'George Orwell', 'Secker & Warburg', 1949, 500.00,'AI');
COMMIT;
INSERT INTO books (book_id, title, author, publisher, year_of_publication, price,genre)
VALUES (8, 'Moby Dick', 'Herman Melville', 'Harper & Brothers', 1851, 400.00,'Fiction');
ROLLBACK;
select *from books;
-- Lab 4: Set a SAVEPOINT before making updates to the members table, perform some 
-- updates, and then roll back to the SAVEPOINT.
START TRANSACTION;
SELECT * FROM members;
SAVEPOINT before_updates;
UPDATE members 
SET member_name = 'Amit Sharma'
WHERE member_id = 1;
UPDATE members 
SET email = 'neha123@example.com'
WHERE member_id = 2;
SELECT * FROM members;
ROLLBACK TO SAVEPOINT before_updates;
SELECT * FROM members;
COMMIT;

-- 14. SQL Joins 
-- Lab 3: Perform an INNER JOIN between books and authors tables to display the title 
-- of books and their respective authors' names. 
SELECT 
    b.title AS Book_Title,
    CONCAT(a.first_name, ' ', a.last_name) AS Author_Name
FROM 
    books b
INNER JOIN 
    authors a
ON 
    b.author = CONCAT(a.first_name, ' ', a.last_name);

-- Lab 4: Use a FULL OUTER JOIN to retrieve all records from the books and authors tables, 
-- including those with no matching entries in the other table.
SELECT 
    b.title AS Book_Title,
    b.author AS Book_Author,
    CONCAT(a.first_name, ' ', a.last_name) AS Author_Name
FROM 
    books b
LEFT JOIN 
    authors a
ON 
    b.author = CONCAT(a.first_name, ' ', a.last_name)

UNION

SELECT 
    b.title AS Book_Title,
    b.author AS Book_Author,
    CONCAT(a.first_name, ' ', a.last_name) AS Author_Name
FROM 
    books b
RIGHT JOIN 
    authors a
ON 
    b.author = CONCAT(a.first_name, ' ', a.last_name);


-- 15. SQL Group By
-- Lab 3: Group books by genre and display the total number of books in each genre. 
SELECT 
    genre,
    COUNT(*) AS total_books
FROM 
    books
GROUP BY 
    genre;


--  Lab 4: Group members by the year they joined and find the number of members who joined 
-- each year. 
SELECT 
    YEAR(date_of_membership) AS year_joined,
    COUNT(*) AS total_members
FROM 
    members
GROUP BY 
    YEAR(date_of_membership)
ORDER BY 
    year_joined;


-- 16. SQL Stored Procedure
-- Lab 3: Write a stored procedure to retrieve all books by a particular author. 

DELIMITER $$

CREATE PROCEDURE get_books_by_author(IN author_name VARCHAR(100))
BEGIN
    SELECT 
        book_id,
        title,
        author,
        publisher,
        year_of_publication,
        price
    FROM 
        books
    WHERE 
        author = author_name;
END $$

DELIMITER ;
CALL get_books_by_author('George Orwell');
--  Lab 4: Write a stored procedure that takes book_id as an argument and returns the price 
-- of the book. 
DELIMITER $$

CREATE PROCEDURE get_book_price(IN b_id INT)
BEGIN
    SELECT 
        price
    FROM 
        books
    WHERE 
        book_id = b_id;
END $$

DELIMITER ;
CALL get_book_price(1);

-- 17. SQL View 
-- Lab 3: Create a view to show only the title, author, and price of books from the books 
table. 
CREATE VIEW books_summary AS
SELECT 
    title,
    author,
    price
FROM 
    books;
    SELECT * FROM books_summary;

-- Lab 4: Create a view to display members who joined before 2020.
CREATE VIEW members_before_2020 AS
SELECT 
    member_id,
    member_name,
    date_of_membership,
    email
FROM 
    members
WHERE 
    date_of_membership < '2020-01-01';
    SELECT * FROM members_before_2020;
    

-- 18. SQL Trigger
-- Lab 3: Create a trigger to automatically update the last_modified timestamp of the 
-- books table whenever a record is updated. 

ALTER TABLE books
ADD COLUMN last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
DELIMITER $$

CREATE TRIGGER update_books_last_modified
BEFORE UPDATE ON books
FOR EACH ROW
BEGIN
    SET NEW.last_modified = CURRENT_TIMESTAMP;
END $$

DELIMITER ;
UPDATE books
SET price = 550
WHERE book_id = 3;
select *from books;
--  Lab 4: Create a trigger that inserts a log entry into a log_changes table whenever a 
-- DELETE operation is performed on the books table.
CREATE TABLE IF NOT EXISTS log_changes (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    title VARCHAR(255),
    author VARCHAR(255),
    deleted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
DELIMITER $$

CREATE TRIGGER log_books_delete
AFTER DELETE ON books
FOR EACH ROW
BEGIN
    INSERT INTO log_changes (book_id, title, author, deleted_at)
    VALUES (OLD.book_id, OLD.title, OLD.author, CURRENT_TIMESTAMP);
END $$

DELIMITER ;
DELETE FROM books
WHERE book_id = 1;

-- 19. Introduction to PL/SQL
-- Lab 3: Write a PL/SQL block to insert a new book into the books table and display a 
-- confirmation message. 
DELIMITER $$

CREATE PROCEDURE insert_new_book()
BEGIN
    INSERT INTO books (book_id, title, author, publisher, year_of_publication, price, genre)
    VALUES (9, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Scribner', 1925, 600.00, 'abc');
    
    SELECT 'Book inserted successfully!' AS message;
END $$

DELIMITER ;

-- Call the procedure
CALL insert_new_book();

-- Lab 4: Write a PL/SQL block to display the total number of books in the books table.
DELIMITER $$

CREATE PROCEDURE display_total_books()
BEGIN
    DECLARE total INT;

    -- Get total number of books
    SELECT COUNT(*) INTO total FROM books;

    -- Display the total
    SELECT CONCAT('Total number of books: ', total) AS message;
END $$

DELIMITER ;
CALL display_total_books();

-- 20. PL/SQL Syntax 
-- Lab 3: Write a PL/SQL block to declare variables for book_id and price, assign values, and 
-- display the results. 

DELIMITER $$

CREATE PROCEDURE demo_book_variables()
BEGIN
   
    DECLARE v_book_id INT;
    DECLARE v_price DECIMAL(10,2);
  
    SET v_book_id = 101;
    SET v_price = 499.99;
   
    SELECT v_book_id AS Book_ID, v_price AS Price;
END $$

DELIMITER ;
CALL demo_book_variables();

-- Lab 4: Write a PL/SQL block using constants and perform arithmetic operations on book 
-- prices.
DELIMITER $$

CREATE PROCEDURE demo_book_price_arithmetic()
BEGIN
	DECLARE c_discount_rate DECIMAL(5,2) DEFAULT 0.10; -- 10% discount
    DECLARE c_tax_rate DECIMAL(5,2) DEFAULT 0.05;      -- 5% tax

        DECLARE v_price DECIMAL(10,2) DEFAULT 500.00;
    DECLARE v_price_after_discount DECIMAL(10,2);
    DECLARE v_final_price DECIMAL(10,2);

    -- Perform arithmetic operations
    SET v_price_after_discount = v_price - (v_price * c_discount_rate);
    SET v_final_price = v_price_after_discount + (v_price_after_discount * c_tax_rate);

    -- Display results
    SELECT 
        v_price AS Original_Price,
        v_price_after_discount AS Price_After_Discount,
        v_final_price AS Final_Price_With_Tax;
END $$

DELIMITER ;

CALL demo_book_price_arithmetic();

-- 21. PL/SQL Control Structures
-- Lab 3: Write a PL/SQL block using IF-THEN-ELSE to check if a book's price is above $100 
-- and print a message accordingly. 
DELIMITER $$

CREATE PROCEDURE check_all_book_price()
BEGIN
    -- 1️⃣ Declare variables
    DECLARE v_title VARCHAR(255);
    DECLARE v_price DECIMAL(10,2);
    DECLARE done INT DEFAULT 0;

    -- 2️⃣ Declare cursor
    DECLARE cur_books CURSOR FOR
        SELECT title, price FROM books;

    -- 3️⃣ Declare handler
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Open cursor
    OPEN cur_books;

    read_loop: LOOP
        FETCH cur_books INTO v_title, v_price;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Check price and display message
        IF v_price > 100 THEN
            SELECT CONCAT('Book "', v_title, '" has a high price: $', v_price) AS message;
        ELSE
            SELECT CONCAT('Book "', v_title, '" has a reasonable price: $', v_price) AS message;
        END IF;
    END LOOP;

    CLOSE cur_books;
END $$

DELIMITER ;
-- Call the procedure
CALL check_all_book_price();

-- Lab 4: Use a FOR LOOP in PL/SQL to display the details of all books one by one.
DELIMITER $$

CREATE PROCEDURE display_all_books()
BEGIN
    -- 1️⃣ Declare variables
    DECLARE v_book_id INT;
    DECLARE v_title VARCHAR(255);
    DECLARE v_author VARCHAR(255);
    DECLARE v_publisher VARCHAR(255);
    DECLARE v_year INT;
    DECLARE v_price DECIMAL(10,2);
    DECLARE done INT DEFAULT 0;

    -- 2️⃣ Declare cursor
    DECLARE cur_books CURSOR FOR
        SELECT book_id, title, author, publisher, year_of_publication, price FROM books;

    -- 3️⃣ Declare handler
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- 4️⃣ Open cursor
    OPEN cur_books;

    -- 5️⃣ Loop through the cursor
    read_loop: LOOP
        FETCH cur_books INTO v_book_id, v_title, v_author, v_publisher, v_year, v_price;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Display book details
        SELECT v_book_id AS Book_ID, v_title AS Title, v_author AS Author, 
               v_publisher AS Publisher, v_year AS Year_of_Publication, v_price AS Price;
    END LOOP;

    -- 6️⃣ Close cursor
    CLOSE cur_books;
END $$

DELIMITER ;
CALL display_all_books();

-- 22. SQL Cursors
-- Lab 3: Write a PL/SQL block using an explicit cursor to fetch and display all records from the 
-- members table. 
DELIMITER $$

CREATE PROCEDURE display_all_members()
BEGIN
    -- 1️⃣ Declare variables for member columns
    DECLARE v_member_id INT;
    DECLARE v_member_name VARCHAR(255);
    DECLARE v_date_of_membership DATE;
    DECLARE v_email VARCHAR(255);
    DECLARE done INT DEFAULT 0;

    -- 2️⃣ Declare cursor for selecting all members
    DECLARE cur_members CURSOR FOR
        SELECT member_id, member_name, date_of_membership, email FROM members;

    -- 3️⃣ Declare handler for end of cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- 4️⃣ Open the cursor
    OPEN cur_members;

    -- 5️⃣ Loop through cursor
    read_loop: LOOP
        FETCH cur_members INTO v_member_id, v_member_name, v_date_of_membership, v_email;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Display each member's details
        SELECT v_member_id AS Member_ID, 
               v_member_name AS Member_Name, 
               v_date_of_membership AS Date_of_Membership, 
               v_email AS Email;
    END LOOP;

    -- 6️⃣ Close cursor
    CLOSE cur_members;
END $$

DELIMITER ;

CALL display_all_members();
-- 23. Rollback and Commit Savepoint
-- Lab 3: Perform a transaction that includes inserting a new member, setting a SAVEPOINT, 
-- and rolling back to the savepoint after making updates.
set sql_safe_updates=0;
START TRANSACTION;

-- 2️ Insert a new member
INSERT INTO members (member_id, member_name, date_of_membership, email)
VALUES (10, 'Kiran Patel', '2025-10-19', 'kiran@example.com');

-- 3️ Create a SAVEPOINT
SAVEPOINT before_update;

-- 4️ Perform some updates after the savepoint
UPDATE members
SET email = 'kiran_updated@example.com'
WHERE member_id = 10;

UPDATE members
SET member_name = 'Kiran P.'
WHERE member_id = 10;

-- 5️ Check current state (optional)
SELECT * FROM members WHERE member_id = 10;

-- 6️ Rollback to the SAVEPOINT
ROLLBACK TO SAVEPOINT before_update;

-- 7️ Verify rollback (optional)
SELECT * FROM members WHERE member_id = 10;

-- 8 Commit the transaction
COMMIT;
-- Lab 4: Use COMMIT after successfully inserting multiple books into the books table, then use 
-- ROLLBACK to undo a set of changes made after a savepoint.
 
START TRANSACTION;
-- 2️ Insert multiple books
INSERT INTO books (book_id, title, author, publisher, year_of_publication, price, genre)
VALUES 
(10, 'Book One', 'Author A', 'Publisher X', 2020, 300.00, 'Fiction'),
(11, 'Book Two', 'Author B', 'Publisher Y', 2021, 450.00, 'Mystery'),
(12, 'Book Three', 'Author C', 'Publisher Z', 2022, 500.00, 'Science');
-- 3️ Commit the inserted books
COMMIT;
-- 4️ Start another transaction for further changes
START TRANSACTION;
-- 5️ Insert additional books
INSERT INTO books (book_id, title, author, publisher, year_of_publication, price, genre)
VALUES 
(13, 'Book Four', 'Author D', 'Publisher X', 2023, 600.00, 'Fiction'),
(14, 'Book Five', 'Author E', 'Publisher Y', 2024, 700.00, 'Mystery');
-- 6️ Create a SAVEPOINT before making updates
SAVEPOINT before_updates;
-- 7️ Make some updates after the savepoint
UPDATE books
SET price = price + 50
WHERE book_id IN (13, 14);
-- 8️ Decide to undo updates but keep inserted rows
ROLLBACK TO SAVEPOINT before_updates;
-- 9️ Commit the transaction (inserts remain, updates undone)
COMMIT;
SELECT * FROM books WHERE book_id BETWEEN 9 AND 14;