create database HR_DATA;
use HR_DATA;
select*from employee_hr_data;

-- 1. Write a SQL query to find those employees whose salary is higher than 9000. Return
-- first name, last name and department number and salary.

select first_name,last_name,Department_id,salary
from employee_hr_data
where salary>9000;


-- 2. Write a SQL query to identify employees who do not have a department number. Return
-- employee_id, first_name, last_name, email, phone_number, hire_date, job_id,
 -- salary,commission_pct, manager_id and department_id.

select employee_id,first_name,last_name,email,Phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id
from employee_hr_data
WHERE DEPARTMENT_ID IS NULL;

-- 3. Write a SQL query to find those employees whose first name does not contain the letter
-- ‘T’. Sort the result-set in ascending order by department ID. Return full name (first and
-- last name together), hire_date, salary and department_id.

select*
from employee_hr_data
where salary between 9000 and 12000
and COMMISSION_PCT is not null;

-- 4. Write a SQL query to find those employees who earn between 9000 and 12000 (Begin
-- and end values are included.) and get some commission. Return all fields.

select concat(first_name,' ' ,last_name) as full_name,hire_date,salary,department_id
from employee_hr_data
where first_name not like'%t%'
order by DEPARTMENT_ID;

-- 5. Write a SQL query to find those employees who do not earn any commission. Return full
-- name (first and last name), and salary. 

select concat(first_name,' ', last_name) as full_name,salary
from employee_hr_data
where COMMISSION_PCT=0;

-- 6. Write a SQL query to find those employees who work under a manager. Return full name
-- (first and last name), salary, and manager ID. 

select concat(first_name,' ', last_name) as full_name,salary,manager_id
from employee_hr_data
where manager_id not like 0;

-- 7. Write a SQL query to find employees whose first names contain the letters F, T, or M.
-- Sort the result-set in descending order by salary. Return all fields

select* from employee_hr_data
where FIRST_NAME like '%f%' or FIRST_NAME like '%t%' or FIRST_NAME like '%m%';

-- 8. Write a SQL query to find those employees who earn above 12000 or the seventh
-- character in their phone number is 3. Sort the result-set in descending order by first
-- name. Return full name (first name and last name), hire date, commission percentage,
-- email, and telephone separated by '-', and salary.  
select concat(first_name,' ', last_name) as full_name,hire_date,commission_pct,email,replace(phone_number,'.','-') as telephone
from employee_hr_data 
where salary>12000 
OR
phone_number like '______3%';

-- 9. Write a SQL query to find those employees whose first name contains a character 's' in
-- the third position. Return first name, last name and department id. 

select first_name,last_name,department_id
from employee_hr_data
where  first_name like '___s%';

--  10. Write a SQL query to find those employees who worked more than two jobs in the past.
-- Return employee id.

select employee_id
from job_history_hr_data
group by EMPLOYEE_ID
having count(*) >=2;

-- 11. Write a SQL query to count the number of employees, the sum of all salary, and
-- difference between the highest salary and lowest salaries by each job id. Return job_id,
-- count, sum, salary_difference.

select job_id,count(*),sum(salary),max(salary)-min(salary) as salary_difference
from employee_hr_data
group by job_id;

-- 12. Write a SQL query to find each job ids where two or more employees worked for more
-- than 300 days. Return job id.

select job_id
from job_history_hr_data
where datediff(end_date,start_date)>300
group by JOB_ID
having count(*)>=2;

-- 13. Write a SQL query to count the number of employees worked under each manager.
-- Return manager ID and number of employees.

select manager_id, count(*) 
from employee_hr_data
group by manager_id;

-- 14. Write a SQL query to calculate the average salary of employees who receive a
-- commission percentage for each department. Return department id, average salary.

select department_id,avg(salary)
from employee_hr_data
where COMMISSION_PCT is not null
group by DEPARTMENT_ID;

-- 15. Write a SQL query to find the departments where more than ten employees receive
-- commissions. Return department id.

select department_id
from employee_hr_data
where commission_pct is not null
group by DEPARTMENT_ID
having count(COMMISSION_PCT)>10;

-- 16. Write a SQL query to find those job titles where maximum salary falls between 10000
-- and 15000 (Begin and end values are included.). Return job_title, max_salarymin_
-- salary.

select job_title,max_salary-min_salary as salary_difference
from jobs_hr_data
where MAX_SALARY between 10000 and 15000;

-- 17. Write a SQL query to find details of those jobs where the minimum salary exceeds 9000.
-- Return all the fields of jobs

select*
from jobs_hr_data
where MIN_SALARY>9000;

-- 18 Write a SQL query to find those employees who work in the same department as ‘Clara’.
-- Exclude all those records where first name is ‘Clara’. Return first name, last name and
-- hire date.

select first_name,last_name,hire_date
from employee_hr_data 
where DEPARTMENT_ID=(select DEPARTMENT_ID from employee_hr_data where first_name like '%clara%' )
and FIRST_NAME !='clara';


-- 19. Write a SQL query to find those employees who earn more than the average salary and
-- work in the same department as an employee whose first name contains the letter 'J'.
-- Return employee ID, first name and salary.


select first_name,employee_id,salary
from employee_hr_data
where salary > (select avg(salary) from employee_hr_data) and department_id in (select DEPARTMENT_ID from employee_hr_data where FIRST_NAME like "%J%");

-- 20. Write a query to display the employee id, name ( first name and last name ) and the job
-- id column with a modified title SALESMAN for those employees whose job title is
-- ST_MAN and DEVELOPER for whose job title is IT_PROG.


select concat(first_name,' ', last_name) as full_name, employee_id,job_id,
case
when job_id like '%ST_MAN%' then 'salesman'
when job_id like '%IT_PROG%' then 'developer'
else 'other'
end job_modify_id
from employee_hr_data;

-- 21 Write a SQL query to find the first name, last name, department, city, and state
-- province for each employee.

select e.first_name, e.last_name, d.department_name,l.city, l.state_province
from employee_hr_data e 
join department_hr_data d on e.department_id = d.department_id
join location_hr_data l on l.location_id = d.location_id;

-- 22 Write a SQL query to find the first name, last name, salary, and job grade for all
-- employees

select e.first_name,e.last_name,e.salary,j.grade_level
from employee_hr_data e
join  job_grades_hr_data j 
on e.salary between j.lowest_sal and j.highest_sal;

-- 23 Write a SQL query to find all those employees who work in department ID 80 or 40.
-- Return first name, last name, department number and department name

select e.first_name,e.last_name,d.department_id,d.department_name
from employee_hr_data e
join department_hr_data d on e.department_id=d.department_id
where d.department_id in(80,40);

-- 24 Write a SQL query to find those employees whose first name contains the letter ‘z’.
-- Return first name, last name, department, city, and state province.

select e.first_name,e.last_name,d.department_id,l.city,l.state_province
from employee_hr_data e 
join department_hr_data d on e.department_id=d.department_id
join location_hr_data l on l.location_id=d.LOCATION_ID
where e.first_name like "%z%";

-- 25 Write a SQL query to find all employees who joined on 1st January 1993 and left on
-- or before 31 August 1997. Return job title, department name, employee name, and
-- joining date of the job.

select concat(e.first_name,' ' , e.last_name) as employee_name,d.department_name,j.job_title,h.start_date
from employee_hr_data e 
join department_hr_data d on e.department_id= d.department_id
join job_history_hr_data h on d.department_id=h.department_id
join jobs_hr_data  j  on j.job_id=h.job_id
where h.start_date= '1993-01-1' and h.end_date <= '1997-07-31';

-- 26 Write a SQL query to calculate the difference between the maximum salary of the job
-- and the employee's salary. Return job title, employee name, and salary difference.

select concat(e.first_name,' ' , e.last_name) as employee_name ,j.job_title, (j.max_salary-e.salary) as salary_difference
from employee_hr_data e join jobs_hr_data j ;

-- 27  Write a SQL query to find the department name and the full name (first and last name)
-- of the manager.

select concat(e.first_name,' ', e.last_name) as full_name , d.department_name
from employee_hr_data e 
join department_hr_data d on d.manager_id = e.manager_id
where e.manager_id <> 0;

-- 28 Write a SQL query to find the department name, full name (first and last name) of the
-- manager and their city.

select concat(e.first_name,' ', e.last_name) as full_name , d.department_name,l.city
from employee_hr_data e  
join  department_hr_data d on d.department_id=e.department_id
join location_hr_data l on d.location_id=l.location_id;

-- 29  Write a SQL query to find out the full name (first and last name) of the employee with
-- an ID and the name of the country where he/she is currently employed.

select concat(e.first_name,' ', e.last_name) as full_name , c.country_id,c.country_name
from employee_hr_data e
join department_hr_data d on e.DEPARTMENT_ID=d.department_id
join  location_hr_data l on d.location_id=l.location_id
join  countries_hr_data c on l.country_id=c.country_id;

-- 14. Write a SQL query to calculate the average salary of employees who receive a
-- commission percentage for each department. Return department id, average salary.
select department_id,avg(salary)
from employee_hr_data
where COMMISSION_PCT is not null
group by department_id;

--  10. Write a SQL query to find those employees who worked more than two jobs in the past.
-- Return employee id.
select employee_id
from job_history_hr_data
group by employee_id
having count(EMPLOYEE_ID)>=2;


-- 8. Write a SQL query to find those employees who earn above 12000 or the seventh
-- character in their phone number is 3. Sort the result-set in descending order by first
-- name. Return full name (first name and last name), hire date, commission percentage,
-- email, and telephone separated by '-', and salary.  
select concat(first_name, ' ', last_name),hire_date,commission_pct,email,replace(phone_number,'.','-') as telephone
from employee_hr_data
where salary>12000
or
phone_number like '%______3%';


-- 12. Write a SQL query to find each job ids where two or more employees worked for more
-- than 300 days. Return job id.

select job_id
from job_history_hr_data
where datediff(end_date,start_date)>300
group by job_id
having count(*)>=2;


-- 24 Write a SQL query to find those employees whose first name contains the letter ‘z’.
-- Return first name, last name, department, city, and state province.
select e.first_name,e.last_name,e.department_id,l.city,l.state_province
from employee_hr_data e
join department_hr_data d
on e.department_id=d.department_id
join location_hr_data l
on l.location_id=d.LOCATION_ID
where first_name like '%z%';

-- 29  Write a SQL query to find out the full name (first and last name) of the employee with
-- an ID and the name of the country where he/she is currently employed.
select concat(e.first_name,' ',e.last_name) as full_name,c.country_id,c.country_name
from employee_hr_data e
join department_hr_data d
on e.department_id=d.department_id
join location_hr_data l
on l.location_id-d.LOCATION_ID
join countries_hr_data c
on c.country_id=l.country_id;