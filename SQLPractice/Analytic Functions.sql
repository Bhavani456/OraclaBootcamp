--This query ranks employees within each department based on their salary in descending order.

select department_id,employee_id,salary,
rank()over(partition by department_id order by salary desc) as ranked_salalry
from hr.employees;

--It returns the top 3 highest employee salaries in each department.
select department_id,employee_id,salary from
(select employee_id,department_id,salary,rank()over(partition by department_id order by salary desc) as salary_rank from hr.employees )
where salary_rank<=3;
--It returns the second-highest salary for employees in each department
with ranked_salary as (select department_id,employee_id,salary,dense_rank()over(partition by department_id order by salary desc)as rank_salary from hr.employees)

select * from ranked_salary where rank_salary=2;

--It returns the second-highest salary for employees in each department.
select department_id,employee_id,salary from (select department_id,employee_id,salary,
dense_rank()over(partition by department_id order by salary desc) as ranked_salary from hr.employees)
where ranked_salary=2;
--it return the cumulative salary of employees while sorting the data by hire date
select  department_id,employee_id,salary,sum(salary) over (order by hire_date desc) as cumulative_salalry
from hr.employees;
--it assigns a unique number to each employee within their department,sorted by emp_id
select department_id,employee_id,row_number()over(partition by department_id order by employee_id) as unique_num
from hr.employees;

--it results the salary difference between each employee with second highest paid employee
select employee_id,salary,lead(salary)over(order by salary desc)-salary as salary_diff
from hr.EMPLOYEES;
--it returns the what was the previous month salary of each employee
select employee_id,salary,lag(salary) over (PARTITION by employee_id order by hire_date) as prev_month_salalry
from hr.employees;


--it results sallary difference betwwen each employee with current and presnt salalry
select employee_id,salary,salary-lag(salary)over(partition by employee_id order by hire_date) as current_prev_salarydiff
from hr.employees;

--if employees earned more than the previous month it return salalry increase otherwise decresed

select employee_id,salary,lag(salary)over(partition by employee_id order by salary),
case when salary>lag(salary)over(partition by employee_id order by hire_date)
then 'Increase' else 'Decresed' end as salalry_trend from hr.employees;

--It gives  which employee earns more salary then other employees within their  department

with ranked_salaries as (select department_id,employee_id,salary,rank()over(partition by department_id order by salary desc) as ranked_salary
from hr.employees)
select department_id,employee_id,salary from ranked_salaries where ranked_salary=1;

--It calculates the cumulative sum of employee salaries within theire department
select department_id,employee_id,salary,sum(salary) over(partition by department_id order by hire_date) as sum_salalry
from hr.employees;

--It ghives the ranks to employees based on their experince range in each department
select department_id,employee_id,salary,rank()over(partition by department_id order by hire_date asc) as exp_range
from hr.EMPLOYEES;

--It return which department having most no of employees
with max_emp as 
(select department_id,employee_id, count(*)over(partition by department_id) as count_employees from hr.employees)

select department_id from max_emp group by department_id order by max(count_employees) desc
fetch first 1 row only;
--by using subquery filter the employees who are earning more then the department avg
select department_id,employee_id,salary from hr.EMPLOYEES e where 
salary>(select avg(salary) from hr.employees where department_id=e.department_id);

--query results the each employee salary how much it differ from the the department avg salalry
select department_id,employee_id,salary,
salary-avg(salary)over(partition by department_id) as avg_salary 
from hr.employees;
--It results which department hiring more number of employees
select department_id,count(*) as total_hired from hr.EMPLOYEES
group by department_id 
order by total_hired desc
fetch first 1 row only;

--How many employees hired in same year and month in each department 
select department_id,hire_date,salary,
count(*)over(partition by extract(year from hire_date),extract(month from hire_date)) as same_month_year_hirecount
from hr.employees;

--It returns employees who earn a  higher salary than the avg salary of employees reporting to their manger 

select manager_id,employee_id,salary from hr.employees e 
where salary>(select avg(salary) from hr.employees where manager_id=e.manager_id and manager_id is not null);

--Calculate the moving average salary over the last 3 employees ordered by hire date.
-- Uses AVG() OVER() with ROWS BETWEEN for moving average calculation.
select employee_id, hire_date, salary, 
avg(salary)over(order by hire_date rows between 2 preceding and current row) as avg_salary 
from hr.employees;

