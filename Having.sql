--SELECT 
--FROM table-list/ relation
--WHERE condition to filter the records
--GROUP BY column-list to aggregate the records together 
--HAVING condition of grouping
--ORDER BY  order the result	

--1) Show the department that have at least 5 people
SELECT workdept
FROM employee
GROUP BY workdept
HAVING COUNT(*) >= 5;

	--1.2) Show name of department
	SELECT workdept, deptname, count(*) as number_of_employees
	FROM employee, department
	WHERE workdept = deptno
	GROUP BY workdept, deptname
	HAVING COUNT(*) >= 5; 


--2) Which department pay total salary of all emloyee more that .5 million dollars
SELECT workdept
FROM employee
GROUP BY workdept
HAVING SUM(salary) > 500000;

	--2.2) Show name of department
	SELECT deptname, SUM(salary)
	FROM employee, department
	WHERE workdept = deptno
	GROUP BY workdept,deptname
	HAVING SUM(salary) > 500000;


--3) Show name of employee who works for more than 2 projects
	--semantically wrong 
SELECT firstnme, lastname, count(*)
FROM employee, empprojact
WHERE employee.empno = empprojact.empno
GROUP BY employee.empno, firstnme, lastname
HAVING COUNT(*) > 2;
	
	--Cause projno count again and again
SELECT firstnme, lastname, count(distinct projno)
FROM employee, empprojact
WHERE employee.empno = empprojact.empno
GROUP BY employee.empno, firstnme, lastname
HAVING COUNT(distinct projno) > 2


--4) How many people works on each project? 
	--counting the number of action, not people
SELECT projno, count(*)
FROM empprojact 
GROUP BY projno;

SELECT projno, count(distinct empno) AS number_of_employees
FROM empprojact 
GROUP BY projno;

	--Show only the project name that has at least 3 people
		SELECT project.projno,projname, count(distinct empno) AS number_of_employees
		FROM empprojact,project
		WHERE empprojact.projno = project.projno 
		GROUP BY projname, project.projno
		HAVING count(distinct empno) >= 3;


--5) Show average salary of people who work on each project
SELECT projno, avg(salary)
FROM employee, empprojact
WHERE employee.empno = empprojact.empno
GROUP BY projno;


--6) show department number that pay at least $30000 to their employee.
SELECT workdept
FROM employee
GROUP BY workdept
HAVING MIN(salary) >= 40000; 

	--6.2) show department number that pay women at least $40000 to their employee.
	SELECT workdept
	FROM employee
	WHERE sex = 'F'
	GROUP BY workdept
	HAVING MIN(salary) >= 40000; 
	
	--6.3) show department name that pay women at least $40000 to their employee. (different because have dirty data)
	SELECT deptname
	FROM employee, department
	WHERE sex = 'F' and workdept = deptno
	GROUP BY deptname, workdept
	HAVING MIN(salary) >= 40000; 


--7) Show department that pay at least 40000 and have at least 2 employees
SELECT workdept, deptname, min(salary) AS lowest_salary, count(empno) AS number_of_employees
FROM  employee, department
WHERE workdept = deptno
GROUP BY workdept, deptname
HAVING min(salary) >= 40000 and count(empno) >=2;

SELECT workdept, deptname, min(salary) AS lowest_salary, count(empno) AS number_of_employees, max(salary) AS max_salary, avg(salary) AS average_salary
FROM  employee, department
WHERE workdept = deptno
GROUP BY workdept, deptname
HAVING min(salary) >= 40000 or count(empno) >=2;

