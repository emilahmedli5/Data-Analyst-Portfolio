--2.1.Display   all the information of  the EMP table?
select  *   from    emp;

--2.2.Display   unique  Jobs    from    EMP table?
select      distinct    job from    emp;

--2.3.List  the emps    in  the asc order   of  their   Salaries?
select *from emp order  by  sal asc;


--2.4.List  the details of  the emps    in  asc order   of  the Dptnos  and desc    of
SELECT  * from emp order by deptno asc, job desc;

--2.5.Display   all the unique  job groups  in  the descending  order?
select unique job from emp order by job desc;

--2.6.Display   all the details of  all ‘Mgrs’
SELECT * FROM emp e
WHERE EXISTS (
    SELECT 1 FROM emp sub WHERE sub.mgr = e.empno
);

SELECT unique tb1.* FROM emp tb1
LEFT JOIN emp tb2 ON tb1.empno = tb2.mgr
WHERE tb2.mgr IS NOT NULL;

SELECT * FROM emp
WHERE empno IN (
    SELECT mgr FROM emp WHERE mgr IS NOT NULL
);

--2.7.List  the emps    who joined  before  1981.
SELECT * FROM emp 
WHERE hiredate < TO_DATE('01-01-1981', 'DD-MM-YYYY');

--2.8.List  the Empno,  Ename,  Sal,    Daily   sal of  all emps    in  the asc order   of
select empno ,ename ,
sal,sal/30 daily,12*sal annsal  
from emp    order   by  annsal  asc;

--2.9. Display  the Empno,  Ename,  job,Hiredate,Exp of all Mgrs
select      empno,ename ,job,hiredate,  (sysdate-hiredate)/365 exp
from    emp e where exists  (SELECT 1 FROM emp sub WHERE sub.mgr = e.empno)

--2.10. List    the Empno,  Ename,  Sal,    Exp of  all emps    working for Mgr 7369.
select empno,ename  ,job,hiredate,  (sysdate-hiredate)/365 exp
from    emp
where mgr=7369  

-- 2.11. Display all the details of the emps whose Comm. is more than their Sal.
select *from emp
where comm>sal

-- 2.12. List the emps in the asc order of Designations of those joined after the second half of 1981.
SELECT * FROM emp 
WHERE hiredate > TO_DATE('06-30-1981', 'MM-DD-YYYY');

-- 2.13. List the emps along with their Exp and Daily Sal is more than Rs.100.
select *from emp

select  emp.*,  (sysdate-hiredate)/365 exp from emp
where (sal/30)>100

-- 2.14. List the emps who are either ‘CLERK’ or ‘ANALYST’ in the Desc order.
select *from emp where job='CLERK' or job='ANALYST'

select *from emp where job IN ('CLERK','ANALYST')

-- 2.15. List the emps who joined on 1-MAY-81, 3-DEC-81, 17-DEC-81, 19-JAN-80 in asc order of seniority.
SELECT *
FROM emp
WHERE hiredate IN ('01-MAY-81', '03-DEC-81', '17-DEC-81', '19-JAN-80')
ORDER BY hiredate ASC;

-- 2.16. List the emp who are working for the Deptno 10 or 20.
select *from emp where deptno in(10,20)

-- 2.17. List the emps who are joined in the year 81.
select *from emp where extract(year from hiredate)=1981

-- 2.18. List the emps who are joined in the month of Aug 1980.
select *from emp where hiredate between '01-AUG-80' and '31-AUG-80'

-- 2.19. List the emps whose Annual sal ranging from 22000 and 45000.
select emp.*,sal*12 as annual_salary from emp
where sal*12 between 22000 and 45000

-- 2.20. List the Enames those are having five characters in their Names.
select *from emp where length(ename)=5

-- 2.21. List the Enames those are starting with ‘S’ and with five characters.
select *from emp where length(ename)=5 and ename like 'S%'

-- 2.22. List the emps those are having four chars and third character must be ‘r’.
select *from emp where length(ename)=4 and ename like '__R_'

-- 2.23. List the Five character names starting with ‘S’ and ending with ‘H’.
select *from emp where length(ename)=5 and ename like 'S%H'

-- 2.24. List the emps who joined in January.
select *from emp where extract(month from hiredate)
select to_char(HIREDATE,'Mon') as month_date from emp where to_char(hiredate,'Month')='January'

-- 2.25. List the emps who joined in the month of which second character is ‘a’.
SELECT *
FROM emp 
WHERE EXTRACT(MONTH FROM HIREDATE) = 1

-- 2.26. List the emps whose Sal is four digit number ending with Zero.
select emp.*,length(sal) from emp
where length(sal)=4 and sal like '%0'

-- 2.27. List the emps whose names having a character set ‘ll’ together.
select *from emp where ename like '%LL%'

-- 2.28. List the emps those who joined in 80’s.
SELECT *
FROM emp 
WHERE EXTRACT(year FROM HIREDATE) like '%8_'

-- 2.29. List the emps who does not belong to Deptno 20.
select ename,deptno from emp where deptno<>20

-- 2.30. List all the emps except ‘PRESIDENT’ & ‘MGR’ in asc order of Salaries.
select ename,job from emp where job!='PRESIDENT' or job!='MANAGER'

-- 2.31. List all the emps who joined before or after 1981.
select ename,hiredate from emp where extract(year from hiredate)<>1981

-- 2.32. List the emps whose Empno not starting with digit 78.
select *from emp
where empno not like '78%'

-- 2.33. List the emps who are working under ‘MGR’.
select *from emp
where EXISTS(select 1 from emp where )

-- 2.34. List the emps who joined in any year but not belongs to the month of March.
select *from emp
where extract(month from hiredate)<>3

-- 2.35. List all the Clerks of Deptno 20.
select *from emp
where job='CLERK' and deptno=20

-- 2.36. List the emps of Deptno 30 or 10 joined in the year 1981.
select *from emp
where Deptno in(10,30) and extract(year from hiredate)

-- 2.37. Display the details of SMITH.
select *from emp
where ename='SMITH'

-- 2.38. Display the location of SMITH.
select ename,
(select loc from dept where dept.deptno=emp.deptno) location from emp
where ename='SMITH'

-- 2.39. List the total information of EMP table along with DNAME and Loc of all the emps working under ‘ACCOUNTING’ & ‘RESEARCH’ in asc Deptno.

--FIRST ANSWER()
select emp.*,dname,loc from emp
inner join dept
on emp.deptno=dept.deptno
where dept.dname='ACCOUNTING' or dname='RESEARCH'

--SECOND ANSWER()
select emp.*,(select dname from dept where emp.deptno=dept.deptno) dep_name ,
(select LOC from dept where emp.deptno=dept.deptno) location
from emp
where exists(select 1 from dept where emp.deptno=dept.deptno 
and (dname='ACCOUNTING' or dname= 'RESEARCH'))

-- 2.40. List the Empno, Ename, Sal, Dname of all the ‘MGRS’ and ‘ANALYST’ working in New York, Dallas with an exp more than 7 years without receiving the Comm asc order of Loc.
select empno,ename,sal,dname from emp
inner join dept on emp.deptno=dept.deptno
where (job='MGRS' or job='ANALYST') and 
(loc='NEW YORK' or loc='DALLAS')and
(months_between(sysdate,hiredate)/12)>7 and 
(comm is null)
order by loc


-- 2.41. Display the Empno, Ename, Sal, Dname, Loc, Deptno, Job of all emps working at CHICAGO or working for ACCOUNTING dept with Ann Sal > 28000, but Sal should not be 3000 or 2800, who doesn’t belong to the Mgr and whose no is having digit ‘7’ or ‘8’ in 3rd position in asc order of Deptno and desc order of Job.
SELECT e.empno, e.ename, e.sal, d.dname, d.loc, e.deptno, e.job
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE (d.loc = 'CHICAGO' OR d.dname = 'ACCOUNTING')
AND  (e.sal * 12 > 28000)
AND   e.sal NOT IN (3000, 2800)
AND   e.job != 'MANAGER'
AND   SUBSTR(TO_CHAR(e.empno), 3, 1) IN ('7', '8')
ORDER BY e.deptno ASC, e.job DESC;


-- 2.42. Display the total information of the emps along with Grades in asc order.
-- I do not know
select *from emp e,salgrade s 
where e.sal between s.losal and s.hisal order by grade asc

-- 2.43. List all the Grade 2 and Grade 3 emps.
select e.*,grade from emp e,salgrade s 
where e.sal between s.losal and s.hisal
and (Grade=2 or Grade=3)

-- 2.44. Display all Grade 4, 5 Analyst and Mgr.
select	*	from	emp	e,	salgrade	s	where	e.sal	between	s.losal	and	s.hisal		and
s.grade	in	(4,5)	and	e.empno	in	(select	e.empno	from	emp	e	where	e.job	in
('MANAGER','ANALYST')	)

-- 2.45. List the Empno, Ename, Sal, Dname, Grade, Exp, and Ann Sal of emps working for Dept 10 or 20.
select Empno, Ename, Sal, Dname, Grade, mo

-- 2.46. List all the information of emp with Loc and the Grade of all the emps belong to Grade range from 2 to 4 working at the Dept not starting with ‘OP’ and not ending with ‘S’ with designation having char ‘a’ anywhere, joined in 1981 but not in Mar or Sep and Sal not ending with ‘00’ in asc order of Grades.
select	e.empno,e.ename,d.loc,s.grade,e.sal	
from	emp	e	,dept	d,salgrade	s
where	e.deptno	=	d.deptno
and	(d.dname	not	like	'OP%'	and	d.dname	not	like	'%S')	
and	e.sal	between
s.losal	and	s.hisal	and	s.grade	in	(2,3,4)
and	empno	in	(select	empno	from	emp	
where	job	like	'%A%'and	sal	not	like
'%00'	and	(to_char	(hiredate,'YYYY')	=	'1981'
and	to_char(hiredate,'MON')	not	in	('MAR','SEP')));

-- 2.47. List the details of the Depts along with Empno, Ename or without the emps.
select	*	from	emp	e,dept	d	
where	e.deptno(+)=	d.deptno;

-- 2.48. List the details of the emps whose Salaries more than the employee BLAKE.
select *from emp
where sal>(select sal from emp where ename='BLAKE')

-- 2.49. List the emps whose Jobs are same as ALLEN.
select *from emp
where job=(select job from emp where ename='ALLEN')

-- 2.50. List the emps who are senior to KING.  
select	*	from	emp	
where	hiredate	<	
(select	hiredate rom emp	where ename='KING');


-- 2.51 List the employees who are senior to their own managers.
select *from emp tb1
where hiredate<
(select hiredate from emp tb2 
where tb1.mgr=tb2.empno) 


-- 2.52 List the employees of department 20 whose jobs are the same as employees in department 10.
select *from emp
where deptno=20 and
job in(select job from emp where deptno=10)


-- 2.53 List the employees whose salary is the same as FORD or SMITH, in descending order of salary.
select *from emp 
where sal 
in(select sal from emp where ename in('FORD','SMITH'))
order by sal desc

-- 2.54 List the employees whose jobs are the same as MILLER or whose salary is greater than ALLEN.

SELECT * FROM emp
WHERE job = (SELECT job FROM emp WHERE ename = 'MILLER')
OR sal > (SELECT sal FROM emp WHERE ename = 'ALLEN');

-- 2.55 List the employees whose salary is greater than the total remuneration of all SALESMAN employees.

SELECT * FROM emp
WHERE sal > (
    SELECT SUM(sal + NVL(comm, 0))
    FROM emp
    WHERE job = 'SALESMAN'
);


-- 2.56 List the employees who are senior to BLAKE and working in CHICAGO or BOSTON.
-- Using Subquery + JOIN with DEPT
SELECT e.* FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE e.hiredate < (SELECT hiredate FROM emp WHERE ename = 'BLAKE')
AND d.loc IN ('CHICAGO', 'BOSTON');


-- 2.57 List the employees of grade 3 or 4 belonging to departments ACCOUNTING or RESEARCH,
-- whose salary is greater than ALLEN and whose experience is greater than SMITH,
-- ordered by experience.

SELECT e.ename, e.hiredate, e.sal, d.dname, s.grade,
       TRUNC(MONTHS_BETWEEN(SYSDATE, e.hiredate)/12) AS exp
FROM emp e
JOIN dept d     ON e.deptno = d.deptno
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE s.grade IN (3, 4)
AND d.dname IN ('ACCOUNTING', 'RESEARCH')
AND e.sal > (SELECT sal  FROM emp WHERE ename = 'ALLEN')
AND e.hiredate < (SELECT hiredate FROM emp WHERE ename = 'SMITH')
ORDER BY exp DESC;

-- 2.58 List the employees whose jobs are the same as SMITH or ALLEN.
SELECT * FROM emp
WHERE job IN (
    SELECT job FROM emp 
    WHERE ename IN ('SMITH', 'ALLEN')
);

-- 2.59 Write queries to display the details of employees whose salary is the same as:
-- a) Salary of any manager from EMP2 table.
-- b) Salary of any employee from EMP1 table.
-- c) Salary of any person with 5 years experience belonging to the SALES department of EMP3 table.
-- d) Any grade 2 employee of EMP4 table.
-- e) Any grade 2 or 3 employee working in SALES or OPERATIONS department who joined in 1989.

---- do not exist these tables

-- 2.60 List the jobs in department 10 that are not found in department 20.
select job from emp
where deptno=10 and
job not in(select job from emp where deptno=20)


-- 2.61 List the employees of EMP1 who are not found in EMP2.
---- do not exist these tables

-- 2.62 Find the highest salary in the EMP table.
select max(sal) from emp

-- 2.63 Find the details of the highest paid employee.
select *from emp where sal=(select max(sal) from emp)

-- 2.64 Find the highest paid employee in the SALES department.
SELECT * FROM emp
WHERE deptno = (SELECT deptno FROM dept WHERE dname = 'SALES')
AND sal = (
    SELECT MAX(sal) FROM emp
    WHERE deptno = (SELECT deptno FROM dept WHERE dname = 'SALES')
);
-- 2.65 List the most recently hired employee of grade 3 belonging to location CHICAGO.
SELECT emp.*, grade FROM emp
JOIN salgrade ON sal BETWEEN losal AND hisal
JOIN dept     ON emp.deptno = dept.deptno
WHERE grade = 3
AND loc = 'CHICAGO'
AND hiredate = (
    SELECT MAX(e2.hiredate) FROM emp e2
    JOIN salgrade s2 ON e2.sal BETWEEN s2.losal AND s2.hisal
    JOIN dept d2     ON e2.deptno = d2.deptno
    WHERE s2.grade = 3
    AND d2.loc = 'CHICAGO'
);

-- 2.66 List the employees who are senior to the most recently hired employee working under KING.

select *from emp tb1
where hiredate < (select max(hiredate) from emp tb2
where mgr=(select empno from emp tb3 where ename='KING'))

-- 2.67 List the details of employees belonging to NEW YORK with grade 3 to 5 except PRESIDENT,
-- whose salary is greater than the highest paid employee in CHICAGO,
-- in a group where MANAGER and SALESMAN are not working under KING.

SELECT e.*, s.grade FROM emp e
JOIN dept d     ON e.deptno = d.deptno
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE d.loc = 'NEW YORK'
AND s.grade BETWEEN 3 AND 5
AND e.job != 'PRESIDENT'
AND e.sal > (
    SELECT MAX(e2.sal) FROM emp e2
    JOIN dept d2 ON e2.deptno = d2.deptno
    WHERE d2.loc = 'CHICAGO'
)
AND e.empno NOT IN (
    SELECT empno FROM emp
    WHERE job IN ('MANAGER', 'SALESMAN')
    AND mgr = (SELECT empno FROM emp WHERE ename = 'KING')
);

-- 2.68 List the details of the senior employee who joined in 1981.

SELECT * FROM emp
WHERE hiredate = (
    SELECT MIN(hiredate) FROM emp
    WHERE EXTRACT(YEAR FROM hiredate) = 1981
);


-- 2.69 List the employees who joined in 1981 with the same job as the most senior employee of 1981.
SELECT * FROM emp
WHERE EXTRACT(YEAR FROM hiredate) = 1981
AND job = (
    SELECT job FROM emp
    WHERE hiredate = (
        SELECT MIN(hiredate) FROM emp
        WHERE EXTRACT(YEAR FROM hiredate) = 1981
    )
);

-- 2.70 List the most senior employee working under KING whose grade is more than 3.
SELECT e.*, s.grade FROM emp e
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE e.mgr = (SELECT empno FROM emp WHERE ename = 'KING')
AND s.grade > 3
AND e.hiredate = (
    SELECT MIN(e2.hiredate) FROM emp e2
    JOIN salgrade s2 ON e2.sal BETWEEN s2.losal AND s2.hisal
    WHERE e2.mgr = (SELECT empno FROM emp WHERE ename = 'KING')
    AND s2.grade > 3
);

-- 2.71 Find the total salary given to MANAGERS.
SELECT SUM(sal) AS total_salary 
FROM emp
WHERE job = 'MANAGER';


-- 2.72 Find the total annual salary distributed job-wise in the year 1981.
SELECT job, 
       SUM(sal * 12) AS total_annual_sal
FROM emp
WHERE EXTRACT(YEAR FROM hiredate) = 1981
GROUP BY job
ORDER BY total_annual_sal DESC;

-- 2.73 Display the total salary of employees belonging to grade 3.
SELECT SUM(e.sal) AS total_salary
FROM emp e
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE s.grade = 3;

-- 2.74 Display the average salary of all CLERKS.
SELECT avg(sal) AS average_salary 
FROM emp
WHERE job = 'CLERK';

-- 2.75 List the employees in department 20 whose salary is greater than the average salary of department 10.
SELECT * FROM emp
WHERE deptno = 20
AND sal > (
    SELECT AVG(sal) FROM emp
    WHERE deptno = 10
);


-- 2.76 Display the number of employees for each job group department-wise.
SELECT deptno, job, COUNT(*) AS emp_count
FROM emp
GROUP BY deptno, job
ORDER BY deptno, job;


-- 2.77 List the manager number and the number of employees working for those managers in ascending order of manager number.

SELECT mgr, COUNT(*) AS emp_count
FROM emp
WHERE mgr IS NOT NULL
GROUP BY mgr
ORDER BY mgr ASC;

-- 2.78 List the departments where at least two employees are working.
SELECT * FROM dept
WHERE deptno IN (
    SELECT deptno FROM emp
    GROUP BY deptno
    HAVING COUNT(*) >= 2
);


-- 2.79 Display the grade, number of employees, and maximum salary of each grade.

SELECT s.grade, 
       COUNT(e.empno)  AS emp_count,
       MAX(e.sal)      AS max_salary
FROM emp e
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
GROUP BY s.grade
ORDER BY s.grade ASC;

-- 2.80 Display department name, grade, and number of employees where at least two employees are CLERKS.
SELECT dept.DNAME, s.grade,count(e.EMPNO)
FROM emp e
JOIN dept on dept.deptno=e.deptno
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
where job='CLERK'
group by dept.dname,s.grade
having count(e.EMPNO)>=2

-- 2.81 List the details of the department where the maximum number of employees are working.
SELECT * 
FROM dept tb1 
WHERE deptno = (
    SELECT deptno 
    FROM (
        SELECT DEPTNO, 
               COUNT(EMPNO) as emp_count,
               RANK() OVER (ORDER BY COUNT(EMPNO) DESC) as dept_rank
        FROM emp
        GROUP BY DEPTNO
    ) ranked_depts  -- Added alias here
    WHERE dept_rank = 1  -- Changed to WHERE clause
)

(select deptno from (SELECT DEPTNO, 
       COUNT(EMPNO) as emp_count,
       RANK() OVER (ORDER BY COUNT(EMPNO) DESC) as dept_rank
FROM emp
GROUP BY DEPTNO)
dept_rank=1)
-- 2.82 Display the employees whose manager name is JONES.

SELECT * FROM emp
WHERE mgr = (
    SELECT empno FROM emp WHERE ename = 'JONES'
);


-- 2.83 List the employees whose salary becomes greater than 3000 after a 20% increment.
SELECT ename, sal, sal * 1.20 AS new_sal
FROM emp
WHERE sal * 1.20 > 3000;

-- 2.84 List the employees with their department names.

SELECT e.*, d.dname
FROM emp e
JOIN dept d ON e.deptno = d.deptno;


-- 2.85 List the employees who are not working in the SALES department.
SELECT * FROM emp
WHERE deptno != (
    SELECT deptno FROM dept WHERE dname = 'SALES'
);


-- 2.86 List the employee name, department, salary, and commission for employees whose salary is between
-- 2000 and 5000 and whose location is CHICAGO.

SELECT e.ename, d.dname, e.sal, e.comm
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE e.sal BETWEEN 2000 AND 5000
AND d.loc = 'CHICAGO';

-- 2.87 List the employees whose salary is greater than their manager's salary.
select *from emp tb1 
where sal>
(select sal from emp tb2 where tb1.mgr=tb2.empno )

-- 2.88 List the grade and employee name for employees in department 10 or 30
-- whose salary grade is not 4 and who joined before 31-DEC-82.
SELECT e.ename, s.grade
FROM emp e
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE e.deptno IN (10, 30)
AND s.grade != 4
AND e.hiredate < TO_DATE('31-12-1982', 'DD-MM-YYYY')
ORDER BY s.grade ASC;


-- 2 List the name, job, department name, and location for employees who are working as managers.
SELECT e.ename, e.job, d.dname, d.loc
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE EXISTS (
    SELECT 1 FROM emp WHERE mgr = e.empno
);
-- 3 List the employees whose manager name is JONES and also list their manager name.
select tb1.empno,
(select tb2.ENAME from emp tb2 
where tb2.empno=tb1.MGR and ENAME='JONES' ) 
man_name from emp tb1;


-- 4 List the name and salary of FORD if his salary is equal to the highest salary of his grade.
SELECT e1.ename, e1.sal
FROM emp e1
JOIN salgrade s1 ON e1.sal BETWEEN s1.losal AND s1.hisal
WHERE e1.ename = 'FORD'
AND e1.sal = (
    SELECT MAX(e2.sal) FROM emp e2
    JOIN salgrade s2 ON e2.sal BETWEEN s2.losal AND s2.hisal
    WHERE s2.grade = s1.grade
);

-- 5 List the employee name, job, department name, salary, and grade department-wise.
SELECT e.ename, e.job, d.dname, e.sal, s.grade
FROM emp e
JOIN dept d ON e.deptno = d.deptno
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
ORDER BY d.dname, s.grade;

-- 6 List the employee name, job, salary, grade, and department name except CLERKS and sort by highest salary.

SELECT e.ename, e.job, e.sal, s.grade, d.dname
FROM emp e
JOIN dept d     ON e.deptno = d.deptno
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE e.job != 'CLERK'
ORDER BY e.sal DESC;

-- 7 List the employee names and jobs who are without a manager.
select e.ename, e.job
FROM emp e
where MGR is null;

-- 8 List the names of employees who are getting the highest salary department-wise.
select ename from emp tb1
where sal=(select max(sal) from emp tb2 where tb1.deptno=tb2.deptno group by tb2.deptno);

-- 9 List the employees whose salary is equal to the average of the maximum and minimum salary.

select e.ENAME  from emp e
where sal=(select ((max(sal)+min(sal))/2) from emp);

-- 10 List the number of employees in each department where the number is more than 3.
SELECT d.dname, COUNT(e.empno) AS emp_count
FROM emp e
JOIN dept d ON e.deptno = d.deptno
GROUP BY d.dname
HAVING COUNT(e.empno) > 3;

-- 11 List the department names where at least 3 employees are working in that department.
SELECT d.dname, COUNT(e.empno) AS emp_count
FROM emp e
JOIN dept d ON e.deptno = d.deptno
GROUP BY d.dname
HAVING COUNT(e.empno) >= 3;

-- 12 List the managers whose salary is more than the average salary of their employees.

SELECT DISTINCT tb2.empno, tb2.ename, tb2.sal,
       (SELECT ROUND(AVG(sal),2) FROM emp WHERE mgr = tb2.empno) AS avg_emp_sal
FROM emp tb1
JOIN emp tb2 ON tb1.mgr = tb2.empno
WHERE tb2.sal > (
    SELECT AVG(sal) FROM emp tb3
    WHERE tb3.mgr = tb2.empno
);

-- 13 List the name, salary, and commission for those employees whose net pay is greater than or equal to any other employee salary in the company.
SELECT ename,sal,comm
from emp
WHERE (sal + NVL(comm, 0)) >= ANY (SELECT sal FROM emp);

-- 14 List the employees whose salary is less than their manager but greater than any other manager.

SELECT e.empno, e.ename, e.sal,
       man.ename AS manager_name,
       man.sal   AS manager_sal
FROM emp e
JOIN emp man ON e.mgr = man.empno
WHERE e.sal < man.sal
AND e.sal > ALL (
    SELECT sal FROM emp man2
    WHERE man2.empno IN (
        SELECT DISTINCT mgr FROM emp WHERE mgr IS NOT NULL
    )
    AND man2.empno != e.mgr     
    AND man2.empno != e.empno   
);

-- 15 List the employee names and their average salary department-wise.
select ename,
avg(sal) over(partition by deptno) avg_sal
from emp;

-- 16 Find the least 5 earners of the company.
select ename,sal from emp order by sal
fetch first 5 ROWS ONLY;

-- 17 Find the employees whose salaries are greater than the salaries of their managers.
select empno from emp where sal>(select sal from emp tb2 where emp.mgr=tb2.empno);


-- 18 List the managers who are not working under the PRESIDENT.

SELECT DISTINCT mng.empno, mng.ename, mng.job, mng.mgr
FROM emp e
JOIN emp mng ON e.mgr = mng.empno
WHERE (
    mng.mgr != (SELECT empno FROM emp WHERE job = 'PRESIDENT')
    OR mng.mgr IS NULL
);

-- 19 List the records from EMP whose department number is not found in DEPT.
select *from emp
where deptno not in(select DEPTNO from dept);

-- 20 List the name, salary, commission, and net pay where net pay is more than any other employee.
SELECT ename, sal, comm,
sal + NVL(comm, 0) AS net_pay
FROM emp
WHERE (sal + NVL(comm, 0)) >= ALL (
    SELECT sal + NVL(comm, 0) FROM emp
);

-- 21 List the employee names who will retire after 31-DEC-89 assuming maximum job period is 20 years.
SELECT ename, hiredate,
ADD_MONTHS(hiredate, 240) AS retirement_date
FROM emp
WHERE ADD_MONTHS(hiredate, 240) > TO_DATE('31-12-1989', 'DD-MM-YYYY');


-- 22 List the employees whose salary is an odd value.
select *from emp
where mod(sal,2)=1;

-- 23 List the employees whose salary contains 3 digits.
select *from emp
where length(to_char(sal))=3;

-- 24 List the employees who joined in the month of DECEMBER.
select *from emp
where extract(month from hiredate)=12;

-- 25 List the employees whose names contain the letter 'A'.
select *from emp
where ename like '%A%';

-- 26 List the employees whose department number appears inside their salary value.
select *from emp
where instr(to_char(sal),to_char(deptno),1,1)>0;


-- 27 List the employees whose first 2 characters from hiredate equal the last 2 characters of salary.
select *from emp
where 
substr(to_char(hiredate),1,2)=
substr(to_char(sal),length(to_char(sal))-1,to_char(sal));

-- 28 List the employees whose 10% of salary equals the year of joining.
select * from emp
where (0.1*sal)=extract(year from hiredate);


-- 29 Display the first 50% characters of employee name in lowercase and the remaining characters in uppercase.
select concat
(lower(substr(ename,1,length(ename)/2)),
upper(substr(ename,(length(ename)/2)+1,length(ename)))) from emp;

-- 30 List the department names where the number of employees equals the number of characters in the department name.

SELECT d.dname,
       COUNT(e.empno)  AS emp_count,
       LENGTH(d.dname) AS name_length
FROM dept d
LEFT JOIN emp e ON d.deptno = e.deptno
GROUP BY d.dname
HAVING COUNT(e.empno) = LENGTH(d.dname);

-- 31 List the employees who joined the company before the 15th day of the month.
select *from emp
where extract(day from hiredate)<15;

-- 32 List the department names where the number of characters equals the number of employees in any other department.
select dname from dept tb1
where length(dname)=any 
(select count(empno) from emp tb2 
WHERE tb2.deptno != tb1.deptno group by  tb2.deptno);


-- 33 List the employees who are working as MANAGERS.
SELECT DISTINCT tb1.*
FROM emp tb1
JOIN emp tb2 ON tb2.mgr = tb1.empno;

-- 34 List the department name where the highest number of employees are working.
SELECT d.dname, COUNT(e.empno) AS emp_count
FROM emp e
JOIN dept d ON e.deptno = d.deptno
GROUP BY d.dname
HAVING COUNT(e.empno) = (
    SELECT MAX(COUNT(empno))
    FROM emp
    GROUP BY deptno
);


-- 35 Count the number of employees who are working as MANAGERS using a set operation.
select count(*) num_of_man from ((select empno from emp tb1)
intersect
(select mgr from emp tb2));

-- 36 List the employees who joined the company on the same date.
select empno,hiredate from emp tb1
intersect
select empno,hiredate from emp tb2
where tb1.empno<>tb2.empno;

-- 37 List the details of employees whose grade equals one tenth of the SALES department number.
SELECT e.*, s.grade
FROM emp e
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE s.grade = (
SELECT deptno / 10 
FROM dept 
WHERE dname = 'SALES'
);

-- 38 List the department name where more than the average number of employees are working.

SELECT d.dname, COUNT(e.empno) AS emp_count
FROM emp e
JOIN dept d ON e.deptno = d.deptno
GROUP BY d.dname
HAVING COUNT(e.empno) > (
    select count(empno)/count(distinct deptno) from emp
);


-- 39 List the manager name who has the maximum number of employees working under him.
SELECT * FROM (
SELECT m.ename AS manager_name,
COUNT(e.empno) AS emp_count,
RANK() OVER (ORDER BY COUNT(e.empno) DESC) AS rnk
FROM emp e
JOIN emp m ON e.mgr = m.empno
GROUP BY m.empno, m.ename
)
WHERE rnk = 1;

-- 40 List the employee name and salary increased by 15% and display it as dollars.
select ename,sal*1.15 || '$' new_salary from emp;

-- 41 Produce the output of EMP table as 'EMP_AND_JOB' combining employee name and job.
select ename||'_AND_'||JOB EMP_AND_JOB from emp;

-- 42 Produce the following output from EMP.
--- there is no output


-- 130 List the employees with hiredate in the format: June 4, 1988.
SELECT empno,ename,to_char(hiredate, 'Month DD, YYYY') FROM emp;

-- 131 Print a list of employees showing:
-- 'JUST SALARY' if salary > 1500
-- 'ON TARGET' if salary = 1500
-- 'BELOW 1500' if salary < 1500.

SELECT empno,ename,sal,
case when sal > 1500 then 'JUST SALARY'
when sal = 1500 then 'ON TARGET'
when sal < 1500 then 'BELOW 1500'
END AS Emp_cat
FROM emp;

-- 132 Write a query that returns the day of the week for any date entered in the format 'DD-MM-YY'.

select to_char(to_date('& s','dd-mm-yy'),'day') week_day from dual;

-- 133 Write a query to calculate the length of service of any employee with the company.

DEFINE service =(months_between(sysdate, hiredate)/12)

SELECT empno, ename, 
       &service AS years_of_service
FROM emp
WHERE ename = '&name';

-- 134 Given a string in format 'NN/NN', verify that:
-- first two characters are numbers,
-- middle character is '/',
-- last two characters are numbers.
-- Print 'YES' if valid, otherwise 'NO'.
-- Test values: '12/34', '01/1a', '99/98'.

SELECT CASE
    WHEN TRANSLATE(SUBSTR('&str',1,1),'0123456789','NNNNNNNNNN') = 'N'
    AND  TRANSLATE(SUBSTR('&str',2,1),'0123456789','NNNNNNNNNN') = 'N'
    AND  SUBSTR('&str',3,1) = '/'
    AND  TRANSLATE(SUBSTR('&str',4,1),'0123456789','NNNNNNNNNN') = 'N'
    AND  TRANSLATE(SUBSTR('&str',5,1),'0123456789','NNNNNNNNNN') = 'N'
    THEN 'YES'
    ELSE 'NO'
END AS result
FROM dual;


-- 135 Employees hired on or before the 15th of a month are paid on the last Friday of that month.
-- Employees hired after the 15th are paid on the first Friday of the next month.
-- Print employee name, hire date, and first pay date. Sort by hire date.
SELECT ename, hiredate,
CASE 
WHEN EXTRACT(DAY FROM hiredate) <= 15 
THEN NEXT_DAY(LAST_DAY(hiredate) - 6, 'FRIDAY')  
ELSE 
NEXT_DAY(LAST_DAY(hiredate), 'FRIDAY')            
END AS first_pay_date
FROM emp
ORDER BY hiredate;

-- 136) Count the no. of characters with out considering spaces for each name.

SELECT ename,
LENGTH(REPLACE(ename, ' ', '')) AS name_length
FROM emp;


-- 137) Find out the emps who are getting decimal value in their Sal without using like operator.

select *from emp
where instr(sal,'.',1,1)>0

-- 138) List those emps whose Salary contains first four digit of their Deptno.

SELECT * FROM emp
WHERE INSTR(TO_CHAR(sal), TO_CHAR(deptno)) > 0;


-- 139) List those Managers who are getting less than his emps Salary.

SELECT 
    distinct(tb2.empno),tb2.ename, tb2.sal AS mgr_sal               
FROM emp tb1
INNER JOIN emp tb2 ON tb1.mgr = tb2.empno
where tb2.sal<tb1.sal;

-- Given answers
select	distinct	m.ename,m.sal	from	emp	w,emp	m	where	w.mgr	=	m.empno
and	w.sal>m.sal;
select	*	from	emp	w	where	sal		<	any	(	select	sal	from	emp	where
w.empno=mgr);
select	*	from	emp	w	where	empno	in		(	select	mgr	from	emp	where			
w.sal<sal);

-- 140) Print the details of all the emps who are sub-ordinates to Blake.

SELECT 
    tb1.empno, tb1.ename,
    tb2.empno  mgr_empno, 
    tb2.ename  mgr_name                   
FROM emp tb1
INNER JOIN emp tb2 ON tb1.mgr = tb2.empno
where tb2.ename='BLAKE'
ORDER BY tb1.empno;

-- 141) List the emps who are working as Managers using co-related sub-query.

select *from emp
where empno in(select mgr from emp)

-- 142) List the emps whose Mgr name is ‘Jones’ and also with his Manager name.
SELECT 
    tb1.empno, tb1.ename,
    tb2.empno  mgr_empno, 
    tb2.ename  mgr_name                   
FROM emp tb1
INNER JOIN emp tb2 ON tb1.mgr = tb2.empno
where tb2.ename='JONES'
ORDER BY tb1.empno;

-- 143) Define a variable representing the expression used to calculate on emps total annual remuneration use the variable in a statement, which finds all emps who can earn 30000 a year or more.

DEFINE annual_sal = sal*12+NVL(comm,0)*12


SELECT * FROM emp
WHERE &annual_sal >= 30000;


-- 144) Find out how may Managers are their in the company.
select	count(*) num_of_emp	from	emp	where	empno	in	(select	mgr	from	emp);


-- 145) Find Average salary and Average total remuneration for each Job type. Remember Salesman earn commission.
SELECT job, 
AVG(sal) avg_salary,
AVG(sal + NVL(comm, 0)) avg_remuneration
FROM emp
GROUP BY job
ORDER BY job;

-- 146) Check whether all the emps numbers are indeed unique.
select EMPNO,count(*) from emp group by empno


-- 147) List the emps who are drawing less than 1000 Sort the output by Salary.
select *from emp where sal<1000
order by sal

-- 148) List the employee Name, Job, Annual Salary, deptno, Dept name and grade who earn 36000 a year or who are not CLERKS.
SELECT e.ename, e.job,
       e.sal * 12  AS annsal,
       e.deptno,
       d.dname,
       s.grade
FROM emp e
JOIN dept d     ON e.deptno = d.deptno
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE e.sal * 12 = 36000
OR    e.job != 'CLERK'
ORDER BY e.sal DESC;


-- 149) Find out the Job that was filled in the first half of 1983 and same job that was filled during the same period of 1984.

SELECT DISTINCT job FROM emp
WHERE hiredate BETWEEN '01-JAN-1983' AND '30-JUN-1983'
INTERSECT
SELECT DISTINCT job FROM emp
WHERE hiredate BETWEEN '01-JAN-1984' AND '30-JUN-1984';

-- 150) Find out the emps who joined in the company before their Managers.

SELECT 
    tb1.empno, tb1.ename                  
FROM emp tb1
INNER JOIN emp tb2 ON tb1.mgr = tb2.empno
where tb1.HIREDATE<tb2.HIREDATE

--Given answers
select	*	from	emp	w,emp	m	where	w.mgr	=	m.empno	and
w.hiredate<	m.hiredate;

select	*	from	emp	e	where	hiredate	<	(select		hiredate	from	emp	where
empno	=	e.mgr)

-- 151) List all the emps by name and number along with their Manager’s name and number. Also List KING who has no ‘Manager’.

SELECT 
    tb1.empno, tb1.ename,
    tb2.empno  mgr_empno, 
    tb2.ename  mgr_name                   
FROM emp tb1
LEFT JOIN emp tb2 ON tb1.mgr = tb2.empno
ORDER BY tb1.empno;

--Given answer
select	w.empno,w.ename,m.empno,m.ename	
from emp	w,emp	m	
where w.mgr=	m.empno(+);




-- 152) Find all the emps who earn the minimum Salary for each job wise in ascending order.
select tb1.* from emp tb1
where sal=(select min(sal) from emp tb2 
where tb1.job=tb2.job)
order	by	sal	asc

-- 153) Find out all the emps who earn highest salary in each job type. Sort in descending salary order.

select tb1.* from emp tb1
where sal=(select max(sal) from emp tb2 
where tb1.job=tb2.job)
order	by	sal	desc

--Given answer
select	*	from	emp	where	sal	in
(select	max(sal)	from	emp	group	by	job)
order	by	sal	desc

-- 154) Find out the most recently hired emps in each Dept order by Hiredate.

select	*	from	emp		e	where	hiredate	in
(select	max(hiredate)	from	emp	where	e.deptno	=deptno	)
order	by	hiredate;


-- 155) List the employee name, Salary and Deptno for each employee who earns a salary greater than the average for their department order by Deptno.

--My answer
select ename,sal,DEPTNO from emp tb1
where sal>(select avg(sal) from emp tb2 where tb1.deptno=tb2.deptno)
order by deptno;

--Given answer
select	e.ename,e.sal,e.deptno	from	emp	e,(select	avg(sal)	A,deptno	D	from		
emp	group	by	deptno)	D1	where	D1.D	=	e.deptno	and	e.sal	>	D1.A;


-- 156) List the Deptno where there are no emps.
select deptno,count(empno) from emp
group by deptno
having count(empno)=0;

-- 157) List the No.of emp’s and Avg salary within each department for each job.

select deptno,job,count(*) num_of_emp,avg(sal) avg_sal from emp
group by deptno,job

-- 158) Find the maximum average salary drawn for each job except for ‘President’.

select max(avg(sal)) from emp
where job!='PRESIDENT'
group by job

-- 159) Find the name and Job of the emps who earn Max salary and Commission.
select ename, job from emp
where sal=(select max(sal) from emp)
or comm=(select max(comm) from emp)

-- 160) List the Name, Job and Salary of the emps who are not belonging to the department 10 but who have the same job and Salary as the emps of dept 10.
select ename,job,sal from emp
where deptno<>10
and job IN(select job from emp where deptno=10) and sal IN(select sal from emp where deptno=10)

-- 161) List the Deptno, Name, Job, Salary and Sal+Comm of the SALESMAN who are earning maximum salary and commission in descending order.

--My answer
SELECT deptno, ename, job, sal, (sal + NVL(comm, 0)) AS earning
FROM emp
WHERE job = 'SALESMAN'
AND (sal + NVL(comm, 0)) = (SELECT MAX(sal + NVL(comm, 0)) FROM emp WHERE job = 'SALESMAN')
ORDER BY earning DESC;

--Given answer
SELECT deptno, ename, job, sal, sal + NVL(comm, 0) 
FROM emp
WHERE job = 'SALESMAN' 
AND sal IN (SELECT MAX(sal + NVL(comm, 0)) FROM emp WHERE comm IS NOT NULL);

-- 162) List the Deptno, Name, Job, Salary and Sal+Comm of the emps who earn the second highest earnings (sal + comm.).

--My answer
select deptno,ename,job, sal,(sal+NVL(comm,0)) earning from emp
where empno IN(select empno from (select empno,(sal+NVL(comm,0)) earning,dense_rank() over(order by (sal+NVL(comm,0)) desc) highest_earning from emp)
 where highest_earning=2)

-- Real answer
select  deptno,ename,sal,job,sal+nvl(comm,0)    from    emp e   where       1   =   (select
count(distinct  sal+nvl(comm,0))    from    emp where   (e.sal+nvl(comm,0))
<(sal+nvl(comm,0)));



-- 163) List the Deptno and their average salaries for dept with the average salary less than the averages for all department.
select deptno,avg(sal) from emp tb1
group by DEPTNO
having avg(sal)<(select avg(sal) from emp)

-- 164) List out the Names and Salaries of the emps along with their manager names and salaries for those emps who earn more salary than their Manager.

SELECT tb1.ename AS emp_name,
tb1.sal   AS emp_sal,
tb2.ename AS mgr_name,
tb2.sal   AS mgr_sal
FROM emp tb1
JOIN emp tb2 ON tb1.mgr = tb2.empno
WHERE tb1.sal > tb2.sal;

-- 165) List out the Name, Job, Salary of the emps in the department with the highest average salary.
SELECT ename, job, sal
FROM emp
WHERE deptno = (
    SELECT deptno FROM emp
    GROUP BY deptno
    HAVING AVG(sal) = (
        SELECT MAX(AVG(sal)) FROM emp GROUP BY deptno
    )
);

-- 166) List the empno, sal, comm. of emps.
SELECT empno, sal, comm
FROM emp;

-- 167) List the details of the emps in the ascending order of the sal.
SELECT * FROM emp
ORDER BY sal ASC;

-- 168) List the dept in the ascending order of the job and the desc order of the emps print empno, ename.
SELECT empno, ename, job
FROM emp
ORDER BY job ASC, empno DESC;

-- 169) Display the unique dept of the emps.
SELECT DISTINCT deptno
FROM emp;

-- 170) Display the unique dept with jobs.
select  unique  deptno  ,job    from    emp ;

-- 171) Display the details of the blake.
select *from emp
where ename='BLAKE';

-- 172) List all the clerks.
SELECT * FROM emp
WHERE job = 'CLERK';

-- 173) List all the employees joined on 1st May 81.

select empno, ename, sal,hiredate from emp
where HIREDATE = '01-MAY-1981';

-- 174) List the empno, ename, sal, deptno of the dept 10 emps in the ascending order of salary.
SELECT empno, ename, sal, deptno
FROM emp
WHERE deptno = 10
ORDER BY sal ASC;

-- 175) List the emps whose salaries are less than 3500.
SELECT empno, ename, job, sal
FROM emp
WHERE sal < 3500
ORDER BY sal ASC;

-- 176) List the empno, ename, sal of all the emp joined before 1 Apr 81.

select empno, ename, sal,hiredate from emp
where HIREDATE < '01-APR-1981';

-- 177) List the emp whose annual sal is <25000 in the asc order of the salaries.

SELECT empno, ename, job, sal,
sal * 12 AS annsal
FROM emp
WHERE sal * 12 < 25000
ORDER BY sal ASC;

-- 178) List the empno, ename, annsal, dailysal of all the salesmen in the asc ann sal.

SELECT empno, ename,
       sal * 12        AS annsal,
       ROUND(sal / 30, 2) AS dailysal
FROM emp
WHERE job = 'SALESMAN'
ORDER BY annsal ASC;

-- 179) List the empno, ename, hiredate, current date & exp in the ascending order of the exp.
SELECT empno, ename, hiredate,
SYSDATE AS current_date,
TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate) / 12) AS exp_years
FROM emp
ORDER BY exp_years ASC;

-- 180) List the emps whose exp is more than 10 years.
select *from emp
where MONTHS_BETWEEN(sysdate,hiredate)/12>10

-- 181) List the empno, ename, sal, TA30%, DA40%, HRA50%, GROSS, LIC, PF, net, deduction, net allow and net sal in the ascending order of the net salary.
SELECT 
empno,
ename,
sal,
    ROUND(sal * 0.30, 2) AS TA,
    ROUND(sal * 0.40, 2) AS DA,
    ROUND(sal * 0.50, 2) AS HRA,
    ROUND(sal * 2.20, 2) AS GROSS,
    ROUND(sal * 0.10, 2) AS LIC,
    ROUND(sal * 0.12, 2) AS PF,
    ROUND(sal * 0.22, 2) AS DEDUCTION,
    ROUND(sal * 1.20, 2) AS NET_ALLOWANCE,
    ROUND((sal * 2.20) - (sal * 0.22), 2) AS NET_SAL
FROM emp
ORDER BY NET_SAL ASC;

-- 182) List the emps who are working as managers.

select *from emp
where JOB ='MANAGER';

-- 183) List the emps who are either clerks or managers.

select *from emp
where JOB IN('CLERK','MANAGER');

-- 184) List the emps who have joined on the following dates 1 May 81, 17 Nov 81, 30 Dec 81.

SELECT ename, hiredate
FROM emp
WHERE hiredate IN (
    TO_DATE('01-05-1981', 'DD-MM-YYYY'),
    TO_DATE('17-11-1981', 'DD-MM-YYYY'),
    TO_DATE('30-12-1981', 'DD-MM-YYYY')
);

-- 185) List the emps who have joined in the year 1981.

---Variant 1
select *from emp
where EXTRACT(year from HIREDATE)=1981

--Variant 2
select *from emp
where to_char(hiredate,'YYYY')=1981


-- 186) List the emps whose annual sal ranging from 23000 to 40000.

select empno,sal*12 annual_sal from emp 
where sal*12 between 23000 and 40000;

-- 187) List the emps working under the mgrs 7369,7890,7654,7900.
select *from emp
where mgr in(7369,7890,7654,7900)



-- 188) List the emps who joined in the second half of 82.
select *from emp
where hiredate between '01-JUL-82' and '31-DEC-82'

-- 189) List all the 4char emps.
select * from emp 
where length(ename)=4

-- 190) List the emp names starting with ‘M’ with 5 chars.
SELECT ename FROM emp
WHERE ename LIKE 'M____%'
AND LENGTH(ename) = 5;

-- 191) List the emps end with ‘H’ all together 5 chars.
SELECT ename FROM emp
WHERE ename LIKE '____H'
AND LENGTH(ename) = 5;

-- 192) List names start with ‘M’.
SELECT ename FROM emp
WHERE ename LIKE 'M%';

-- 193) List the emps who joined in the year 81.
SELECT ename, hiredate FROM emp
WHERE EXTRACT(YEAR FROM hiredate) = 1981;



-- 194) List the emps whose sal is ending with 00.
SELECT ename, sal FROM emp
WHERE TO_CHAR(sal) LIKE '%00';

-- 195) List the emp who joined in the month of JAN.
SELECT ename, hiredate FROM emp
WHERE TO_CHAR(hiredate, 'MON') = 'JAN';

-- 196) Who joined in the month having char ‘a’.
SELECT ename, hiredate FROM emp
WHERE TO_CHAR(hiredate, 'MONTH') LIKE '%A%';

-- 197) Who joined in the month having second char ‘a’.
SELECT ename, hiredate FROM emp
WHERE SUBSTR(TO_CHAR(hiredate, 'MONTH'), 2, 1) = 'A';

-- 198) List the emps whose salary is 4 digit number.
SELECT ename, sal FROM emp
WHERE sal BETWEEN 1000 AND 9999;

-- 199) List the emp who joined in 80’s.
SELECT ename, hiredate FROM emp
WHERE EXTRACT(YEAR FROM hiredate) BETWEEN 1980 AND 1989;

-- 200) List the emp who are clerks who have exp more than 8ys.
SELECT *FROM emp
WHERE job = 'CLERK'
AND MONTHS_BETWEEN(SYSDATE, hiredate) / 12 > 8;

-- 201) List the mgrs of dept 10 or 20.
SELECT * FROM emp
WHERE job = 'MANAGER'
AND deptno IN (10, 20);

-- 202) List the emps joined in jan with salary ranging from 1500 to 4000.
select *from emp 
where EXTRACT(month from hiredate)=1 
and sal between 1500 and 4000

-- 203) List the unique jobs of dept 20 and 30 in desc order.
select distinct(job) from emp
where deptno in(20,30) order	by	job	desc

-- 204) List the emps along with exp of those working under the mgr whose number is starting with 7 but should not have a 9 joined before 1983.
SELECT ename, hiredate,
MONTHS_BETWEEN(SYSDATE, hiredate) / 12 AS experience_years
FROM emp
WHERE (mgr LIKE '7%' AND mgr NOT LIKE '%9%')
AND TO_CHAR(hiredate, 'YYYY') < '1983';

-- 205) List the emps who are working as either mgr or analyst with the salary ranging from 2000 to 5000 and with out comm.
SELECT * FROM emp
WHERE job IN ('MANAGER', 'ANALYST')
AND sal BETWEEN 2000 AND 5000
AND comm IS NULL;

-- 206) List the empno,ename,sal,job of the emps with /ann sal <34000 but receiving some comm. Which should not be >sal and desg should be sales man working for dept 30.
SELECT empno, ename, sal, job FROM emp
WHERE 12 * (sal + NVL(comm, 0)) < 34000  
AND comm IS NOT NULL                      
AND comm < sal  
AND job = 'SALESMAN'
AND deptno = 30;  

-- 207) List the emps who are working for dept 10 or 20 with desgs as clerk or analyst with a sal is either 3 or 4 digits with an exp>8ys but does not belong to mons of mar,apr,sep and working for mgrs &no is not ending with 88 and 56.
SELECT emp.*,
MONTHS_BETWEEN(SYSDATE, hiredate)/12 AS experience
FROM emp
WHERE deptno IN (10, 20)
AND job IN ('CLERK', 'ANALYST')
AND LENGTH(sal) IN (3, 4)
AND MONTHS_BETWEEN(SYSDATE, hiredate)/12 > 8
AND TO_CHAR(hiredate, 'MON') NOT IN ('MAR', 'SEP', 'APR')
AND mgr NOT LIKE '%88'
AND mgr NOT LIKE '%56';

-- 208) List the empno,ename,sal,job,deptno&exp of all the emps belongs to dept 10 or 20 with an exp 6 to 10 y working under the same mgr with out comm. 
--With a job not ending irrespective of the position with comm.>200 with exp>=7y and sal<2500 but not belongs to the month sep or nov working under the mgr whose no is not having digits either 9 or 0 in the asc dept& desc dept.

SELECT empno, ename, sal, job, deptno,
       TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate)/12) AS exp
FROM emp e
WHERE deptno IN (10, 20)
AND MONTHS_BETWEEN(SYSDATE, hiredate)/12 BETWEEN 7 AND 10  -- merged >= 7 and BETWEEN 6-10
AND mgr IN (SELECT mgr FROM emp
            WHERE deptno IN (10, 20)
            GROUP BY mgr
            HAVING COUNT(*) > 1)
AND comm IS NULL                                            -- no commission
AND job NOT LIKE '%MAN'
AND sal < 2500
AND EXTRACT(MONTH FROM hiredate) NOT IN (9, 11)
AND mgr NOT LIKE '%9%'
AND mgr NOT LIKE '%0%'
ORDER BY deptno ASC, sal DESC


-- 209) List the details of the emps working at Chicago.
SELECT * FROM emp
WHERE deptno IN (SELECT deptno FROM dept WHERE loc = 'CHICAGO');

-- 210) List the empno,ename,deptno,loc of all the emps.
SELECT e.empno, e.ename, e.deptno, d.loc
FROM emp e
JOIN dept d ON e.deptno = d.deptno
ORDER BY e.deptno;

-- 211) List the empno,ename,loc,dname of all the depts.,10 and 20.
SELECT e.empno, e.ename, d.loc, d.dname
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE e.deptno IN (10, 20)
ORDER BY e.deptno;

-- 212) List the empno, ename, sal, loc of the emps working at Chicago dallas with an exp>6ys.
SELECT e.empno, e.ename, e.sal, d.loc,
MONTHS_BETWEEN(SYSDATE, e.hiredate)/12 AS experience
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE d.loc IN ('CHICAGO', 'DALLAS')
AND MONTHS_BETWEEN(SYSDATE, e.hiredate)/12 > 6
ORDER BY e.empno;

-- 213) List the emps along with loc of those who belongs to dallas ,newyork with sal ranging from 2000 to 5000 joined in 81.
SELECT e.ename, e.sal, d.loc, e.hiredate
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE d.loc IN ('DALLAS', 'NEW YORK')
AND e.sal BETWEEN 2000 AND 5000
AND EXTRACT(YEAR FROM e.hiredate) = 1981
ORDER BY e.sal;

-- 214) List the empno,ename,sal,grade of all emps.
SELECT e.empno, e.ename, e.sal, s.grade
FROM emp e
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
ORDER BY s.grade;

-- 215) List the grade 2 and 3 emp of Chicago.
SELECT e.empno, e.ename, e.sal, d.loc, s.grade
FROM emp e
JOIN dept d      ON e.deptno = d.deptno
JOIN salgrade s  ON e.sal BETWEEN s.losal AND s.hisal
WHERE d.loc = 'CHICAGO'
AND s.grade IN (2, 3)
ORDER BY s.grade;

-- 216) List the emps with loc and grade of accounting dept or the locs dallas or Chicago with the grades 3 to 5 &exp >6y.
SELECT e.ename, e.job, e.sal,
       d.dname, d.loc, s.grade,
       TRUNC(MONTHS_BETWEEN(SYSDATE, e.hiredate)/12) AS exp_years
FROM emp e
JOIN dept d     ON e.deptno = d.deptno
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE d.dname = 'ACCOUNTING'
OR  (
    d.loc IN ('DALLAS', 'CHICAGO')
    AND s.grade BETWEEN 3 AND 5
    AND e.hiredate < ADD_MONTHS(SYSDATE, -72)
);

-- 217) List the grades 3 emps of research and operations depts.. joined after 1987 and whose names should not be either miller or allen.

SELECT e.empno, e.ename, e.sal, d.dname, s.grade
FROM emp e
JOIN dept d     ON e.deptno = d.deptno
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE d.dname IN ('RESEARCH', 'OPERATIONS')
AND s.grade = 3                                    
AND EXTRACT(YEAR FROM e.hiredate) > 1987          
AND e.ename NOT IN ('MILLER', 'ALLEN')           
ORDER BY e.ename;

-- 218) List the emps whose job is same as smith.
select *from emp 
where job=(select job from emp where ename='SMITH')

-- 219) List the emps who are senior to miller.
select *from emp
where hiredate<(select hiredate from emp where ename='MILLER')

-- 220) List the emps whose job is same as either allen or sal>allen.
select *from emp
where job=(select job from emp where ename='ALLEN')
or sal>(select sal from emp where ename='ALLEN')

-- 221) List the emps who are senior to their own manager.
SELECT * FROM emp w, emp m 
WHERE w.mgr = m.empno 
AND w.hiredate < m.hiredate;

SELECT * FROM emp tb1
WHERE hiredate < (SELECT hiredate FROM emp tb2 
                  WHERE tb1.mgr = tb2.empno);

-- 222) List the emps whose sal greater than blakes sal.
SELECT e.empno, e.ename, e.sal
FROM emp e
WHERE e.sal > (
    SELECT sal FROM emp WHERE ename = 'BLAKE'
)

-- 223) List the dept 10 emps whose sal>allen sal.
SELECT * FROM emp
WHERE deptno = 10
AND sal > (SELECT sal FROM emp WHERE ename = 'ALLEN')

-- 224) List the mgrs who are senior to king and who are junior to smith.
SELECT * FROM emp
WHERE hiredate > (SELECT hiredate FROM emp WHERE ename = 'SMITH')
AND   hiredate < (SELECT hiredate FROM emp WHERE ename = 'KING')
AND   empno IN (SELECT DISTINCT mgr FROM emp WHERE mgr IS NOT NULL);

-- 225) List the empno,ename,loc,sal,dname,loc of the all the emps belonging to king dept.
SELECT e.empno, e.ename, e.sal,
       d.dname, d.loc
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE e.deptno = (
    SELECT deptno FROM emp WHERE ename = 'KING'
);

-- 226) List the emps whose salgrade are greater than the grade of miller.
SELECT e.*, s.grade
FROM emp e
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE s.grade > (
    SELECT s2.grade FROM emp e2
    JOIN salgrade s2 ON e2.sal BETWEEN s2.losal AND s2.hisal
    WHERE e2.ename = 'MILLER'
);

-- 227) List the emps who are belonging dallas or Chicago with the grade same as adams or exp more than smith.
SELECT e.ename, e.job, e.sal,
       d.loc, s.grade,
       TRUNC(MONTHS_BETWEEN(SYSDATE, e.hiredate)/12) AS exp_years
FROM emp e
JOIN dept d     ON e.deptno = d.deptno
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE d.loc IN ('DALLAS', 'CHICAGO')
AND (
    s.grade = (
        SELECT s2.grade FROM emp e2
        JOIN salgrade s2 ON e2.sal BETWEEN s2.losal AND s2.hisal
        WHERE e2.ename = 'ADAMS'
    )
    OR
    e.hiredate < (
        SELECT hiredate FROM emp WHERE ename = 'SMITH'
    )
);

-- 228) List the emps whose sal is same as ford or blake.
SELECT ename, sal, job
FROM emp
WHERE sal IN (
    SELECT sal FROM emp
    WHERE ename IN ('FORD', 'BLAKE')
);

-- 229) List the emps whose sal is same as any one of the following.
SELECT * FROM emp
WHERE sal IN (
    SELECT sal FROM emp
    GROUP BY sal
    HAVING COUNT(*) > 1
);

-- 230) Sal of any clerk of emp1 table.
select ename,sal from emp 
where job='CLERK'

select *from emp

-- 231) Any emp of emp2 joined before 82.

-- This tables do not exists

-- 232) The total remuneration (sal+comm.) of all sales person of Sales dept belonging to emp3 table.

-- This tables do not exists

-- 233) Any Grade 4 emps Sal of emp 4 table.

-- This tables do not exists

-- 234) Any emp Sal of emp5 table.

-- This tables do not exists

-- 235) List the highest paid emp.
SELECT * FROM emp
WHERE sal = (SELECT MAX(sal) FROM emp);

-- 236) List the details of most recently hired emp of dept 30.
SELECT * FROM emp
WHERE deptno = 30
AND hiredate = (
    SELECT MAX(hiredate) FROM emp WHERE deptno = 30
);

-- 237) List the highest paid emp of Chicago joined before the most recently hired emp of grade 2.
SELECT * FROM emp
WHERE sal = (
    SELECT MAX(sal) FROM emp e, dept d
    WHERE e.deptno = d.deptno
    AND d.loc = 'CHICAGO'
    AND hiredate < (
        SELECT MAX(hiredate) FROM emp e, salgrade s
        WHERE e.sal BETWEEN s.losal AND s.hisal
        AND s.grade = 2
    )
);

-- 238) List the highest paid emp working under king.
SELECT * FROM emp
WHERE mgr = (SELECT empno FROM emp WHERE ename = 'KING')
AND sal = (
    SELECT MAX(sal) FROM emp
    WHERE mgr = (SELECT empno FROM emp WHERE ename = 'KING')
);