-- Creating the database

CREATE DATABASE DS_database;

-- Creating the table for database

use DS_database; -- If we dont choose database it will give you an error

CREATE TABLE students (Roll_No int, Name varchar(10),Age int,Phone int);
select * from students;

-- Insert data into Database

-- Put the name or any words in single'' or double quotes""

INSERT INTO students  
VALUES(3,"JERRY",23,123123134),
		(4,"TOM",24,123123144);
		
-- Get the infomation from the table

SELECT Roll_No,Name,Age -- just select wich row you want to read and name the database 
from students;

-- Constraints in SQL

--     ------------NOTNULL------------
use ds_database;
CREATE TABLE Person (
			ID int not null,
            First_Name varchar(10) NOT NULL,
            Last_Name varchar(10) null,
            Age int null
            );

select * from Person;


--     ------------UNIQUE------------

drop table Person;

create table person (
			ID int not null,
            Fist_Name varchar(10),
            Last_Name varchar(10),
            Age int null,
            unique(ID)
					);
                    
select * from person;

insert into person (ID,Fist_Name,Last_Name,Age) -- here you must have to give id or you can make it null else it will give you an error
			values(01,'Mack','Patel',23);
            
--     ------------DEFAULT------------
drop table person;
create table person(
			ID int default 00, --  here we have enter default value even if user will not enter it will take 0 as input
            First_name varchar(10),
            Last_Name varchar(10),
            Age int null
					);
                    
insert into person(First_name,Last_Name,Age)
values('Mack','Patel',23);

select * from person;



--     ------------PRIMARY KEY------------

create table customer(
			C_name varchar(10),
            product varchar(10),
            Product_ID int,
           -- Product_ID int primary key,
            primary key(Product_ID)
					);
                    
select * from customer;

--     ------------ALTERING IN EXISTING TABLE (ADDING CONSTRAINTS)------------

ALTER table person
add primary key(ID);

--     ------------ALTERING IN EXISTING TABLE (Dropping CONSTRAINTS)------------
drop table passenger;
create table passenger(
			First_Name varchar(10),
            Last_Name varchar(10),
            mobile int,
            Ticket_NO varchar(10) 
            );
            
select * from passenger;

alter table passenger 
add constraint uc_passenger unique (mobile,Ticket_NO);  -- here we gave name of whole  constraint uc_passenger

insert into passenger 
			values('a','A',123,1),
					('b','B',1223,2);
            
alter table passenger
drop index uc_passenger; 

insert into passenger 
			values('mk','ptl',123,1),
					('m','pl',123,1);
                    
                    
--     ------------FOREIGN KEY------------

CREATE table cust (
			cust_id int not null,
            First_name varchar(10),
            Last_name varchar(10),
            Age int,
            primary key (cust_id)
            );
            
select * from orders;

create table orders(
			order_id int not null,
            order_number int not null,
            cust_id int,
            primary key(order_id),
            foreign key(cust_id) references cust(cust_id) 
					);

