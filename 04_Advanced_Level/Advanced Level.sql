
-- ------------COUNT FUNCTION IN DETAIL-----------

-- ----------COUNT FUNCTION WITH WHERE----------------
use sql_hr;

select *
from employees
where salary > 70000;

-- If we want to count there are how many employees who earn more than 70000.

select count(*) as Total
from employees
where salary > 70000;

-- There are 13 employees whose salary is grater than 70000.

-- ----------COUNT FUNCTION WITH DISTINCT----------------

select count( distinct job_title) 
as Job_Title
from employees;

-- It will return the every job title which is unique

select  distinct job_title 
as Job_Title
from employees;

-- here you can see every job title is different

-- -------------HAVING FUNCTION------------

use sql_store;

select *
from customers
having points > 1000;

-- it will return those customer whose points more than 1000.

-- ----------ORDER BY-----------------

use classicmodels;

select *
from orderdetails;

select orderNumber,
	   sum(quantityOrdered) as Total_Items_Orderd,
       sum(priceEach*quantityOrdered) as total
from orderdetails
group by orderNumber;

-- so here you can see that we have first get the sum of the order and total price,
-- than we group them by orderNumber.
-- you can see that ordernumber 10100 ordered 151 items and total is '10223.83'.


select orderNumber,
	   sum(quantityOrdered) as Total_Items_Orderd,
       sum(priceEach*quantityOrdered) as total
from orderdetails
group by orderNumber
having total > 10000;

-- here we use having function we can not use 'where' here,
-- as per SQL standards we can not use 'where' after 'group by'.

           -- This order is followed by sql standards --
-- from > where > group by > having > select > distinct > order by > limt

select orderNumber,
	   sum(quantityOrdered) as Total_Items_Orderd,
       sum(priceEach*quantityOrdered) as total
from orderdetails
group by orderNumber
having total > 10000 and Total_Items_Orderd > 600;

-- now it will return those customer who orderd more than 600.
-- we can use logical operator with having function.

SELECT 
    a.ordernumber, 
    status, 
    SUM(priceeach*quantityOrdered) total
FROM
    orderdetails a
INNER JOIN orders b 
    ON b.ordernumber = a.ordernumber
GROUP BY  
    ordernumber, 
    status
HAVING 
    status = 'Shipped' AND 
    total > 1500;    
    
-- -----------ROLLUP FUNCTION--------------

CREATE TABLE sales
SELECT
    productLine,
    YEAR(orderDate) orderYear,
    SUM(quantityOrdered * priceEach) orderValue
FROM
    orderDetails
        INNER JOIN
    orders USING (orderNumber)
        INNER JOIN
    products USING (productCode)
GROUP BY
    productLine ,
    YEAR(orderDate);
    
-- Here we have create table 

select * from sales;

SELECT 
    productline, 
    SUM(orderValue) totalOrderValue
FROM
    sales
GROUP BY 
    productline; -- at the you can see there is no total amount.
    
    
    
SELECT 
    productline, 
    SUM(orderValue) totalOrderValue
FROM
    sales
GROUP BY 
    productline with rollup; -- we can get all the sum by 'group by' and if we want the sum of all at the end then we use ROLLUP.

-- --------------LENGTH() FUNCTION--------------

-- LENGTH()
-- CHAR_LENGTH()
-- CHARACTER_LENGTH() 

-- All these functions are use to get the length of character and number.

use sql_hr;

select first_name,
		length(first_name) as Length_Of_Name,
        char_length(first_name) as Length_Of_Name,
        character_length(first_name) as Length_Of_Name
from employees;

-- using the all above function we can get the lenght of character and Intiger.

-- ------------CONCAt() FUNCTION-------------

select concat(first_name,' ',last_name) as Name,
		salary        
from employees;
-- It will put together firstname and lastname and make one column. 
-- Using concat we can join the column together

-- ----------FORMAT()------------------

select concat(first_name,' ',last_name) as Name,
		salary,
		format(salary,2) as Formated_salary
from employees;
		
-- By using format function we can write number in more easily readable format.
-- for example: 42342,
--              42,342.00 this is more easliy we can read it.

-- ---------------INSERT()---------------
-- we have change this 'Account Executive' to 'Account General'

-- (job_title, 9 , 9 ,'General')
--     1       2   3    4 

-- 1: column name from table, 
-- 2: from which point we want to change and start. we start at 9th index because 'Account' have 8 character.
-- 3: count that character where you want to write new. here 'Executive' have 9 character so we have write 9.
-- 4: write you new title that you want to update.

select job_title, insert(job_title,9,9,'General')
from employees; -- if we dont give on which row we want to change it will update all.

-- so, to avoid that we will use 'where'.

select job_title, insert(job_title,9,9,'General') as New_Title
from employees
where employee_id = 33391;

-- now only 1st row will be update.

-- -------------LOCATE() FUNCTION-------------

select employee_id,
		job_title,
locate('Executive',job_title) as Location -- here we gave two parameter first'Executive' name that we want to find and second in which column we want to find.
from employees;

-- it will return at which index 'Executive' is starting.
-- it will check in every row and retuen the result.

-- -------------UCASE() and LCASE() FUNCTION------------

-- ----------UCASE(UPPERCASE)--------

select ucase(first_name) as First_Name,
		ucase(last_name) as Last_Name
from employees;

-- it will convert all the letters in uppercase.

-- ----------LCASE(LOWERCASE)-------------

select lcase(first_name) as First_Name,
		lcase(last_name) as Last_Name
from employees;

-- all the letters will be in lowercase.


-- ----------STORED PROCEDURE-------------

use sql_store;
select *
from orders
where order_date > '2018-01-01';

-- suppose we get this infomation and you need it frequently so you can store it and name it.
-- so here we will create store procedure.you can find it just below view in database.

create procedure Order18()
select *
from orders
where order_date > '2018-01-01';

-- we have created store procedure you can not access it directly.
-- you can use 'call' and name of procedure to access it.

call Order18();

-- ----------SORE PROCEDURE WITH SINGLE PARAMETER--------------

use sql_hr;
create procedure order2(office_id int)
select office_id,
		first_name,
		last_name,
        job_title,
        salary
from employees;

call order2(4);

-- here we have give one parameter 'office_id'
-- so we can fetch the data by office_id.
-- if we call order2(4) so it will return all the employees whose office_id is 4.

-- ----------SORE PROCEDURE WITH MULTIPLE PARAMETER--------------

create procedure employee(id int, sal decimal)

select office_id,
		first_name,
        last_name,
        job_title,
        salary
from employees
where office_id=id and salary > sal;

call employee(5,10000);

-- here we have given 2 parameter in store procedure id and sal.
-- in parameter we have to give id and salary.
-- so it will retuen those employee whose salary grater than 10000.

-- so writing code frequently just make procedure and call it as per your requitrements.

-- ---------Alter Procedure-----------

-- Just right click on created procedure and click on 'alter stored procedure' where you can update it.

-- -------------DROP PROCEDURE-----------------
use sql_hr;

create procedure demo()

select *
from employees;

call demo();
	
drop procedure demo; -- usind 'drop procedure' command you can drop the stored procedure.

-- ----------Triggers-----------

-- A trigger is stored program call automatically when insert,update or delete quary done by someone.
-- For Example: When you book the ticket of anything you'll get the conformation email automacially.

-- -----------BEFORE TRIGGERS-------------
use sql_store;

create trigger new_price 
before insert
on products
for each row
set new.unit_price = new.unit_price-(new.unit_price*0.1);

insert into products
values(12,'LED_Bule',33,20);

select * 
from products;

-- now you can see that we have insert new item LED_Bulb of 20 price but it got discount of 10% and save it.
-- so these are use of before trigger.

-- ----------AFTER TRIGGERS-----------
use sql_store;

create trigger status_trigger
after insert
on orders
for each row

insert order_statuses(order_status_id,name)
values(order_status_id,'Unsuccessful');

insert into orders(order_id,customer_id,order_date,comments,shipped_date,shipper_id)
values(11,2,'2023-01-01','Order was not complited','2023-01-01',3);

select * from order_statuses;
select * from orders;

show triggers 
in sql_store; -- you can check the active triggers using this command


-- ------------DROP TRIGGER----------

drop trigger status_trigger;
-- we have deleted 'status_trigger' trigger.
show triggers 
in sql_store;
