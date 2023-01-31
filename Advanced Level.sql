
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
