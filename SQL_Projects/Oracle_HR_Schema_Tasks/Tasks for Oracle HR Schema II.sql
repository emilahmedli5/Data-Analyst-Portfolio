--Restricting and Sorting Data
-- 1) Employees table. Retrieve a list with information about all employees.
select * from hr.EMPLOYEES


-- 2) Employees table. Retrieve a list of all employees with the name 'David'.
select FIRST_NAME from hr.EMPLOYEES
where FIRST_NAME='David'


-- 3) Employees table. Retrieve a list of all employees with job_id = 'IT_PROG'.
select FIRST_NAME from hr.EMPLOYEES
where JOB_ID='IT_PROG'


-- 4) Employees table. Retrieve a list of all employees from department 50 with salary greater than 4000.
select FIRST_NAME from hr.EMPLOYEES
where department_id=50
and salary>4000


-- 5) Employees table. Retrieve a list of all employees from departments 20 and 30.
select FIRST_NAME from hr.EMPLOYEES
where department_id=30
or department_id=20


-- 6) Employees table. Retrieve a list of all employees whose name ends with the letter 'a'.
select FIRST_name from hr.EMPLOYEES
where FIRST_NAME like '%a'


-- 7) Employees table. Retrieve a list of all employees from departments 50 and 80 who have a bonus (commission_pct is not null).
select FIRST_NAME from hr.EMPLOYEES
where (department_id=50 or department_id=80)
and commission_pct is not null


-- 8) Employees table. Retrieve a list of all employees whose name contains at least two letters 'n'.
select FIRST_name from hr.EMPLOYEES
where FIRST_NAME like '%n%n%'


-- 9) Employees table. Retrieve a list of all employees whose name length is greater than 4 characters.
select FIRST_NAME from hr.EMPLOYEES
where length(FIRST_NAME)>4


-- 10) Employees table. Retrieve a list of all employees whose salary is between 8000 and 9000 (inclusive).
select *from hr.EMPLOYEES
where salary between 8000 and 9000 

select *from hr.EMPLOYEES
where salary>8000 and salary<=9000 


-- 11) Employees table. Retrieve a list of all employees whose name contains the symbol '%'.
select FIRST_name from hr.EMPLOYEES
where FIRST_NAME like '%\%%'


-- 12) Employees table. Retrieve a list of all manager IDs.
select manager_id from hr.EMPLOYEES


-- 13) Employees table. Retrieve a list of employees with their positions in the format: Donald(sh_clerk).
select FIRST_name,job_id from hr.EMPLOYEES






-- Using Single-Row Functions to Customize Output

-- 1) Employees table. Retrieve all employees whose name length is greater than 10 characters.
select FIRST_NAME from hr.EMPLOYEES
where length(FIRST_NAME)>10


-- 2) Employees table. Retrieve all employees whose name contains the letter 'b' (case insensitive).
select FIRST_name from hr.EMPLOYEES
where FIRST_NAME like '%b%'


-- 3) Employees table. Retrieve all employees whose name contains at least two letters 'a'.
select FIRST_name from hr.EMPLOYEES
where FIRST_NAME like '%a%a%'


-- 4) Employees table. Retrieve all employees whose salary is a multiple of 1000.
select FIRST_name,salary from hr.EMPLOYEES
where salary like '%000'


-- 5) Employees table. Extract the first 3 digits of the employee phone number if it is in the format XXX.XXX.XXXX.
select PHONE_NUMBER,substr(PHONE_NUMBER,1,3)
from hr.employees


-- 6) Departments table. Retrieve the first word from department names that contain more than one word.
select DEPARTMENT_NAME,
SUBSTR(Department_name,1,INSTR(DEPARTMENT_NAME, ' ')) 
from hr.departments
where department_name like '% %'


-- 7) Employees table. Retrieve employee names without the first and last letters.
select First_NAME,
SUBSTR(First_name,2,(length(FIRST_NAME)-2)) as first_word
from hr.employees


-- 8) Employees table. Retrieve all employees whose name ends with 'm' and name length is greater than 5.
select FIRST_name from hr.EMPLOYEES
where length(first_name)>5 and 
FIRST_NAME like '%m'


-- 9) DUAL table. Retrieve the date of the next Friday.
select NEXT_DAY(sysdate, 'Friday') from dual


-- 10) Employees table. Retrieve employees who have worked in the company for more than 17 years.
select first_name,hire_date,current_date,
(current_date-hire_date)/365 as work_interval
from hr.employees
where round((current_date-hire_date)/365)>17


-- 11) Employees table. Retrieve employees whose phone number ends with an odd digit and is in the format XXX.XXX.XXXX.
select first_name,phone_number
from hr.employees
where mod(to_number(substr(phone_number,length(phone_number),1)),2)!=0


-- 12) Employees table. Retrieve employees whose job_id contains at least 3 characters after '_' and that substring is not 'CLERK'.
Select First_Name,Job_Id,
Substr(Job_Id,Instr(Job_Id,'_',1)+1,Length(Job_Id)) as sub_str
From Hr.Employees
Where Substr(Job_Id,Instr(Job_Id,'_',1)+1,Length(Job_Id))!='CLERK'
And Length(Substr(Job_Id,Instr(Job_Id,'_',1,Length(Job_Id))))>=3


-- 13) Employees table. Replace '.' with '-' in PHONE_NUMBER.
select PHONE_NUMBER,replace(Phone_number,'.','-')
from hr.employees






-- Using Conversion Functions and Conditional Expressions

-- 1) Employees table. Retrieve employees hired on the first day of any month.
SELECT first_name,hire_date,
    EXTRACT(DAY FROM hire_date) AS day_num
FROM hr.employees
where EXTRACT(DAY FROM hire_date)=1


-- 2) Employees table. Retrieve employees hired in 2008.
SELECT first_name,hire_date,
    EXTRACT(Year FROM hire_date) AS year_num
FROM hr.employees
where EXTRACT(YEAR FROM hire_date)=2008


-- 3) DUAL table. Display tomorrow’s date in the format: Tomorrow is Second day of January
SELECT 
    'Tomorrow is the ' ||
    TO_CHAR(SYSDATE + 1, 'DDth') ||
    ' day of ' ||
    TO_CHAR(SYSDATE + 1, 'Month')
FROM dual;


-- 4) Employees table. Display employees with hire date formatted as: 21st of June, 2007
SELECT 
    first_name,
    hire_date,
    TO_CHAR(hire_date, 'DD') || 
    CASE 
        WHEN EXTRACT(DAY FROM hire_date) IN (11, 12, 13) THEN 'th'
        WHEN MOD(EXTRACT(DAY FROM hire_date), 10) = 1 THEN 'st'
        WHEN MOD(EXTRACT(DAY FROM hire_date), 10) = 2 THEN 'nd'
        WHEN MOD(EXTRACT(DAY FROM hire_date), 10) = 3 THEN 'rd'
        ELSE 'th' 
    END || ' ' || 
    TO_CHAR(hire_date, 'Mon') || ', ' || 
    EXTRACT(YEAR FROM hire_date) AS full_hire_date_formatted
FROM hr.employees;


-- 5) Employees table. Retrieve employees with salary increased by 20%. Display salary with a dollar sign.
SELECT first_name,salary*1.2||'$'
FROM hr.employees


-- 6) Employees table. Retrieve employees hired in February 2007.
select first_name,hire_date
FROM hr.employees
where EXTRACT(YEAR FROM hire_date)=2007
and
EXTRACT(MONTH FROM hire_date) = 2


-- 7) DUAL table. Display current date plus: second, minute, hour, day, month, year.
select sysdate ,
to_char(sysdate,'SS'),
to_char(sysdate,'MI'),
to_char(sysdate,'HH24'),
to_char(sysdate,'DD'),
to_char(sysdate,'MM'),
to_char(sysdate,'YYYY')
from dual


-- 8) Employees table. Retrieve employees with total salary (salary + commission) formatted as: $24,000.00
select first_name,
'$'||TO_CHAR((salary+(salary*NVL(commission_pct,0))),'FM99,999.00') as total_salary
from hr.employees


-- 9) Employees table. Display whether each employee has a bonus (Yes/No).
select first_name,commission_pct,
case when commission_pct is not null then 'Yes'
else 'No' End
as Has_a_Bonus
from hr.employees


-- 10) Employees table. Display salary level:
-- a. < 5000 → Low level
-- b. 5000–9999 → Normal level
-- c. ≥ 10000 → High level
1.select salary,
case when salary<5000 then 'Low Level'
when salary between 5000 and 9999 then 'Normal Level'
when salary>=10000 then 'High Level'
End As Salary_Level
from hr.employees

2.select salary,
case when salary<5000 then 'Low Level'
when salary between 5000 and 9999 then 'Normal Level'
else 'High Level'
End As Salary_Level
from hr.employees


-- 11) Countries table. Show region by region_id without joins: 1-Europe, 2-America, 3-Asia, 4-Africa
select country_name ,region_id,
case when region_id=1 then 'Europe'
when region_id=2 then 'America'
when region_id=3 then 'Asia'
when region_id=4 then 'Africa'
end as region_name
from hr.countries








-- Reporting Aggregated Data Using Group Functions

-- 1) Employees table. Report by department_id: min salary, max salary, earliest hire date, latest hire date, employee count. Sort by employee count (descending).
select department_id,min(salary) as min_salary,max(salary) as max_salary,
min(hire_date) earliest_hire_date,max(hire_date)earliest_hire_date ,
count(employee_id)as number_of_employee
from hr.employees
group by department_id
order by count(employee_id) desc


-- 2) Employees table. Count employees whose names start with the same letter. Show only counts > 1. Sort by count.
select substr(first_name,1,1)first_letter,
count(employee_id)num_of_employees
from hr.employees
group by substr(first_name,1,1)
having count(employee_id)>1
order by count(employee_id)


-- 3) Employees table. Count employees in the same department earning the same salary.
select department_id,salary,
count(employee_id)num_of_employees
from hr.employees
group by department_id,salary


-- 4) Employees table. Report number of employees hired on each weekday. Sort by count.
SELECT 
    TO_CHAR(hire_date, 'Day') AS hire_day_of_week, 
    COUNT(employee_id) AS employee_count
FROM hr.employees
GROUP BY TO_CHAR(hire_date, 'Day')
ORDER BY employee_count


-- 5) Employees table. Report number of employees hired by year. Sort by count.
SELECT 
    Extract(YEar from hire_date) AS hire_year, 
    COUNT(employee_id) AS employee_count
FROM hr.employees
GROUP BY Extract(YEar from hire_date)
ORDER BY employee_count


-- 6) Employees table. Count departments that have employees.
select count(*) num_of_department
from (SELECT department_id,COUNT(employee_id) num_of_employees 
FROM hr.employees group by department_id having count(employee_id)>0)

SELECT COUNT(DISTINCT department_id) AS num_departments
FROM hr.employees;


-- 7) Employees table. List department_id with more than 30 employees.
SELECT department_id
FROM hr.employees group by department_id having count(employee_id)>30


-- 8) Employees table. List department_id and rounded average salary per department.
select department_id,round(avg(salary))average_salary from hr.employees
group by department_id


-- 9) Countries table. Show region_id where total number of letters in country_name exceeds 60.
select region_id,sum(length(country_name))total_num_of_letters from hr.countries
group by region_id having sum(length(country_name))>60


-- 10) Employees table. List department_id with multiple (>1) job_id values.
select department_id,count(job_id) num_of_jobs from hr.employees
group by department_id
having count(job_id)>1


-- 11) Employees table. List manager_id with more than 5 subordinates and total subordinate salary > 50000.
select manager_id,count(employee_id) num_of_subordinate,
sum(salary) total_salary from hr.employees
group by manager_id
having count(employee_id)>5
and sum(salary)>50000


-- 12) Employees table. List manager_id where average subordinate salary is between 6000 and 9000 and subordinates have no bonuses.
select manager_id,
avg(salary) avg_salary from hr.employees
where commission_pct is null
group by manager_id
having avg(salary) between 6000 and 9000


-- 13) Employees table. Get max salary among employees whose job_id ends with 'CLERK'.
select job_id,max(salary) from hr.employees
where job_id like '%CLERK'
group by job_id


-- 14) Employees table. Get the maximum value among departmental average salaries.
select max(avg_salary) from (select department_id,avg(salary)avg_salary from hr.employees
group by department_id)


-- 15) Employees table. Count employees with the same name length. Show only length > 5 and count > 20. Sort by name length.
select length(first_name) as len_name,
count(employee_id) num_of_emp from hr.employees
where length(first_name)>6
group by length(first_name)
having count(employee_id)>20





--Displaying Data from Multiple Tables Using Joins

--1)Employees, Departments, Locations, Countries, Regions. List regions and employee count per region.

select region_name,count(employee_id) from employees
left join departments
on employees.department_id=departments.department_id
left join locations
on departments.location_id=locations.location_id
left join countries
on locations.country_id=countries.country_id
left join regions
on regions.region_id=countries.region_id
group by region_name


-- 2) Employees, Departments, Locations, Countries, Regions. Detailed employee info: First_name, Last_name, Department, Job, Street, Country, Region
select first_name,last_name,department_name,job_id,street_address,country_name,region_name from employees
left join departments
on employees.department_id=departments.department_id
left join locations
on departments.location_id=locations.location_id
left join countries
on locations.country_id=countries.country_id
left join regions
on regions.region_id=countries.region_id


-- 3) Employees table. Show managers with more than 6 subordinates.
select manager_id,count(employee_id) num_of_subordinate
from hr.employees
group by manager_id
having count(employee_id)>6


-- 4) Employees table. Show employees who report to no one.
select employee_id,manager_id
from hr.employees
where manager_id is null


-- 5) Employees, Job_history. Report employee status: Jennifer | Left the company at 31 of December, 2006, Clara | Currently Working
select first_name,
case when EXISTS 
(SELECT 1 FROM job_history WHERE job_history.employee_id = employees.employee_id)
then '|Left the company at '||TO_CHAR(end_date,'DDth "of" Month, YYYY')
else '|Currently Working' end as status
from employees
left join job_history
on employees.employee_id=job_history.employee_id


-- 6) Employees, Departments, Locations, Countries, Regions. List employees living in Europe.
select employee_id,first_name,region_name from employees
left join departments
on employees.department_id=departments.department_id
left join locations
on departments.location_id=locations.location_id
left join countries
on locations.country_id=countries.country_id
left join regions
on regions.region_id=countries.region_id
where region_name='Europe'


-- 7) Employees, Departments. Show departments with more than 30 employees.
select department_name,count(employee_id)as num_employee from employees
left join departments
on employees.department_id=departments.department_id
group by department_name
having count(employee_id)>30


-- 8) Employees, Departments. Show employees not assigned to any department.
select employee_id,first_name,department_name from employees
left join departments
on employees.department_id=departments.department_id
where department_name is null


-- 9) Employees, Departments. Show departments with no employees.
select department_name,count(employee_id)num_of_emp from employees
left join departments
on employees.department_id=departments.department_id
group by department_name
having count(employee_id)=0 or count(employee_id) is null


-- 10) Employees table. Show employees with no subordinates.
select tb1.employee_id,tb1.first_name,tb2.employee_id from employees tb1
left join employees tb2
on tb1.employee_id=tb2.manager_id
where tb2.employee_id is null


-- 11) Employees, Jobs, Departments. Format: First_name | Job_title | Department_name
select first_name||'|job_title|'||department_name from employees
left join departments
on employees.department_id=departments.department_id
left join jobs
on employees.job_id=jobs.job_id


-- 12) Employees table. Employees whose managers were hired in 2005 but they were hired before 2005.
select tb2.employee_id from employees tb1
left join employees tb2
on tb1.employee_id=tb2.manager_id
where extract(year from tb1.hire_date)=2005 and
extract(year from tb2.hire_date)<2005


-- 13) Employees table. Employees whose managers were hired in January of any year and whose job_title length > 15.
select tb1.employee_id from employees tb1
left join employees tb2
on tb2.employee_id=tb1.manager_id
left join jobs
on tb1.job_id=jobs.job_id
where extract(month from tb2.hire_date)=1 and
length(job_title)>15





--Using Subqueries to Solve Queries


-- 1) Employees table. Employees with the longest name.
select employee_id,first_name from employees tb1
where length(tb1.first_name)=(select max(length(first_name)) from employees)


-- 2) Employees table. Employees with salary above company average.
select employee_id,salary from employees
where salary>(select avg(salary) from employees)


-- 3) Employees, Departments, Locations. City where employees earn the least in total.
SELECT city, total_salary
FROM (
    SELECT city, SUM(salary) total_salary
    FROM employees
    LEFT JOIN departments
        ON employees.department_id = departments.department_id
    LEFT JOIN locations
        ON departments.location_id = locations.location_id
    GROUP BY city
)
WHERE total_salary = (
    SELECT MAX(total_salary)
    FROM (
        SELECT SUM(salary) total_salary
        FROM employees
        LEFT JOIN departments
            ON employees.department_id = departments.department_id
        LEFT JOIN locations
            ON departments.location_id = locations.location_id
        GROUP BY city
    )
)


-- 4) Employees table. Employees whose manager earns more than 15000.
select employee_id from employees tb1
where (select salary from employees tb2
where tb1.manager_id=tb2.employee_id)>15000


-- 5) Employees, Departments. Departments with no employees.
select department_name from (select department_name,count(employee_id) from departments
left join employees
on departments.department_id=employees.department_id
group by department_name
having count(employee_id)=0)


-- 6) Employees table. Employees who are not managers.
SELECT tb1.employee_id
FROM employees tb1
WHERE NOT EXISTS (
    SELECT 1
    FROM employees tb2
    WHERE tb2.manager_id = tb1.employee_id
)


-- 7) Employees table. Managers with more than 6 subordinates.
select tb1.employee_id from employees tb1
where (select count(tb2.employee_id)from employees tb2
where tb1.employee_id=tb2.manager_id
group by tb2.manager_id)>6


-- 8) Employees, Departments. Employees working in IT department.
select employee_id from employees tb1
where department_id=(select department_id from departments
where department_name='IT')


-- 9) Employees, Jobs, Departments. First_name | Job_title | Department_name
select first_name,
(select job_title from jobs tb2 where tb1.job_id=tb2.job_id ) job_n,
(select department_name from departments tb3 where tb1.department_id=tb3.department_id) department_n
from employees tb1


-- 10) Employees table. Employees whose managers were hired in 2005 but they were hired before 2005.
select employee_id from employees tb1
where (select extract(year from hire_date) from employees tb2
where tb1.manager_id=tb2.employee_id)=2005
and extract(year from tb1.hire_date)<2005


-- 11) Employees table. Employees whose managers were hired in January and job_title length > 15.
select employee_id from employees tb1
where 
length((select job_title from jobs tb2 where tb1.job_id=tb2.job_id ))>15 and
(select extract(month from hire_date) from employees tb3 where tb1.manager_id=tb3.employee_id)=1


