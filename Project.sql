/*Create a database named employee, then import data_science_team.csv proj_table.csv and emp_record_table.csv 
into the employee database from the given resources.*/
create database employee;
use employee;

select * from data_science_team;
select * from emp_record_table;
select * from proj_table;

/*Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record table,
 and make a list of employees and details of their department.*/
select emp_id,first_name,last_name,gender,dept from emp_record_table order by first_name;

/*Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: 
less than two
greater than four 
between two and four*/
select emp_id,first_name,last_name,gender,dept,emp_rating from emp_record_table where emp_rating<2;
select emp_id,first_name,last_name,gender,dept,emp_rating from emp_record_table where emp_rating>4;
select emp_id,first_name,last_name,gender,dept,emp_rating from emp_record_table where emp_rating between 2 and 4;

/*Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the 
Finance department from the employee table and then give the resultant column alias as NAME.*/
select concat(first_name,' ',last_name) as Name from emp_record_table where dept='Finance';

/*Write a query to list only those employees who have someone reporting to them.
 Also, show the number of reporters (including the President).*/
select manager_id,first_name,last_name,role,count(emp_id) as emp_count 
from emp_record_table group by manager_id order by manager_id;

/*Write a query to list down all the employees from the healthcare and finance departments using union. 
Take data from the employee record table.*/
select emp_id,first_name,last_name,gender,dept from emp_record_table where dept='healthcare'
union 
select emp_id,first_name,last_name,gender,dept from emp_record_table where dept='finance';

/*Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT,and EMP_RATING grouped by dept.
Also include the respective employee rating along with the max emp rating for the department.*/
select emp_id,first_name,last_name,role,dept,emp_rating,max(emp_rating) from emp_record_table group by dept;

/*Write a query to calculate the minimum and the maximum salary of the employees in each role.
 Take data from the employee record table.*/
select emp_id,first_name,last_name,role,
max(salary) as Max_salary,min(salary) as min_salary 
from emp_record_table group by role;

/*Write a query to assign ranks to each employee based on their experience. 
Take data from the employee record table.*/
select emp_id,first_name,last_name,exp,rank() over(order by exp desc) as Rank_exp from emp_record_table;

/*Write a query to create a view that displays employees in various countries whose salary is more than six thousand. 
Take data from the employee record table.*/
create view emp_sal as
select emp_id,first_name,last_name,country,salary from emp_record_table
where salary> 6000 group by country order by salary;
 
 select * from emp_sal;
 
/*Write a nested query to find employees with experience of more than ten years. 
Take data from the employee record table.*/
select * from emp_record_table where exp in
(select exp from  emp_record_table where exp> 10);

/*Write a query to create a stored procedure to retrieve the details of the 
employees whose experience is more than three years. 
Take data from the employee record table.*/
delimiter \
create procedure emp_exp() 
begin
select * from emp_record_table where exp>10 order by exp desc;
end \

call emp_exp();


/*Create an index to improve the cost and performance of the query to find the 
employee whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan.*/
create index indx on emp_record_table(role);
explain select * from emp_record_table WHERE first_name = 'Eric';


/*Write a query to calculate the bonus for all the employees, 
based on their ratings and salaries (Use the formula: 5% of salary * employee rating).*/
select emp_id,salary,emp_rating,((salary*5/100)*emp_rating) as bonus FROM emp_record_table;

/*Write a query to calculate the average salary distribution based on the continent and country. \
Take data from the employee record table.*/
SELECT continent, avg(Salary) FROM emp_record_table group by continent;
SELECT country, avg(Salary) FROM emp_record_table group by country;

select continent,
(select avg(b.Salary) from emp_record_table b where a.continent = b.continent) as continentAvg,
country,
(select avg(c.Salary) from emp_record_table c where a.country = c.country) as countryAvg
FROM emp_record_table a
group by continent,country;

 
 