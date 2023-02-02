
-- ------------JOINS in SQL--------------------

USE SQL_STORE;
SELECT *
FROM ORDERS
    JOIN CUSTOMERS ON ORDERS.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID;
SELECT ORDER_ID,
    FIRST_NAME,
    LAST_NAME,
    PHONE,
    CITY -- here we select specific colums that we need insted of entire table.
FROM CUSTOMERS
    JOIN ORDERS ON CUSTOMERS.CUSTOMER_ID = ORDERS.CUSTOMER_ID;
SELECT ORDER_ID,
    FIRST_NAME,
    LAST_NAME,
    PHONE,
    CITY
FROM CUSTOMERS C -- here we can give any easy name that could be anything. Given name is known as 'ALIAS'.
    JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID;

-- -----------Joining across different databases-------------

SELECT *
FROM ORDER_ITEMS OI
    JOIN SQL_INVENTORY.PRODUCTS P ON OI.PRODUCT_ID = P.PRODUCT_ID;
-- here we have connect two different tables from among two different databases.
SELECT OI.PRODUCT_ID,
    NAME,
    QUANTITY_IN_STOCK,
    OI.UNIT_PRICE -- here we select only those colums which we need
FROM ORDER_ITEMS OI -- if there is same name in both colums then we have to use alisa or,
    JOIN SQL_INVENTORY.PRODUCTS P -- there is only one name in both table we can write only colums name as well like name and quantity_in_stock.
    ON OI.PRODUCT_ID = P.PRODUCT_ID;

-- -----------Joining table by itself-------------

USE SQL_HR;
SELECT E.EMPLOYEE_ID,
    E.FIRST_NAME,
    E.LAST_NAME,
    E.JOB_TITLE,
    M.FIRST_NAME AS MANAGER,
    M.JOB_TITLE
FROM EMPLOYEES E
    JOIN EMPLOYEES M ON M.EMPLOYEE_ID = E.REPORTS_TO;
-- here we join table with itself
-- when you'll choose alias it must be different  like e and m

-- -----------Joining table with multiple table-------------

USE SQL_STORE;
SELECT *
FROM CUSTOMERS C
    JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
    JOIN ORDER_STATUSES OS ON O.STATUS = OS.ORDER_STATUS_ID;
-- here we have joind 3 different tables
SELECT C.FIRST_NAME,
    C.LAST_NAME,
    C.PHONE,
    C.ADDRESS,
    O.SHIPPED_DATE,
    O.ORDER_ID,
    O.ORDER_DATE,
    OS.NAME AS STATUS
FROM CUSTOMERS C
    JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
    JOIN ORDER_STATUSES OS ON O.STATUS = OS.ORDER_STATUS_ID;
-- here we select only useful infomation from 3 tables.

-- ------------LEFT and RIGHT JOINS--------------

SELECT C.CUSTOMER_ID,
    C.FIRST_NAME,
    C.LAST_NAME,
    O.ORDER_ID,
    O.STATUS
FROM CUSTOMERS C
    JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID;
-- here its showing only those customers who have placed their order.
-- if we want entire tabal's data even customer diden't order.Here we can use LEFT OR RIGHT JOINS
SELECT C.CUSTOMER_ID,
    C.FIRST_NAME,
    C.LAST_NAME,
    O.ORDER_ID,
    O.STATUS
FROM CUSTOMERS C -- you can see it will show all the customer even who did not order
    LEFT JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID;
SELECT C.CUSTOMER_ID,
    C.FIRST_NAME,
    C.LAST_NAME,
    O.ORDER_ID,
    O.STATUS
FROM CUSTOMERS C -- you can see it will show all the order_id and status
    RIGHT JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID;
SELECT C.CUSTOMER_ID,
    C.FIRST_NAME,
    C.LAST_NAME,
    O.ORDER_ID,
    O.STATUS
FROM ORDERS O -- you can see it will show all the customer even who did not order. it will give the high priority to customers's table
    RIGHT JOIN CUSTOMERS C ON C.CUSTOMER_ID = O.CUSTOMER_ID;
-- the use of LEFT and RIGHT join is to give high priority to any table.

-- INSERTING Multiple Data Into Existing Table

USE SQL_STORE;
SELECT *
FROM SHIPPERS;
INSERT INTO SHIPPERS
VALUES(DEFAULT, 'RK');
-- here we have insert data into table
INSERT INTO SHIPPERS
VALUES(DEFAULT, 'mm'),
    (DEFAULT, 'kk'),
    -- here we have insert multiple data at a time
    (DEFAULT, 'pp');


-- Creating a copy of a table

CREATE TABLE NEW_ORDERS AS
SELECT *
FROM ORDERS;
-- you clear the data as well of data using truncate
TRUNCATE SQL_STORE.NEW_ORDERS;
SELECT *
FROM NEW_ORDERS;
-- Here we are gonna insert some data
INSERT INTO NEW_ORDERS
SELECT *
FROM ORDERS
WHERE ORDER_DATE < '2019-01-01';
-- now successfully we have insert data of those orders which was done before '201-01-01 and saved into new_orders'
SELECT *
FROM NEW_ORDERS;

-- Updating the existing table

USE SQL_STORE;
UPDATE CUSTOMERS
SET PHONE = '342-450-1232'
WHERE CUSTOMER_ID = 5;
-- here we have update the phone number of customer whose custumor id is 5.
UPDATE CUSTOMERS
SET PHONE = '123-123-1234',
    CITY = 'London'
WHERE CUSTOMER_ID = 5;
-- we can update multiple columns as well
-- null values also we can fill it with the update
SELECT *
FROM CUSTOMERS;
-- now if you'll check the city is of customer is London and phone number is also changed.
-- Remember you have to choose primary key so you can uqniquely identify that row,
-- for example, here i have choose customer_id which is unique for every customer so by that we can identify each customer easily.

-- Updating mupliple rows
-- Lets update multiple rows as well.

USE SQL_INVOICING;
SELECT *
FROM INVOICES;
-- here you can see that there is clint_id column, where is the same id we can change values of those rows.
UPDATE INVOICES
SET PAYMENT_TOTAL = 34
WHERE CLIENT_ID = 5;
-- now you can see there is client_id number 5 who done his payment so we can update it everywhere where client_id = 2.
-- so we no need to go every rwo where client_id = 2 using this comand we can update all the rows of that client.
SELECT *
FROM INVOICES;
-- we can update the multiple rows at a time as well
UPDATE INVOICES
SET PAYMENT_TOTAL = 23
WHERE CLIENT_ID IN (2, 5);
-- now you can see that where is the client_id = 2 and 5 the payment_total is updated by 23
SELECT *
FROM INVOICES;

-- ---------------VIEW IN SQL-------------
-- View is use to store the results of the quary

USE SQL_HR;
CREATE VIEW EMPLOYEE_POSITION AS
SELECT *
FROM EMPLOYEES
WHERE JOB_TITLE NOT LIKE '%VP%'
    AND REPORTS_TO IS NOT NULL;
-- it will not select those vales which are satisfing this condition
-- here we have create the view Employee_Position where we have stored the infomation of our quary
-- refresh the database under the table you'll find the views where you can check you created view

-- ------------USING THE CREATED VIEW------------

SELECT *
FROM EMPLOYEE_POSITION;
-- here we fetch the infomation from the view that we created before,
-- advantage is that we no need to re-write that code again and again just make a view and run the command to get data.
-- we can choose necessery infomation as well insted of all columns.
SELECT FIRST_NAME,
    LAST_NAME,
    JOB_TITLE,
    SALARY
FROM EMPLOYEE_POSITION;
SELECT FIRST_NAME,
    LAST_NAME,
    JOB_TITLE,
    SALARY,
    FORMAT((SALARY * 0.05) + SALARY, 2) AS INCREASED_SALARY
FROM EMPLOYEE_POSITION;

-- ---------ALTER VIEW-------------
-- suppose, you work on data and want to update or change the view,
-- so you can do it by ALTER

CREATE VIEW EMPLOYEE_POSITION AS
SELECT *
FROM EMPLOYEES
WHERE JOB_TITLE NOT LIKE '%VP%'
    AND REPORTS_TO IS NOT NULL;
-- Now,i wnant to change the view that i created before named Employee_position.
-- i want add more condition in that view
-- choose only those employees whose salaray > 70000.
ALTER VIEW EMPLOYEE_POSITION AS
SELECT *
FROM EMPLOYEES
WHERE JOB_TITLE NOT LIKE '%VP%'
    AND REPORTS_TO IS NOT NULL
    AND SALARY > 70000;
-- now you can see that view is now has been updated by above condition
SELECT *
FROM EMPLOYEE_POSITION;

-- -----------DROP VIEW-----------
-- Now everything done and you want to remove or delete that view so you can use Drop

DROP VIEW EMPLOYEE_POSITION;
-- after running the code the view will be no more exist.
SELECT *
FROM EMPLOYEE_POSITION;
-- it will say that it dosent't exist

-- --------------AGGREGATION FUNCTION---------------
-- COUNT(): It use to count the total number of perticular column
-- SUM(): It will return the total of whole column
-- AVG(): It function is use to get the average
-- MIN(): It will return the minimum number
-- MAX(): It will retirn the maximum number

-- ---------------COUNT()---------------

SELECT COUNT(FIRST_NAME)
FROM EMPLOYEES;
-- count function give the return of all the availabe data in column.

-- -------------SUM()---------------------

SELECT SUM(SALARY)
FROM EMPLOYEES;
-- you can see the total salary 1650047 paid by company to employees.
-- SUM function is use to do sum of all the avilable number like, salary,working hour of person etc...

-- ------------AVG FUNCTON-----------

SELECT AVG(SALARY)
FROM EMPLOYEES;
-- you can see that the average salary paid by company is '82502.3500'.
-- This function is use to get the average

-- ----------MIN FUNCTION------------

SELECT MIN(SALARY)
FROM EMPLOYEES;
-- You can see that minimum salary is 32179.

-- ------------MAX FUNCTION---------

SELECT MAX(SALARY)
FROM EMPLOYEES;
-- 119241 is maximum salary paid by company.

-- -----------COMBINE FUNCTION---------

-- we can use all the function all together
SELECT COUNT(FIRST_NAME),
    SUM(SALARY),
    AVG(SALARY),
    MIN(SALARY),
    MAX(SALARY)
FROM EMPLOYEES;
