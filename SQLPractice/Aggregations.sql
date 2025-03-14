--It gives the No of employees in each department
Select department_id,count(*) as "Employees Count" from hr.EMPLOYEES
group by department_id;
--It return avg salary of Each department
select department_id,avg(salary) As Department_AvgSalary from hr.EMPLOYEES
group by department_id;

--it return the department wise who getting maximum and minimum slary
select department_id,max(salary) as Max_salary,min(salary) as min_salary from hr.EMPLOYEES
group by department_id;

--It returns the Department wise Total salary of employees
select department_id,sum(salary) as Total_salary from hr.EMPLOYEES
group by department_id;
--No of employees in each designation
select job_id,count(*) as Employees_count
from hr.EMPLOYEES group by job_id;

--It returns the job_id wise avg salary
select job_id,avg(salary) as Avg_salary from hr.EMPLOYEES
group by job_id ;
--return the maximum salary of an employee in each job_id
select job_id,max(salary) as Max_salary
from hr.EMPLOYEES group by job_id;

--it gives Minmum salary of an employees in each job_id
select job_id,min(salary) as min_salary
from hr.EMPLOYEES group by job_id;
---It returns the  the total salary ofemployees in  each job_id
select job_id,sum(salary) as Total_salary
 from hr.EMPLOYEES group by job_id;
--it returns howmany employees joined in every year
select extract(year from hire_date) as hiring_year,count(*) as Employes_hire
from hr.EMPLOYEES group by extract(year from hire_date) order by hiring_year;
--It return the location wise total salary of employees while joing the employees table with departments table to get the location
select d.location_id,sum(e.salary) as Total_salary from hr.EMPLOYEES e
join hr.departments d  on e.department_id=d.department_id
group by d.location_id;
--It return how many employees reported to each manager
select manager_id,count(*) as Team_size from hr.EMPLOYEES
where manager_id is not null
group by manager_id;
--It return who are the getting tha highest salary among of  all employees reporting to  manger 
select manager_id,max(salary) as max_salary from hr.EMPLOYEES
where manager_id is not null
group by manager_id;

---it return the avg salary of an employees under his manager

select manager_id,avg(salary) as Avg_salary from hr.EMPLOYEES
where manager_id is not null
group by manager_id;

--It return every month how many employees are hired in a particular company

select extract(month from hire_date) as hiring_month,count(*) as Num_of_employees
from hr.EMPLOYEES group by extract(month from hire_date)
order by hiring_month;
---Which department has the highest total salary among all employees
select department_id,sum(salary) as Total_salary from hr.EMPLOYEES
group by department_id order by Total_salary desc
fetch first 1 row only;
--it return which job getting higest avg salary
select job_id,avg(salary) as avg_salary from hr.EMPLOYEES
group by job_id order by avg_salary
fetch first 1 row only;
--It return how many employees reporting in each city while joing empoyees,departments and location table to get the city
select l.city,count(*) as employees_count from hr.employees e join hr.departments d on e.department_id=d.department_id
join hr.locations l on
l.location_id=d.location_id group by l.city;

--it returns how many employees in each department getting the commission
select department_id,count(*) as "employees_with_commission" from hr.EMPLOYEES
where COMMISSION_PCT is not null
group by department_id;
---It returns who the toatal salaries of an employees in each department who are not recivng commissions
select department_id,sum(salary) as Toal_salary_without_commission
from hr.EMPLOYEES
where COMMISSION_PCT is null 
group by department_id;


-- Each product how much sales happens
select prod_id,count(*) as "num_of_trxns" from sh.sales group by prod_id;
-- avg amount sold in each product
select prod_id,avg(amount_sold) as avg_sale from sh.SALES
group by prod_id;
-- what is the maximum and minumut amounts getting in each product
select prod_id,max(amount_sold) as max_sale,min(amount_sold) as min_sale from sh.SALES
group by prod_id;
-- it retuens what is total revenue generated from each product
select prod_id,sum(amount_sold) as Total_revenue from sh.SALES
group by prod_id  order by Total_revenue;
-- total no of times customer happens purching each product
select cust_id,count(*) from sh.SALES
group by cust_id;

-- It return avg amount spent by each customer
select cust_id,avg(amount_sold) as avg_spent_amount
from sh.SALES
group by cust_id;
-- it returns maximum product price  purched each customer
select cust_id,max(amount_sold) as max_amount_spent
from sh.SALES
group by prodcust_id;
-- it returns mimmum product price  purched each customer
select cust_id,min(amount_sold) as min_amount_spend
from sh.SALES
group by cust_id;




-- Each product how much sales happens
select prod_id,count(*) as "num_of_trxns" from sh.sales group by prod_id;
-- avg amount sold in each product
select prod_id,avg(amount_sold) as avg_sale from sh.SALES
group by prod_id;
-- what is the maximum and minumut amounts getting in each product
select prod_id,max(amount_sold) as max_sale,min(amount_sold) as min_sale from sh.SALES
group by prod_id;
-- it retuens what is total revenue generated from each product
select prod_id,sum(amount_sold) as Total_revenue from sh.SALES
group by prod_id  order by Total_revenue;
-- total no of times customer happens purching each product
select cust_id,count(*) from sh.SALES
group by cust_id;

-- It return avg amount spent by each customer
select cust_id,avg(amount_sold) as avg_spent_amount
from sh.SALES
group by cust_id;
-- it returns maximum product price  purched each customer
select cust_id,max(amount_sold) as max_amount_spent
from sh.SALES
group by prodcust_id;
-- it returns mimmum product price  purched each customer
select cust_id,min(amount_sold) as min_amount_spend
from sh.SALES
group by cust_id;

--total revenue genarted based customer location
select cust_city,sum(amount_sold) as Total_revenue from sh.sales s join sh.customers c on s.cust_id=c.CUST_ID
group by cust_city;

-- It return the total number trnsactions made by each region by joining sales,customer and countries table
select country_region,count(*) as total_sales_trxns from  sh.sales s join sh.customers c on s.cust_id=c.cust_id
join sh.countries cr on cr.country_id = c.country_id group by country_region;
-- It returns total revenue generated from each region  by joingc sales table with  customers table and countries table 
select country_region,sum(amount_sold) as "Total revenue" from sh.sales s join sh.customers c on s.cust_id=c.cust_id
join sh.countries cr on cr.country_id = c.country_id group by country_region;
-- avg revenue genreated from each region while joining sales,customers and countries tables
select country_region,avg(amount_sold) as avg_sale from sh.sales s join sh.customers c on s.cust_id=c.cust_id
join sh.countries cr on cr.country_id=c.country_id group by country_region;
-- It returns monthly sales count
select extract(month from time_id) sale_month ,count(*) as sales_per_month from sh.sales 
group by extract(month from time_id) order by sales_per_month desc;

-- total revenue generated by each month 
select extract(month from time_id) as sale_month,sum(amount_sold) as total_revenue_per_month
from sh.sales group by extract(month from time_id) order by total_revenue_per_month desc;
--It gives which product getting higest revenue
select prod_id,sum(amount_sold) Higest_revenue from sh.sales group by prod_id
order by Higest_revenue desc fetch first 1 row only;
 -- it return which product happens more slaes
 select prod_id,count(*) as prod_count from sh.sales group by prod_id
order by prod_count desc  fetch first 1 row only;
-- It returns which customer spending more amount
select cust_id,sum(amount_sold) as total_spending_amount from sh.sales group by cust_id order by total_spending_amount desc
fetch first 1 row only
-- 18. Find the total revenue per sales channel (e.g., online vs. offline).  
-- 19. Count the number of sales for each payment method.  
-- 20. Find the total revenue generated per payment method.  
