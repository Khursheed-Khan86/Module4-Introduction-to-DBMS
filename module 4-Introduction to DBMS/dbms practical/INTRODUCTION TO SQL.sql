                -- Introduction to SQL
-- • Lab 1: Create a new database named school_db and a table called students with the 
-- following columns: student_id, student_name, age, class, and address.

CREATE DATABASE SCHOOL_DB;
USE SCHOOL_DB;
CREATE TABLE STUDENTS(STUDENT_ID INT PRIMARY KEY,STUDENT_NAME VARCHAR(50),AGE INT,CLASS VARCHAR(20),ADDRESS VARCHAR(50));


-- Lab 2: Insert five records into the students table and retrieve all records using the SELECT 
-- statement. 
INSERT INTO STUDENTS(STUDENT_ID,STUDENT_NAME,AGE,CLASS,ADDRESS) 
VALUES(1001,"AMIT",15,12,"MIG"),(1002,"SUMIT",16,12,"MG ROAD"),
(1003,"RAJ",15,12,"VIJAY MARG"),(1004,"KARAN",17,11,"VARACHA"),
(1005,"ARJUN",16,11,"PIPLOD");
SELECT * FROM STUDENTS;

                              -- 2. SQL Syntax 
 -- • Lab 1: Write SQL queries to retrieve specific columns (student_name and age) from the 
-- students table.                              
SELECT STUDENT_NAME,AGE FROM STUDENTS;

-- Lab 2: Write SQL queries to retrieve all students whose age is greater than 10.
SELECT *FROM STUDENTS WHERE AGE>10;
                             
                             -- 3. SQL Constraints 
-- Lab 1: Create a table teachers with the following columns: teacher_id (Primary Key), 
-- teacher_name (NOT NULL), subject (NOT NULL), and email (UNIQUE). 
USE SCHOOL_DB;
CREATE TABLE TEACHERS
(TEACHER_ID INT PRIMARY KEY,TEACHER_NAME VARCHAR(50) NOT NULL,SUBJECT VARCHAR(20) NOT NULL,EMAIL VARCHAR(60) UNIQUE);

-- Lab 2: Implement a FOREIGN KEY constraint to relate the teacher_id from the 
-- teachers table with the students table. 
CREATE TABLE STUDENTS(STUDENT_ID INT PRIMARY KEY,STUDENT_NAME VARCHAR(50),AGE INT,CLASS VARCHAR(20),ADDRESS VARCHAR(50),
TEACHER_ID INT ,FOREIGN KEY
 (TEACHER_ID) REFERENCES TEACHERS(TEACHER_ID) ON UPDATE CASCADE ON DELETE CASCADE);
 
                          -- MAIN SQL COMMANDS ANS SUB-COMMANDS(DDL)
 -- LAB1:CREATE A TABLE COURSES WITH COLUMS : COURSE_ID,COURSE_NAME AND COURSE_CREDITS.SET THE COURSE_ID AS THE PRIMARY KEY.
 CREATE TABLE COURSES(COURSE_ID INT PRIMARY KEY,COURSE_NAME VARCHAR(50),COURSE_CREDITS VARCHAR(20));
 
 -- Lab 2: Use the CREATE command to create a database university_db.
 CREATE DATABASE UNIVERSITY_DB;
 
                                 -- 5. ALTER Command
 -- Lab 1: Modify the courses table by adding a column course_duration using the ALTER COMMAND
 -- select *FROM COURSES;
 ALTER TABLE courses
ADD COLUMN course_duration VARCHAR(50);
-- Lab 2: Drop the course_credits column from the courses table. 
ALTER TABLE courses
DROP COLUMN course_credits; 


                            -- 6. DROP Command
-- • Lab 1: Drop the teachers table from the school_db database.
-- Lab 2: Drop the students table from the school_db database and verify that the table has been removed. 
DROP TABLE STUDENTS;
DROP TABLE TEACHERS;
SHOW TABLES;


                        -- 7. Data Manipulation Language (DML)
-- Lab 1: Insert three records into the courses table using the INSERT command. 
INSERT INTO COURSES(COURSE_ID ,COURSE_NAME ,COURSE_DURATION) 
VALUES (1001,"C PROGRAMMING","2 MONTHS"),(1002,"C++ PROGRAMMING","3 MONTHS"),(1003,"JAVA","6 MONTHS");

-- • Lab 2: Update the course duration of a specific course using the UPDATE command.
SET SQL_SAFE_UPDATES=0;
UPDATE COURSES SET COURSE_DURATION ="4 MONTHS" WHERE COURSE_NAME="C++ PROGRAMMING"; 


-- • Lab 3: Delete a course with a specific course_id from the courses table using the DELETE command
DELETE FROM COURSES WHERE COURSE_ID=1003;

                                 -- 8. Data Query Language (DQL)
-- • Lab 1: Retrieve all courses from the courses table using the SELECT statement.
 SELECT *FROM COURSES;
 
-- • Lab 2: Sort the courses based on course_duration in descending order using ORDER BY. 
SELECT *FROM COURSES ORDER BY COURSE_DURATION DESC;

-- • Lab 3: Limit the results of the SELECT query to show only the top two courses using LIMIT. 
SELECT *FROM COURSES ORDER BY COURSE_DURATION DESC LIMIT 2;

                            -- 9. Data Control Language (DCL)
-- • Lab 1: Create two new users user1 and user2 and grant user1 permission to SELECT 
-- from the courses table. 
-- • Lab 2: Revoke the INSERT permission from user1 and give it to user2.
CREATE USER 'user1'@'localhost' IDENTIFIED BY 'password123';
CREATE USER 'user2'@'localhost' IDENTIFIED BY 'password456';
GRANT SELECT ON school_db.courses TO 'user1'@'localhost';
-- GRANT INSERT ON school_db.courses TO 'user1'@'localhost';
REVOKE INSERT ON school_db.courses FROM 'user1'@'localhost';
GRANT INSERT ON school_db.courses TO 'user2'@'localhost';


                         -- 10. Transaction Control Language (TCL) 
-- • Lab 1: Insert a few rows into the courses table and use COMMIT to save the changes. 
INSERT INTO COURSES(COURSE_ID ,COURSE_NAME ,COURSE_DURATION) 
VALUES(1003,"JAVA","6 MONTHS"),(1004,"PYTHON","4 MONTHS"),(1005,"PHP","6 MONTHS");
COMMIT;

-- • Lab 2: Insert additional rows, then use ROLLBACK to undo the last insert operation. 
INSERT INTO COURSES(COURSE_ID ,COURSE_NAME ,COURSE_DURATION) 
VALUES(1006,"SE","2 MONTHS"),(1007,"HTML","1 MONTHS");
ROLLBACK;

-- • Lab 3: Create a SAVEPOINT before updating the courses table, and use it to roll back 
-- specific changes. 
START TRANSACTION;
SAVEPOINT BEFORE_UPDATE; 
UPDATE COURSES SET COURSE_DURATION="10 MONTHS" WHERE COURSE_ID=1004;
ROLLBACK TO before_update;

                                   -- 11. SQL Joins
-- Lab 1: Create two tables: departments and employees. Perform an INNER JOIN to 
-- display employees along with their respective departments.
create database join1;
use join1; 
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
-- insert into tables
INSERT INTO departments (dept_id, dept_name)
VALUES 
(1, 'HR'),
(2, 'Finance'),
(3, 'IT'),
 (4,'Marketing');
INSERT INTO employees (emp_id, emp_name, dept_id)
VALUES
(101, 'Alice', 1),
(102, 'Bob', 2),
(103, 'Charlie', 3),
(104, 'David', 2);


-- inner join query
SELECT 
    employees.emp_id,
    employees.emp_name,
    departments.dept_name
FROM 
    employees
INNER JOIN 
    departments
ON 
    employees.dept_id = departments.dept_id;
    
     -- Lab2:Use a LEFT JOIN to show all departments, even those without employees. 
     SELECT 
    departments.dept_id,
    departments.dept_name,
    employees.emp_id,
    employees.emp_name
FROM 
    departments
LEFT JOIN 
    employees
ON 
    departments.dept_id = employees.dept_id;
    
    -- 12. SQL Group By 
   --  Lab 1: Group employees by department and count the number of employees in each 
-- department using GROUP BY. 

     SELECT 
    dept_id,
    COUNT(emp_id) AS total_employees
FROM 
    employees
GROUP BY 
    dept_id;
    
   -- Lab2: Use the AVG aggregate function to find the average salary of employees in each 
-- department
alter table employees
add column salary varchar(50);
set sql_safe_updates=0;
UPDATE employees 
SET salary = CASE emp_id
    WHEN 101 THEN 50000
    WHEN 102 THEN 60000
    WHEN 103 THEN 55000
    WHEN 104 THEN 65000
END;
-- select *from employees;
SELECT 
    dept_id,
    AVG(salary) AS avg_salary
FROM 
    employees
GROUP BY 
    dept_id;
    
    -- 13. SQL Stored Procedure
   --  Lab 1: Write a stored procedure to retrieve all employees from the employees table based 
-- on department. 
 DELIMITER //
CREATE PROCEDURE EMP_BY_DEPT(IN DEPT INT)
  BEGIN
       SELECT * FROM EMPLOYEES 
         WHERE DEPT_ID=DEPT;
 END //
 DELIMITER ;
  CALL EMP_BY_DEPT(2);
  
  -- Lab 2: Write a stored procedure that accepts course_id as input and returns the course 
-- details. 
USE SCHOOL_DB;
 DELIMITER //
  CREATE PROCEDURE COURSEDETAILS(IN C INT)
   BEGIN
     SELECT * FROM COURSES
      WHERE COURSE_ID=C;
      END //
      DELIMITER ;
      CALL COURSEDETAILS(1006);
  
                            -- 14. SQL View
 -- Lab 1: Create a view to show all employees along with their department names.  
  USE JOIN1;
 CREATE VIEW employee_department_view AS
SELECT 
    e.emp_id,
    e.emp_name,
    e.salary,
    d.dept_name
FROM 
    employees e
INNER JOIN 
    departments d
ON 
    e.dept_id = d.dept_id;
SELECT * FROM employee_department_view;
  -- LAB2: Modify the view to exclude employees whose salaries are below $50,000.
 UPDATE employees 
SET salary =45000
WHERE EMP_ID=102;
SELECT *FROM EMPLOYEES;

CREATE OR REPLACE VIEW employee_department_view AS
SELECT 
    e.emp_id,
    e.emp_name,
    e.salary,
    d.dept_name
FROM 
    employees e
INNER JOIN 
    departments d
ON 
    e.dept_id = d.dept_id
WHERE 
    e.salary >= 50000;
  SELECT * FROM employee_department_view;  
  
                               -- 15. SQL Triggers 
  -- Lab 1: Create a trigger to automatically log changes to the employees table when a new 
-- employee is added. 
use join1;
CREATE TABLE employee_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    action_type VARCHAR(50),
    action_time DATETIME,
    description TEXT
);
DELIMITER $$

CREATE TRIGGER after_employee_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_logs (employee_id, action_type, action_time, description)
    VALUES (
        NEW.emp_id,
        'INSERT',
        NOW(),
        CONCAT('New employee added: ', NEW.emp_name, ' (Dept: ', NEW.dept_id, ')')
    );
END$$
select *from employees;
select * from departments;
insert into departments(dept_id,dept_name) values(5,'CS');
INSERT INTO employees (emp_id, emp_name, dept_id, salary)
VALUES (105, 'John Doe', 5, 60000);
SELECT * FROM employee_logs;

-- Lab 2: Create a trigger to update the last_modified timestamp whenever an employee 
-- record is updated. 
ALTER TABLE employees
ADD COLUMN last_modified DATETIME;


UPDATE employees
SET salary = 70000
WHERE emp_id = 101;

SELECT emp_id, emp_name, salary, last_modified
FROM employees
WHERE emp_id = 101;

-- 16. Introduction to PL/SQL 
-- Lab 1: Write a PL/SQL block to print the total number of employees from the employees 
-- table. 

DELIMITER $$

CREATE PROCEDURE get_total_employees()
BEGIN
    DECLARE total_employees INT;

    SELECT COUNT(*) INTO total_employees FROM employees;

    SELECT CONCAT('Total number of employees: ', total_employees) AS message;
END$$

DELIMITER ;
CALL get_total_employees();

-- Lab 2: Create a PL/SQL block that calculates the total sales from an orders table. 
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    order_date DATE,
    amount DECIMAL(10,2)
);
INSERT INTO orders (order_id, customer_name, order_date, amount)
VALUES 
(1, 'Alice',   '2025-10-01', 1200.50),
(2, 'Bob',     '2025-10-03',  850.75),
(3, 'Charlie', '2025-10-05', 1525.00),
(4, 'David',   '2025-10-07',  995.25);
DELIMITER $$

CREATE PROCEDURE total_sales()
BEGIN
    DECLARE total DECIMAL(10,2);

    SELECT SUM(amount) INTO total FROM orders;

    SELECT CONCAT('Total Sales from Orders Table: ', total) AS message;
END$$

DELIMITER ;
CALL total_sales();

                              -- 17. PL/SQL Control Structures
-- Lab 1: Write a PL/SQL block using an IF-THEN condition to check the department of an 
-- employee. 
DELIMITER $$

CREATE PROCEDURE check_emp_dept(IN p_emp_id INT)
BEGIN
    DECLARE department_id INT;

    -- Get the department of the employee
    SELECT dept_id INTO department_id
    FROM employees
    WHERE emp_id = p_emp_id;

    -- Check the department
    IF department_id = 1 THEN
        SELECT 'Employee works in the HR department.' AS message;
    ELSEIF department_id = 2 THEN
        SELECT 'Employee works in the Finance department.' AS message;
    ELSEIF department_id = 3 THEN
        SELECT 'Employee works in the IT department.' AS message;
    ELSE
        SELECT 'Employee works in another department.' AS message;
    END IF;
END$$

DELIMITER ;
select *from employees;

CALL check_emp_dept(102);

-- Lab 2: Use a FOR LOOP to iterate through employee records and display their names. 
DELIMITER $$

CREATE PROCEDURE display_employee_names()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_name VARCHAR(100);

    -- Declare a cursor to select all employee names
    DECLARE emp_cursor CURSOR FOR
        SELECT emp_name FROM employees;

    -- Handler for when cursor reaches the end
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN emp_cursor;

    read_loop: LOOP
        FETCH emp_cursor INTO v_name;
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        -- Display the name
        SELECT v_name AS emp_name;
    END LOOP;

    CLOSE emp_cursor;
END$$

DELIMITER ;

CALL display_employee_names();

-- 18. SQL Cursors
-- Lab 1: Write a PL/SQL block using an explicit cursor to retrieve and display employee details.
DELIMITER $$

CREATE PROCEDURE display_employee_details()
BEGIN
    -- 1️⃣ Declare all variables first
    DECLARE v_id INT;
    DECLARE v_name VARCHAR(100);
    DECLARE v_dept INT;
    DECLARE v_salary DECIMAL(10,2);
    DECLARE done INT DEFAULT 0;

    -- 2️⃣ Declare cursor
    DECLARE emp_cursor CURSOR FOR
        SELECT emp_id, emp_name, dept_id, salary FROM employees;

    -- 3️⃣ Declare handler
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Open cursor
    OPEN emp_cursor;

    read_loop: LOOP
        FETCH emp_cursor INTO v_id, v_name, v_dept, v_salary;
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        -- Display the employee details
        SELECT v_id AS employee_id, 
               v_name AS employee_name, 
               v_dept AS department_id, 
               v_salary AS salary;
    END LOOP;

    -- Close cursor
    CLOSE emp_cursor;
END$$

DELIMITER ;

CALL display_employee_details();

-- Lab 2: Create a cursor to retrieve all courses and display them one by one. 

DELIMITER $$

CREATE PROCEDURE display_courses()
BEGIN
    -- 1️⃣ Declare variables to hold course data
    DECLARE v_course_id INT;
    DECLARE v_course_name VARCHAR(100);
    DECLARE v_course_duration VARCHAR(50);
    DECLARE done INT DEFAULT 0;

    -- 2️⃣ Declare cursor to fetch courses
    DECLARE course_cursor CURSOR FOR
        SELECT course_id, course_name, course_duration FROM courses;

    -- 3️⃣ Handler for end of cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Open cursor
    OPEN course_cursor;

    course_loop: LOOP
        FETCH course_cursor INTO v_course_id, v_course_name, v_course_duration;
        IF done = 1 THEN
            LEAVE course_loop;
        END IF;

        -- Display the course details
        SELECT v_course_id AS course_id, 
               v_course_name AS course_name, 
               v_course_duration AS course_duration;
    END LOOP;

    -- Close cursor
    CLOSE course_cursor;
END$$

DELIMITER ;
use school_db;
select *from courses;
CALL display_courses();

                              -- 19. Rollback and Commit Savepoint
-- Lab 1: Perform a transaction where you create a savepoint, insert records, then rollback to 
-- the savepoint.
START TRANSACTION;
SAVEPOINT before_inserts;
INSERT INTO courses (course_id, course_name, course_duration)
VALUES 
(1010, 'SQL', '1 Month'),
(1011, 'HTML', '1 Month');
ROLLBACK TO SAVEPOINT before_inserts;
INSERT INTO courses (course_id, course_name, course_duration)
VALUES (1012, 'JavaScript', '2 Months');
COMMIT;

-- Lab 2: Commit part of a transaction after using a savepoint and then rollback the remaining 
-- changes.

START TRANSACTION;
INSERT INTO courses (course_id, course_name, course_duration)
VALUES (1011, 'C++', '2 Months'),
       (1013, 'Java', '3 Months');
       SAVEPOINT sp1;
       COMMIT;

START TRANSACTION;
       INSERT INTO courses (course_id, course_name, course_duration)
VALUES (1014, 'Python', '2 Months'),
       (1015, 'SQL', '1 Month');
       ROLLBACK;
       SELECT * FROM courses;
       