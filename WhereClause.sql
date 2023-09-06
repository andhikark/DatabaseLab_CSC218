--1) Find name of employee who earn more than 50K
select firstnme, lastname, salary
from employee
where salary > 50000;

--2) Show female employee who has education level of 16 
select firstnme, lastname, edlevel
from employee
where sex = 'F' and edlevel = 16;

--3) Show employee who is younger than 40 years old
select firstnme, lastname, year(CURRENT_DATE - birthdate), birthdate
from employee
where year(CURRENT_DATE - birthdate) < 40 ;

--4) Find employee who has worked here at least 10 years but not more than 20 years
select firstnme, lastname, year(CURRENT_DATE - hiredate) as workyear, hiredate  
from employee
where year(CURRENT_DATE - hiredate) between 10 and 20 ;

--5) show the project name and the length of the project (number of date)
select projname, prstdate, prendate, days(prendate) - days(prstdate) as projectlength
from project
where days(prendate) - days(prstdate) >= 0;

--6) List all depratment. Show name of departmeents. Order them in descending
select deptname
from department
order by deptname desc;

--7) show name of employee and his/her department 
select firstnme, lastname, deptname
from employee, department 
where workdept = deptno;

--8) Show name of employee and their project
select firstnme, lastname, projno, actno
from employee, empprojact 
where employee.empno = empprojact.empno; 

--9)  Show no duplicate of answer of question 8 
select distinct firstnme, lastname, projno, actno
from employee, empprojact 
where employee.empno = empprojact.empno; 

--10) What department has sp
select deptname
from department
where deptname like '%SPIF%';

--11) who works at the department containing "SPIF" something
select firstnme, lastname, deptname
from employee, department
where employee.workdept = department.deptno and deptname like '%SPIF%';

--12) Show only male of answer question 11
select firstnme, lastname, deptname
from employee, department
where employee.workdept = department.deptno 
	and sex = 'M' 
	and deptname like '%SPIF%';
	
--13) show name of employee and name of their project
select distinct firstnme, lastname,projname 
from employee, empprojact, project
where employee.empno = empprojact.empno and empprojact.projno = project.projno;

--14) who works on project running less than 300 days
select  firstnme, lastname,projname, days(prendate) - days(prstdate)
from employee, empprojact, project
where employee.empno = empprojact.empno 
	and empprojact.projno = project.projno 
	and days(prendate) - days(prstdate) between 1 and 300 ;

--15) Is there anyone have no bonus or commision 
select firstnme, lastname, bonus , comm
from employee
where bonus = 0 or comm = 0;

--16) Is there anyone else in question 15
select firstnme, lastname, bonus , comm
from employee
where bonus is null or comm is null;

--17) which column in department has NULL value
select *
from department

--18) printt all employee whose name start with J
select firstnme, lastname
from employee
where firstnme like 'J%';

--19) what time is it?
select CURRENT_DATE, CURRENT_TIME 
from sysibm.sysdummy1;

--20) which time zone is that?
select CURRENT_TIMESTAMP - CURRENT timezone
from sysibm.sysdummy1;

