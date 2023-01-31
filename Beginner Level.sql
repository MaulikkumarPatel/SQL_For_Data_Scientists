--   Extract data from the database and export it in available format.
USE SQL_HR;

-- 'USE' is help to sweet between different database
SELECT *
FROM SQL_HR.EMPLOYEES;
SELECT FIRST_NAME,
    LAST_NAME,
    SALARY
FROM SQL_HR.EMPLOYEES;

--  ----------------ORDER BY CLAUSE----------------

SELECT FIRST_NAME,
    LAST_NAME,
    SALARY
FROM SQL_HR.EMPLOYEES
ORDER BY SALARY DESC;
-- now the salary is in decreasing order.
SELECT FIRST_NAME,
    LAST_NAME,
    SALARY
FROM SQL_HR.EMPLOYEES
ORDER BY SALARY;
-- now the salary is in increasing order.

--  ----------------WHERE----------------

SELECT FIRST_NAME,
    LAST_NAME,
    SALARY
FROM SQL_HR.EMPLOYEES
WHERE SALARY > '10000' -- first where then after use order by else it will give you syntex error.
ORDER BY SALARY DESC;
-- now you can see that salary is > 10000 and is sorted by descnding order.

--  ----------------SELECT----------------

SELECT FIRST_NAME,
    LAST_NAME,
    SALARY,
    SALARY + 500
FROM SQL_HR.EMPLOYEES;
--  using AS we can give the imformative name to columns.
SELECT FIRST_NAME,
    LAST_NAME,
    SALARY,
    SALARY + 500 AS INCREASED_SALARY
FROM SQL_HR.EMPLOYEES;
USE SQL_STORE;
SELECT ORDER_ID,
    QUANTITY,
    UNIT_PRICE,
    QUANTITY * UNIT_PRICE AS TOTAL_PRICE
FROM ORDER_ITEMS;
SELECT ORDER_ID,
    QUANTITY,
    UNIT_PRICE,
    QUANTITY * UNIT_PRICE AS TOTAL_PRICE,
    ROUND(
        (QUANTITY * UNIT_PRICE) -(QUANTITY * UNIT_PRICE) * 0.10,
        2
    ) AS '10% Discount'
FROM ORDER_ITEMS;
SELECT *
FROM CUSTOMERS;

--  ----------------DISTINCT----------------

SELECT DISTINCT STATE
FROM CUSTOMERS;
-- it will show only unique name or number, it will not repeat name or number
-- Suppose if there is list of country and we will chose it distincly so it will give only list of country uniquely
--  ----------------WEARE CLAUSE IN DETAILS----------------
SELECT *
FROM CUSTOMERS
WHERE POINTS > 2000;

--  ----------------COMPARISON_OPERATOR----------------
-- = EQUAL TO
-- < LESSTHAN
-- > GREATER THAN
-- <= LESSTHEN OR EQUALTO
-- >= GREATER OR EQUAL TO
-- != OR <> NOT EQUAL TO

SELECT *
FROM CUSTOMERS
WHERE POINTS < 1000;
SELECT *
FROM CUSTOMERS
WHERE POINTS > 1000;
SELECT *
FROM CUSTOMERS
WHERE POINTS <= 1000;
SELECT *
FROM CUSTOMERS
WHERE POINTS >= 1000;
SELECT *
FROM CUSTOMERS
WHERE POINTS != 1000;
SELECT *
FROM CUSTOMERS
WHERE POINTS <> 1000;
SELECT *
FROM CUSTOMERS
WHERE STATE = 'MA';
SELECT *
FROM CUSTOMERS
WHERE BIRTH_DATE < '1990-01-01';
SELECT *
FROM CUSTOMERS
WHERE BIRTH_DATE > '1990-01-01';

-- --------------- AND, OR and NOT Operators------------------

--  ------AND Operator------

USE SQL_STORE;
SELECT *
FROM CUSTOMERS
WHERE BIRTH_DATE > '1990-01-01'
    AND CITY = 'Chicago';
-- Here the condition of of 'AND' is both conditions must be true,if condition match than it will give the output.

-- ------OR Operator-------

SELECT *
FROM CUSTOMERS
WHERE BIRTH_DATE > '1990-01-01'
    OR CITY = 'Chicago';
-- In OR operator atleast one condition must be satisfied.
-- It will check both the conditions and give the output according to it.
-- We can use AND and OR operator together as well.
SELECT *
FROM CUSTOMERS
WHERE BIRTH_DATE > '1990-01-01'
    OR CITY = 'Chicago'
    AND POINTS > 1000;
-- Here it will check first AND operator's condition, if it true,
--  thanafter it will check the both conditions of OR operator,
--  if both or one condition will satisfied it will give an output.
-- ------NOT Operator-------
-- whatever we select in not condition will not part of that condition or not stisfied that condition.
SELECT *
FROM CUSTOMERS
WHERE NOT(
        BIRTH_DATE > '1990-01-01'
        AND POINTS < 1000
    );
-- here you can see that it will give output which will not satisfied with these given conditions.

-- ----------IN Operator----------

SELECT *
FROM CUSTOMERS
WHERE STATE = 'FL'
    OR STATE = 'VA'
    OR STATE = 'GA';
-- this is long and time taking syntex for large dataset,
-- so here we can use the IN operator to do same thing in easy way
SELECT *
FROM CUSTOMERS
WHERE STATE IN ('FL', 'VA', 'GA');
-- it will gaive same output as above the differance is IN operator,
-- we can use it for to check the large condition which is exist or not.

-- ----------BETWEEN Operator-----------

SELECT *
FROM CUSTOMERS
WHERE POINTS >= 1000
    AND POINTS < 3000;
-- If we want to check the range we can use the BETWEEN operator
-- We can do same thing using the BETWEEN operator
SELECT *
FROM CUSTOMERS
WHERE POINTS BETWEEN 1000 AND 3000;
-- Still it will give the same result but in easy way

-- -----------LIKE Operator------------

SELECT *
FROM CUSTOMERS
WHERE LAST_NAME LIKE 'b%';
-- it will show that last_name start with latter 'b'.
-- we can use LIKE operator to find anything with start,end or include with latter or number.
SELECT *
FROM CUSTOMERS
WHERE LAST_NAME LIKE '%se%';
-- it will show that last_name contain latter 'se'.
SELECT *
FROM CUSTOMERS
WHERE LAST_NAME LIKE 'N____y';
-- if you know the first and last latter of name or anything you can find with its character's length as well.
SELECT *
FROM CUSTOMERS
WHERE LAST_NAME LIKE '_____y';
-- here you can see that there are 3 names which and with 'y' and its length is '8'.
-- -----------REGEXP: REGULAR EXPRESSION-------------
-- REGEXP and LIKE both work same.
SELECT *
FROM CUSTOMERS
WHERE LAST_NAME REGEXP 'b';
-- it will give the output which will contain latter 'b' in theri last name.
SELECT *
FROM CUSTOMERS
WHERE LAST_NAME REGEXP '^b';
-- it will give the output of those last_name which start with the latter 'b'.
SELECT *
FROM CUSTOMERS
WHERE LAST_NAME REGEXP 'y$';
-- it will give the output of those last_name which end with the latter 'y'.
SELECT *
FROM CUSTOMERS
WHERE LAST_NAME REGEXP 'brus|mac|se';
-- it will give the output of those name which contain any of those.
-- e in their last name, before 'e' ge,se,ie
SELECT *
FROM CUSTOMERS
WHERE LAST_NAME REGEXP '[gsi]e';
-- it will return those values which contain 'g or s or i' before the latter 'e' in the last_name.
SELECT *
FROM CUSTOMERS
WHERE LAST_NAME REGEXP '[d-m]e';
-- here we can give the rangr as well for before or after the latter.
SELECT *
FROM CUSTOMERS
WHERE LAST_NAME REGEXP 'e[k-z]';

-- ^ Beginning of a string
-- $ Ending of a string
-- | To indical logical OR
-- [a,b,c] to indicate combination of characters before or after
-- [a-z] to indicate combination of characters before or after but it will in the range

-- -------IS NULL or IS NOT NULL operator--------------

SELECT *
FROM CUSTOMERS
WHERE PHONE IS NULL;
-- it will check for the null values in the dataset
SELECT *
FROM CUSTOMERS
WHERE PHONE IS NOT NULL;
-- it will print those values which phone is not null.

-- -----------ORDER BY------------

SELECT *
FROM CUSTOMERS
ORDER BY FIRST_NAME;
-- it will sort the colums by its alphabetical order
SELECT *
FROM CUSTOMERS
ORDER BY POINTS DESC;
-- it will sort the table by decreasing order
SELECT *
FROM CUSTOMERS
ORDER BY FIRST_NAME,
    STATE;

-- ----------LIMIT Operator--------------

SELECT *
FROM CUSTOMERS
LIMIT 5;
-- it will show first 5 rows
-- limit operator use for to choose up to specific number
SELECT *
FROM CUSTOMERS
LIMIT 5, 3;
-- it will skip the first 5 rows and count from 5 to upto next 3 rows.