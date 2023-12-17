use adventureworks;



-- ----------adventureworks assignment----------



-- 1. Write a query to display employee numbers and employee name (first name, last name) of all the sales employees who
-- received an amount of 2000 in bonus. 
select EmployeeID, concat(first_name,' ',last_name) as employee_name from employee;

-- 2. Fetch address details of employees belonging to the state CA. If address is null, provide default value N/A.
 select ifnull(concat(AddressLine1,' ',city), null) as address from address 
 where StateProvinceID= 79;
 select * from countryregion where Name like 'CA%';
 
 -- 3. Write a query that displays all the products along with the Sales OrderID even if an order
-- has never been placed for that product. 
select product.Name, salesorderdetail.SalesOrderID from product left join salesorderdetail
on product.ProductID=salesorderdetail.ProductID;

-- 4. Find the subcategories that have at least two different prices less than $15. 
 create table subat15 select productsubcategory.name, product.listprice as price from productsubcategory 
join product 
on productsubcategory.ProductSubcategoryID=product.ProductSubcategoryID 
where listprice<15 
group by listprice; 
select * from subat15 
group by name having count(price) >= 2;

-- 5. A. Write a query to display employees and their manager details. Fetch employee id, employee first name, and manager id, manager name.
-- B. Display the employee id and employee name of employees who do not have manager. 
 select EmployeeID, ManagerID from employee;
select EmployeeID, ManagerID from employee 
where EmployeeID not in (select ManagerID from employee group by ManagerID) 
group by EmployeeID; 
select EmployeeID, ManagerID from employee 
where ManagerID is null;

-- 6. A. Display the names of all products of a particular subcategory 15 and the names of their vendors.
-- B. Find the products that have more than one vendor
select product.productsubcategoryid,productvendor.ProductID,productvendor.VendorID,vendor.Name from vendor 
join productvendor on productvendor.VendorID=vendor.VendorID
join product on productvendor.productid = product.productid 
where product.ProductSubcategoryID=15;
select ProductID, count(VendorID) as num_vendor from productvendor group by ProductID having count(VendorID)>1;

-- 7. Find all the customers who do not belong to any store.
select * from customer left join store
on customer.CustomerID=store.CustomerID
where store.CustomerID is null;

-- 8. Find sales prices of product 718 that are less than the list price recommended for that product.


-- 9. Display product number, description and sales of each product in the year 2001
 select product.ProductNumber, Description from product 
join productdescription 
on product.ProductID=productdescription.ProductDescriptionID;

-- 10. Build the logic on the above question to extract sales for each category by year.
-- Fetch Product Name, Sales_2001, Sales_2002, Sales_2003.
 






































