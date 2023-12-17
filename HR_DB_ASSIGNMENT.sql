use hrdb_assignment;



-- ------------ PAGE_1 ---------------



-- 1. Display all information in the tables EMP and DEPT. 
select * from employees,departments;

-- 2. Display only the hire date and employee name for each employee. 
select hire_date,concat(first_name," ",last_name) as name from employees;

-- 3. Display the ename concatenated with the job ID, separated by a comma and space, and name the column Employee and Title
select concat(first_name," ",last_name,", ",job_id) as employee_and_title from employees;

-- 4. Display the hire date, name and department number for all clerks.
select hire_date,first_name,department_id,job_title from employees join jobs 
on jobs.job_id=employees.job_id where job_title like "%Clerk%";

-- 5. Create a query to display all the data from the EMP table. Separate each column by a comma. Name the column THE OUTPUT 
select concat_ws(", ",employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) as THE_OUTPUT from employees; 

-- 6. Display the names and salaries of all employees with a salary greater than 2000. 
select first_name,salary from employees
where salary>2000;

-- 7. Display the names and dates of employees with the column headers "Name" and "Start Date" 
select first_name as Name, hire_date as Start_Date from employees;

-- 8. Display the names and hire dates of all employees in the order they were hired. 
select first_name,hire_date from employees order by hire_date;

-- 9. Display the names and salaries of all employees in reverse salary order. 
select concat(first_name,' ',last_name) as name, salary from employees
order by salary desc;

-- 10. Display 'ename" and "deptno" who are all earned commission and display salary in reverse order. 
select concat(first_name," ",last_name) as Ename, department_id,salary from employees
where commission_pct is not null order by salary desc;

-- 11. Display the last name and job title of all employees who do not have a manager 
select concat(first_name," ",last_name) as Name,job_title from employees join jobs
on employees.job_id=jobs.job_id where manager_id is null;

-- 12. Display the last name, job, and salary for all employees whose job is sales representative
-- or stock clerk and whose salary is not equal to $2,500, $3,500, or $5,000
select last_name,job_title,salary from employees join jobs
on employees.job_id=jobs.job_id
where job_title="Sales Representative" or job_title="Stock Clerk" and salary!=2500 and salary!=3500 and salary!=5000;



-- ------------ PAGE_2 ---------------



-- 1) Display the maximum, minimum and average salary and commission earned. 
select concat(first_name,' ' ,last_name) as name,max(salary), min(salary), avg(salary) as avg_salary, ifnull(salary*commission_pct,0) as commision from employees
group by name order by avg_salary desc;

-- 2) Display the department number, total salary payout and total commission payout for each department. 
 select department_id as department_number,sum(salary) as total_salary, sum(ifnull(salary*commission_pct,0)) as total_commision from employees
 group by department_id;
 
 -- 3) Display the department number and number of employees in each department. 
 select department_id as department_number, count(employee_id) as number_of_employees from employees group by department_id;

-- 4) Display the department number and total salary of employees in each department. 
select department_id as department_number, sum(salary) as total_salary_of_employees from employees group by department_id;

-- 5) Display the employee's name who doesn't earn a commission. Order the result set without using the column name 
 select concat(first_name,' ',last_name) as employee_name from employees where commission_pct is null;
 
 -- 6) Display the employees name, department id and commission. If an Employee doesn't 
 -- earn the commission, then display as 'No commission'. Name the columns appropriately
  select concat(first_name,' ',last_name) as employee_name,department_id, ifnull(salary*commission_pct,'No commission') as commission from employees;
  
  -- 7) Display the employee's name, salary and commission multiplied by 2. If an Employee 
  -- doesn't earn the commission, then display as 'No commission. Name the columns appropriately
 select concat(first_name,' ',last_name) as employee_name,salary,ifnull(salary*commission_pct*2,'No commission') as commission from employees;

-- 8) Display the employee's name, department id who have the first name same as another employee in the same department
select first_name,department_id from employees
group by first_name,department_id
having count(first_name)>=2;

-- 9) Display the sum of salaries of the employees working under each Manager.
select manager_id, sum(salary) from employees where manager_id is not null group by manager_id;

-- 10) Select the Managers name, the count of employees working under and the department ID of the manager. 
create view manager_count as
select manager_id,count(employee_id) as employee_count from employees
group by manager_id;
select concat(e.first_name,' ',e.last_name) as manager_name,m.* from employees e right join manager_count m
on e.employee_id = m.manager_id 
where e.employee_id = m.manager_id;

-- 11) Select the employee name, department id, and the salary. 
-- Group the result with the manager name and the employee last name should have second letter 'a! 
create view manager_names as
select concat(e.first_name,' ',e.last_name) as manager_name,m.* from employees e right join manager_count m
on e.employee_id = m.manager_id 
where e.employee_id = m.manager_id; 
select concat(e.first_name,' ',e.last_name) as employee_name,e.department_id,e.salary from employees e join manager_names m
on e.manager_id = m.manager_id
where last_name like '_a%'
group by m.manager_name;

-- 12) Display the average of sum of the salaries and group the result with the department id.
-- Order the result with the department id. 
select avg(salary),department_id as avg_of_salary from employees group by department_id order by department_id ;

-- 13) Select the maximum salary of each department along with the department id 
select department_id, max(salary) from employees group by department_id;

-- 14) Display the commission, if not null display 10% of salary, if null display a default value 1
select salary,
case 
    when commission_pct is not null then salary/10
    else'1'
end as commission
from employees;



-- ------------ PAGE_3 ---------------



-- 1. Write a query that displays the employee's last names only from the string's 2-5th
-- position with the first letter capitalized and all other letters lowercase, Give each column an appropriate label.
select concat(upper(substr(last_name,2,1)),lower(substr(last_name,3,4))) as last_name from employees;

-- 2. Write a query that displays the employee's first name and last name along with a " in
-- between for e.g.: first name : Ram; last name : Kumar then Ram-Kumar. Also displays the month on which the employee has joined.
select concat(first_name,'-',last_name) as employee, monthname(hire_date) as joining_month from employees
where first_name like '%a%' and last_name like '%a%';

-- 3. Write a query to display the employee's last name and if half of the salary is greater than ten thousand
-- then increase the salary by 10% else by 11.5% along with the bonus amount of 1500 each. Provide each column an appropriate label. 
select last_name, 
case
when salary/2>10000 then (salary*10/100)+salary 
else (salary*11.5/100)+1500+salary
end as increased_salary
from employees;

-- 4. Display the employee ID by Appending two zeros after 2nd digit and 'E' in the end, department id,
-- salary and the manager name all in Upper case, if the Manager name consists of 'z' replace it with '$! 
select concat(substr(employee_id,1,2),'00',substr(employee_id,3,1),'E') as employee_id,department_id,salary from employees;

-- 5. Write a query that displays the employee's last names with the first letter capitalized and all other letters lowercase, and the length
-- of the names, for all employees whose name starts with J, A, or M. Give each column an appropriate label. Sort the results by the employees' last names
create view len as
select concat(upper(substr(last_name,1,1)),lower(substr(last_name,2))) as last_name, 
case 
	when substr(last_name,1,1)='A'or substr(last_name,1,1)='J' or substr(last_name,1,1)='M' then length(last_name)
    end as length_last_name
 from employees order by last_name;
 select last_name,length_last_name from len
 where length_last_name is not null;
 
 -- 6. Create a query to display the last name and salary for all employees. Format the salary to
 -- be 15 characters long, left-padded with $. Label the column SALARY 
 select last_name, LPAD(salary,15,'$') AS "SALARY" from employees;

-- 7. Display the employee's name if it is a palindrome 
select 
case 
when substr(first_name,1)=reverse(first_name) then first_name 
end as first_name 
from employees;

-- 8. Display First names of all employees with initcaps. 
select concat(upper(substr(first_name,1,1)),lower(substr(first_name,2))) as first_name from employees;

-- 9. From LOCATIONS table, extract the word between first and second space from the STREET ADDRESS column. 
select substring_index(street_address," ",2) from locations;

-- 10. Extract first letter from First Name column and append it with the Last Name. Also add "@systechusa.com" at the end.
-- Name the column as e-mail address. All characters should be in lower case. Display this along with their First Name. 
select lower(concat(substr(first_name,1,1),last_name,'@systechusa.com')) as e_mail_address from employees;

-- 11. Display the names and job titles of all employees with the same job as Trenna. 
select first_name,
case 
	when first_name is not null then 'Trenna'
end as job_title
from employees;

-- 12. Display the names and department name of all employees working in the same city as Trenna. 
select concat(first_name,last_name) as names, department_name from employees join departments on employees.department_id=departments.department_id;

-- 13. Display the name of the employee whose salary is the lowest. 
select concat(first_name,' ',last_name) as employee_name, min(salary) as lowest_salary from employees order by salary;

-- 14. Display the names of all employees except the lowest paid.
select first_name,salary from employees where salary!=(select min(salary) from employees);



-- ------------ PAGE_4 ---------------



-- 1. Write a query to display the last name, department number, department name for all employees.
select e.last_name,d.department_id as department_number,d.department_name from employees e join departments d
on e.department_id=d.department_id;

-- 2. Create a unique list of all jobs that are in department 40. Include the location of the department in the output. 
select job_id, location_id from employees join departments
on employees.department_id = departments.department_id
where employees.department_id = 40;

-- 3. Write a query to display the employee last name,department name,location id and city of all employees who earn commission. 
select a.last_name,a.commission_pct,b.department_name,b.location_id,c.city from employees a
join departments b
on a.department_id = b.department_id  
join locations c
on b.location_id = c.location_id
where commission_pct is not null;

-- 4. Display the employee last name and department name of all employees who have an 'a' in their last name 
select last_name, department_name from employees join  departments
on employees.department_id=departments.department_id where last_name like '%a%';

-- 5. Write a query to display the last name,job,department number and department name for all employees who work in ATLANTA. 
select a.last_name,b.job_title,c.department_id,c.department_name,d.city from employees a
join jobs b
on a.job_id = b.job_id
join departments c
on a.department_id = c.department_id
join locations d
on c.location_id = d.location_id
where city like ' ATLANTA';

-- 6. Display the employee last name and employee number along with their manager's last name and manager number. 
select a.employee_id 'Employee Id', a.last_name 'Employee Name', b.employee_id 'Manager Id', b.last_name 'Manager Name' from employees a
join employees b 
on a.manager_id = b.employee_id;

-- 7. Display the employee last name and employee number along with their manager's last name and manager number (including the employees who have no manager). 
select a.employee_id 'Employee Id', a.last_name 'Employee Name', b.employee_id 'Manager Id', b.last_name 'Manager Name',a.manager_id from employees a
join employees b 
on a.manager_id = b.employee_id or a.manager_id is null;

-- 8. Create a query that displays employees last name,department number,and all the employees who work in
-- the same department as a given employee. 
select a.last_name,b.department_id from employees a
join departments b
on a.department_id = b.department_id
where b.department_id = a.department_id;

-- 9. Create a query that displays the name,job,department name,salary,grade for all employees.
-- Derive grade based on salary(>=50000=A, >=30000=B,<30000=C) 
select concat(first_name,' ',last_name) as e_name, job_title,salary,
case 
	when salary >=50000 then 'A'
    when salary >=30000 then 'B' 
    when salary <30000 then 'C' 
    end as grade
from employees join jobs on employees.job_id=jobs.job_id join departments on employees.department_id=departments.department_id;

-- 10. Display the names and hire date for all employees who were hired before their managers along withe their manager names and hire date.
-- Label the columns as Employee name, emp_hire_date,manager name,man_hire_date
select a.employee_id 'Employee Id', a.last_name 'Employee Name',a.hire_date as emp_hire_date, b.employee_id 'Manager Id', b.last_name 'Manager Name',b.hire_date as man_hire_date
from employees a join employees b 
on a.manager_id = b.employee_id;



-- ------------ PAGE_5 ---------------



-- 1. Write a query to display the last name and hire date of any employee in the same department as SALES.
select last_name,hire_date from employees join departments
on employees.department_id=departments.department_id
where department_name='sales';

-- 2. Create a query to display the employee numbers and last names of all employees who
-- earn more than the average salary. Sort the results in ascending order of salary. 
select employee_id as employee_number, last_name,salary from employees
where salary>(select avg(salary) from employees)
order by salary; 

-- 3. Write a query that displays the employee numbers and last names of all employees who
-- work in a department with any employee whose last name contains a' u 
select employee_id, last_name from employees
where department_id in (select department_id from employees where last_name like '%u%');

-- 4. Display the last name, department number, and job ID of all employees whose department location is ATLANTA. 
 select a.last_name,b.job_id,c.department_id,d.city from employees a
join jobs b
on a.job_id = b.job_id
join departments c
on a.department_id = c.department_id
join locations d
on c.location_id = d.location_id
where city like ' ATLANTA';

-- 5. Display the last name and salary of every employee who reports to FILLMORE. 
select employees.last_name,salary from employees join manager_names on employees.manager_id=manager_names.manager_id
where manager_names.manager_name like '%FILLMORE';

-- 6. Display the department number, last name, and job ID for every employee in the OPERATIONS department. 
select employees.department_id as department_number,last_name,job_id from employees join departments
on employees.department_id=departments.department_id
where departments.department_name LIKE '%operations%'; 

-- 7. Modify the above query to display the employee numbers, last names, and salaries of all
-- employees who earn more than the average salary and who work in a department with any employee with a 'u'in their name.  
select employee_id,last_name,salary from employees
where salary>(select avg(salary) from employees) and last_name like '%u%';

-- 8. Display the names of all employees whose job title is the same as anyone in the sales dept. 
select concat(first_name,' ',last_name) as employee_name ,job_title,department_name from employees join departments
on employees.department_id=departments.department_id 
join jobs
on employees.job_id=jobs.job_id
where jobs.job_title=departments.department_name or job_title like '%sale%';

-- 9. Write a compound query to produce a list of employees showing raise percentages,employee IDs, and salaries.
-- Employees in department 1 and 3 are given a 5% raise, employees in department 2 are given a 10% raise,
-- employees in departments 4 and 5 are given a 15% raise, and employees in department 6 are not given a raise. 
select first_name,employee_id,salary,
case
	when department_id in (10,30) then (salary*5/100) + salary
    when department_id=20 then (salary*10/100) + salary
    when department_id in (40,50) then (salary*15/100) + salary
    when department_id =60 then 'NOT GIVEN RAISE ' 
	end as raised_percent_salary from employees;
    
-- 10. Write a query to display the top three earners in the EMPLOYEES table. Display their last names and salaries. 
select last_name,salary from employees
order by salary desc limit 3;

-- 11. Display the names of all employees with their salary and commission earned. Employees
-- with a null commission should have O in the commission column
select concat(first_name,' ',last_name) as employee_name,salary,ifnull(salary*commission_pct,0) as commission from employees;

-- 12. Display the Managers (name) with top three salaries along with their salaries and department information.
select first_name,last_name,salary from employees
where manager_id is not null
order by salary desc limit 3;




   

