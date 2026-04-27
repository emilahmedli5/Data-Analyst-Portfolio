select PHONE_NUMBER,substr(PHONE_NUMBER,length(phone_number)-1,1)
from hr.employees
where substr(PHONE_NUMBER,length(phone_number)-1,1)

select PHONE_NUMBER,replace(Phone_number,'.','-')
from hr.employees


Select First_Name,Job_Id,
Substr(Job_Id,Instr(Job_Id,'_',1)+1,Length(Job_Id)) as sub_str
From Hr.Employees
Where Substr(Job_Id,Instr(Job_Id,'_',1)+1,Length(Job_Id))!='CLERK'
And Length(Substr(Job_Id,Instr(Job_Id,'_',1,Length(Job_Id))))>=3


select sysdate,sysdate+1,
'tomorrow is '||EXTRACT(DAY FROM sysdate+1)||' th day of '||
to_char(sysdate+1,' MON')
from dual



SELECT first_name,hire_date,
    EXTRACT(Year FROM hire_date) AS year_num,
    
select first_name,hire_date
FROM hr.employees
where EXTRACT(YEAR FROM hire_date)=2007
and
EXTRACT(MONTH FROM hire_date) = 2


SELECT first_name,salary*1.2||'$'
FROM hr.employees

select first_name,commission_pct,
case when commission_pct is not null then 'Yes'
else 'No' End
as Has_a_Bonus
from hr.employees


select salary,
case when salary<5000 then 'Low Level'
when salary between 5000 and 9999 then 'Normal Level'
else 'High Level'
End As Salary_Level
from hr.employees


select country_name ,region_id,
case when region_id=1 then 'Europe'
when region_id=2 then 'America'
when region_id=3 then 'Asia'
when region_id=4 then 'Africa'
end as region_name
from hr.countries


select NEXT_DAY(sysdate, 'Friday') from dual

select phone_number from hr.employees

select first_name,phone_number,
substr(phone_number,length(phone_number),0)
from hr.employees
where mod(to_number(substr(phone_number,length(phone_number),0)),2)!=0


select first_name,phone_number
from hr.employees
where mod(to_number(substr(phone_number,length(phone_number),1)),2)!=0


select first_name,hire_date, 
    TO_CHAR(hire_date, 'DD') || 
    CASE 
        WHEN EXTRACT(DAY FROM hire_date) IN (11, 12, 13) THEN 'th'
        WHEN MOD(EXTRACT(DAY FROM hire_date), 10) = 1 THEN 'st'
        WHEN MOD(EXTRACT(DAY FROM hire_date), 10) = 2 THEN 'nd'
        WHEN MOD(EXTRACT(DAY FROM hire_date), 10) = 3 THEN 'rd'
        ELSE 'th' 
||
to_char(hire_date,'MON')||','||EXTRACT(Year FROM hire_date) as new_format
from hr.employees

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



select sysdate ,
to_char(sysdate,'SS'),
to_char(sysdate,'MI'),
to_char(sysdate,'HH24'),
to_char(sysdate,'DD'),
to_char(sysdate,'MM'),
to_char(sysdate,'YYYY')
from dual


select first_name,
'$'||TO_CHAR((salary+(salary*NVL(commission_pct,0))),'FM99,999.00') as total_salary
from hr.employees



select sysdate,sysdate+1,
'tomorrow is '||EXTRACT(DAY FROM sysdate+1)||' th day of '||
to_char(sysdate+1,' MON')
from dual


SELECT 
    'Tomorrow is ' || 
    CASE EXTRACT(DAY FROM SYSDATE + 1)
        WHEN 1  THEN 'First'
        WHEN 2  THEN 'Second'
        WHEN 3  THEN 'Third'
        WHEN 25 THEN 'Twenty-Fifth' -- Tomorrow's date
        ELSE TO_CHAR(SYSDATE + 1, 'Ddsp') -- Fallback to Oracle's built-in spelling
    END 
    || ' day of ' || TO_CHAR(SYSDATE + 1, 'Month') AS custom_sentence
FROM dual;


select NEXT_DAY(sysdate, 'Friday') from dual

SELECT 
    'Tomorrow is ' || TO_CHAR(SYSDATE + 1, 'fmDdsp') 
    ||'Day of'||extract
FROM dual;



SELECT 
    -- We use TO_CHAR to get just the day number (e.g., '25')
    'Tomorrow is ' || 
    CASE 
        WHEN TO_CHAR(SYSDATE + 1, 'DD') = '01' THEN 'First'
        WHEN TO_CHAR(SYSDATE + 1, 'DD') = '02' THEN 'Second'
        WHEN TO_CHAR(SYSDATE + 1, 'DD') = '03' THEN 'Third'
        WHEN TO_CHAR(SYSDATE + 1, 'DD') = '04' THEN 'Fourth'
        WHEN TO_CHAR(SYSDATE + 1, 'DD') = '05' THEN 'Fifth'
        -- ... You would continue this for other days ...
        WHEN TO_CHAR(SYSDATE + 1, 'DD') = '25' THEN 'Twenty-Fifth'
        WHEN TO_CHAR(SYSDATE + 1, 'DD') = '31' THEN 'Thirty-First'
        ELSE 'a day' -- Simple fallback
    END 
    || ' day of ' || TO_CHAR(SYSDATE + 1, 'Month') AS custom_sentence
FROM dual;


SELECT 
    'Tomorrow is the ' ||
    TO_CHAR(SYSDATE + 1, 'DDth') ||
    ' day of ' ||
    TO_CHAR(SYSDATE + 1, 'Month')
FROM dual;


select department_id,min(salary) as min_salary,max(salary) as max_salary,
min(hire_date) earliest_hire_date,max(hire_date)earliest_hire_date ,
count(employee_id)as number_of_employee
from hr.employees
group by department_id
order by count(employee_id) desc

select *from hr.employees where department_id is null


select substr(first_name,1,1)first_letter,
count(employee_id)num_of_employees
from hr.employees
group by substr(first_name,1,1)
having count(employee_id)>1
order by count(employee_id)

select department_id,salary,
count(employee_id)num_of_employees
from hr.employees
group by department_id,salary


select to_char(hire_date,'W')week_day,
count(employee_id)num_of_employees
from hr.employees
group by to_char(hire_date,'W')
order by count(employee_id)


SELECT 
    TO_CHAR(hire_date, 'Day') AS hire_day_of_week, 
    COUNT(employee_id) AS employee_count
FROM hr.employees
GROUP BY TO_CHAR(hire_date, 'Day')
ORDER BY employee_count


SELECT 
    Extract(YEar from hire_date) AS hire_year, 
    COUNT(employee_id) AS employee_count
FROM hr.employees
GROUP BY Extract(YEar from hire_date)
ORDER BY employee_count

select count(*) num_of_department
from (SELECT department_id,COUNT(employee_id) num_of_employees 
FROM hr.employees group by department_id having count(employee_id)>0) 


SELECT COUNT(*) num_of_departments
FROM hr.employees
having count(employee_id)>0


SELECT COUNT(DISTINCT department_id) AS num_departments
FROM hr.employees;


SELECT department_id
FROM hr.employees group by department_id having count(employee_id)>30


SELECT department_id,COUNT(employee_id) num_of_employees
FROM hr.employees group by department_id having count(employee_id)>30


select department_id,round(avg(salary))average_salary from hr.employees
group by department_id

select *from hr.countries
order by region_id

select region_id,sum(length(country_name))total_num_of_letters from hr.countries
group by region_id having sum(length(country_name))>60


select department_id,count(job_id) num_of_jobs from hr.employees
group by department_id
having count(job_id)>1

select manager_id,count(employee_id) num_of_subordinate,
sum(salary) total_salary from hr.employees
group by manager_id
having count(employee_id)>5
and sum(salary)>50000


select manager_id,
avg(salary) avg_salary from hr.employees
where commission_pct is null
group by manager_id
having avg(salary) between 6000 and 9000


select manager_id,
avg(salary) avg_salary from hr.employees
group by manager_id
having avg(salary) between 6000 and 9000


select job_id,max(salary) from hr.employees
where job_id like '%CLERK'
group by job_id

select max(avg_salary) from (select department_id,avg(salary)avg_salary from hr.employees
group by department_id)


select length(first_name) as len_name,
count(employee_id) num_of_emp from hr.employees
where length(first_name)>6
group by length(first_name)
having count(employee_id)>20



select max(name_length) from (select employee_id,max(length(first_name))as name_length from employees group by employee_id)



select employee_id,salary from employees
where salary>(select avg(salary) from employees)




select tb1.employee_id from employees tb1
left join employees tb2
on tb1.manager_id=tb2.employee_id
where tb2.salary>15000

select tb1.*,tb2.* from employees tb1
left join employees tb2
on tb1.employee_id=tb2.manager_id



select department_name from (select department_name,count(employee_id) from departments
left join employees
on departments.department_id=employees.department_id
group by department_name
having count(employee_id)=0)

select department_name,employee_id from departments
left join employees
on departments.department_id=employees.department_id


select tb1.*,tb2.* from employees tb1
left join employees tb2
on tb1.employee_id=tb2.manager_id   




select employee_id from 
(select tb1.employee_id,count(tb2.employee_id) num_of_subordinate 
from employees tb1
left join employees tb2
on tb1.employee_id=tb2.manager_id
group by tb1.employee_id
having count(tb2.employee_id)>6)


select city,sum(salary) from employees
left join departments
on employees.department_id=departments.department_id
left join locations
on departments.location_id=locations.location_id
group by city


select max(salary) from (select city,sum(salary) from locations
left join departments
on departments.location_id=locations.location_id
left join employees
on employees.department_id=departments.department_id
group by city)


select employee_id from 
(select tb1.employee_id,count(tb2.employee_id) num_of_subordinate 
from employees tb1
left join employees tb2
on tb1.employee_id=tb2.manager_id
group by tb1.employee_id
having count(tb2.employee_id)>6)



select employee_id,department_name from employees tb1
left join departments tb2
on tb1.department_id=tb2.department_id
where department_name='IT'


select employee_id from employees tb1
where department_id=(select department_id from departments
where department_name='IT')



select first_name,
(select job_title from jobs tb2 where tb1.job_id=tb2.job_id ) job_n,
(select department_name from departments tb3 where tb1.department_id=tb3.department_id) department_n
from employees tb1


select employee_id from employees tb1
where (select extract(year from hire_date) from employees tb2
where tb1.manager_id=tb2.employee_id)=2005
and extract(year from tb1.hire_date)<2005


select employee_id
where 
(select job_title from jobs tb2 where tb1.job_id=tb2.job_id ) job_n,
(select department_name from departments tb3 where tb1.department_id=tb3.department_id) department_n
from employees tb1

select employee_id from employees tb1
where 
length((select job_title from jobs tb2 where tb1.job_id=tb2.job_id ))>15 and
(select extract(month from hire_date) from employees tb3 where tb1.manager_id=tb3.employee_id)=1




select tb1.employee_id from employees tb1
where (select count(tb2.employee_id)from employees tb2
where tb1.employee_id=tb2.manager_id
group by tb2.manager_id)>6


select employee_id from 
(select tb1.employee_id,count(tb2.employee_id) num_of_subordinate 
from employees tb1
left join employees tb2
on tb1.employee_id=tb2.manager_id
group by tb1.employee_id
having count(tb2.employee_id)>6)



select tb1.employee_id from employees tb1
left join employees tb2
on tb1.employee_id=tb2.manager_id
where tb2.employee_id is null


select tb1.employee_id from employees tb1
where (select tb2.manager_id where tb1.manager_id=tb2.employee_id) is null




