--   ---------Exersise1----------

-- Write an SQL query to return:
-- 	1. all the products in the database
-- 	2. name
-- 	3. unit price
-- 	2. discounted price of 5%


--  ------------ solution1----------

use sql_store;
select 	name,
		unit_price,
        round(unit_price-(unit_price*0.05),2)as Discount_Price
from products;


--   ---------Exersise2----------

-- Write an SQL quary to return the orders that were made before 2019.

 ------------ solution2----------
use sql_store;
select * 
from orders
where order_date < '2019-01-01';


-- ----------EXERCISE 3-------------

-- From the order_items table , get the items:
-- for oder number 6 
-- where the total price is greater than $20
-- and display the unit price

-- ----------SOLUTION3------------

use sql_store;
select *,
(quantity*unit_price) as Total_Price 
from order_items
where order_id = 6 and (unit_price*quantity) > 20;


-- ---------EXERCISE 4-----------

-- Return products with
-- quantity in stock equal to 49, 38, 72
    
-- ---------SOLUTION 4-----------  

use sql_store;
select * from products
where quantity_in_stock in (49,38,72);  

    
-- ----------EXERCISE 5------------

-- Return CUSTOMERS born
-- between 1/1/1990 and 1/1/2000

-- ----------SOLUTION 5------------

select * from customers
where birth_date between '1990-01-01' and '2000-01-01';

-- if you will not write in quote it will show nothing


-- ----------EXERCISE 6-------------

-- Get the customers whose 
	-- 1. addresses contain TRAIL or AVENUE
	-- 2. phone numbers end with 9
    
-- ----------SOLUTION 6-------------

       
-- select * 
-- from customers
-- where address  like '%avenue%'or'%trail%'; 
-- if you'll write both parameters together it will consider only first one.

select * 
from customers
where address  like '%avenue%'or
		address like'%trail%';
-- This is the right way to do it

select * 
from customers
where phone like '%9';
    
    
-- ----------EXERCISE 7-------------
    
-- Get the customer whose 
	-- first names are ELKA or AMBUR
    -- last names end with EY or ON
    -- last names starts with MY or contains SE
    -- last names contain B followed by R or U
    
-- ----------SOLUTION 7-----------

-- first names are ELKA or AMBUR
select * 
from customers
where first_name regexp 'elka|ambur';

 -- last names end with EY or ON
 
 select *
 from customers
 where last_name regexp 'on$|ey';
	

-- last names starts with MY or contains SE

select *
from customers
where last_name regexp '^my|se' ;
    
-- last names contain B followed by R or U

select * 
from customers
where last_name regexp 'b[r|u]';

-- or we can write in this way as well

select * 
from customers
where last_name regexp 'br|bu';


    
-- ----------EXERCISE 8-------------

-- get all the orders that are not shipped

-- -----------SOLUTION 8------------

select * 
from orders
where status=1 ; 

-- we can also write this way

select *
from orders
where shipped_date is null;

-- or this way as well

select *
from orders
where shipper_id is null;
    
    
    
-- ----------EXERCISE 9-------------

-- get the top 3 loyal customers

-- ----------SOLUTION 9-------------

select * 
from customers
order by points desc
limit 3;

-- it will give those customer's name who did shopping most and earned points.


-- ----------EXERCISE 10-------------


-- write a query to join the order_items table with the products table and return 
		-- product ID
        -- product name
        -- quantity
        -- unit price
        -- Multiply the quantity and unit_price and give new name of total price

-- ----------SOLUTION 10-------------
use sql_store;

select oi.product_id, 
		p.name, 
        oi.quantity,
        oi.unit_price,
		(oi.quantity*oi.unit_price) as Total_price
from order_items oi
join  products p
		on oi.product_id = p.product_id;
        

-- --------------EXERCISE 11--------------------

-- write a query and join the payments table with the payment_methods table as well as the clients
   -- producce a report that shows the payment with more details such as the name of the client, and the payment method etc.
   -- nb: the tables are found in the sql_invoicing database
   
-- --------------SOLUTION 11--------------------

use sql_invoicing;

select c.name,
		c.phone,
        p.date,
        p.amount,
        pm.name as Payment_By
from payments p
join clients c
on p.client_id=c.client_id
join payment_methods pm
on pm.payment_method_id=p.payment_method;


-- --------------EXERCISE 12--------------------------

-- write a query that produces a table with the following results:
-- product_id, name(i.e. name of product), quantity(you can get that from the order items table)
-- give the total of unit_price and quantity as Total_Price
-- return the product even if it has never been ordered

-- --------------SOLUTION 12--------------------------

select * 
from products p
join order_items oi
on p.product_id = oi.product_id;

-- here will choose only those columns which are essential
select oi.product_id,
		p.name,
        oi.quantity,
        oi.unit_price,
        oi.unit_price*quantity as Total_price
from products p
left join order_items oi
on p.product_id = oi.product_id;



-- --------------EXERCISE 13--------------------------
	-- using the sql_invoicing database, write a query that returns:
        -- date
        -- amount
        -- client
        -- name (i.e name of payment menthod)
        
-- --------------SOLUTION 13--------------------------
use sql_invoicing;

select *
from payments p
join clients c
on p.client_id=c.client_id
join payment_methods pm
on pm.payment_method_id=p.payment_method;


select p.date,
		p.amount,
        c.name,
        pm.name as Payment_By
from payments p
join clients c using(client_id) -- if both table have same key name you can connect them using this code as well
join payment_methods pm
on pm.payment_method_id=p.payment_method;

