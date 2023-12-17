create database date_function;
use date_function;


create table employee (
     emp_id int,
     hire_date date,
     resignation_date date
     );


insert into employee ( emp_id,hire_date,resignation_date)
values (1,'2000/1/1','2013/10/7'),
(2,'2003/12/4','2017/8/3'),
(3,'2012/9/22','2015/6/21'),
(4,'2015/4/13',null),
(5,'2016/06/03',null),
(6,'2017/08/08',null),
(7,'2016/11/13',null);

select * from employee;

-- 1) Find the date difference between the hire date and resignation_date for all the
-- employees. Display in no. of days, months and year(1 year 3 months 5 days).Emp_ID Hire Date Resignation_Date
select emp_id, concat( (year(resignation_date)-year(hire_date)), ' years ', 
	 if( (month(resignation_date)-month(hire_date)) < 0 , - (month(resignation_date)-month(hire_date)) , (month(resignation_date)-month(hire_date)) ),
     ' months ' ,
	 if ( (day(resignation_date)-day(hire_date)) < 0 , -(day(resignation_date)-day(hire_date)) , (day(resignation_date)-day(hire_date)) ),
	 ' days ' ) as time
from employee;

-- 2) Format the hire date as mm/dd/yyyy(09/22/2003) and resignation_date as mon dd, yyyy(Aug 12th, 2004). Display the null as (DEC, 01th 1900)
select date_format(hire_date,'%m/' '%d/' '%Y' ) as hire_date ,concat(substr(date_format(resignation_date,'%M'),1,3),' ', date_format(resignation_date, '%D '  '%Y' ) )as resgn_date from employee;

-- 3) Calcuate experience of the employee till date in Years and months(example 1 year and 3 months)
select concat( (year(current_timestamp) - year(hire_date)) , ' years ',
	if( (month(current_timestamp)-month(hire_date)) <0 , - (month(current_timestamp)-month(hire_date)) , (month(current_timestamp)-month(hire_date)) ), ' months ',
	if( (day(current_timestamp)-day(hire_date)) <0 , - (day(current_timestamp)-day(hire_date)) , (day(current_timestamp)-day(hire_date)) ),' days ' )
as experience from employee where resignation_date is null;

-- 4) Display the count of days in the previous quarter 
select quarter(hire_date) from employee;

-- 5) Fetch the previous Quarter's second week's first day's date 

-- 6) Fetch the financial year's 15th week's dates (Format: Mon DD YYYY) 

-- 7) Find out the date that corresponds to the last Saturday of January, 2015 using with clause. 

     
     
     








































