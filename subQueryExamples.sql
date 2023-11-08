--1) Find employee who does not work on any project. 
SELECT firstnme, lastname
FROM employee as emp
WHERE emp.empno NOT IN (SELECT epa.empno
 FROM empprojact as epa);
					
--2) Show department that has no one works at. (no employee)
SELECT deptname
FROM department
WHERE deptno not in (SELECT workdept
					FROM employee);
					
--3) Who earn the least of the company?
SELECT firstnme,lastname, salary
FROM employee
WHERE salary = (SELECT min(salary)
					FROM employee);

--4) Who earn the most of the company?
SELECT firstnme, lastname, salary
FROM employee as emp, (SELECT MAX(salary) as maxSal from employee) as maxemp
WHERE emp.salary = maxemp.maxSal;

--5) Who earns the most of each department
SELECT  emp.workdept, firstnme, lastname, salary
FROM employee as emp, (SELECT workdept, MAX(salary) as maxSal
						FROM employee
						group by workdept) as maxEmp
WHERE emp.workdept = maxEmp.workdept and emp.salary = maxEmp.maxSal;

--6) Same question with question 5, but must put subquesry in the where clause
SELECT e.workdept, firstnme, lastname, salary
FROM employee as e
WHERE (e.workdept, e.salary) IN (SELECT workdept, MAX(salary)
			 					FROM employee
			 					GROUP BY workdept);
			 					
--7) Can we see the value of subquery that is in the WHERE clause? 
SELECT e.workdept, firstnme, lastname, salary
FROM employee as e
WHERE (e.workdept, e.salary) IN (SELECT workdept, MAX(salary)
			 					FROM employee
			 					GROUP BY workdept);
--) no we cannot select the column from the subquerythat is in the WHERE clause.

--8) but you can select it if it is from the the subquery inside the FROM clause.
SELECT  emp.workdept, firstnme, lastname, salary, maxSal
FROM employee as emp, (SELECT workdept, MAX(salary) as maxSal
						FROM employee
						GROUP BY workdept) as maxEmp
WHERE emp.workdept = maxEmp.workdept and emp.salary = maxEmp.maxSal;

--9) List the name of employee who work in the department that have most amount of employee
WITH ecount(workdept,numberOfEmployees) as
	(SELECT workdept, count(*)
	FROM employee
	GROUP BY workdept)
SELECT firstnme, lastname, workdept
FROM employee
WHERE workdept IN (select workdept
					from ecount
					where ecount.numberOfEmployees = (SELECT MAX(numberOfEmployees)
					FROM ecount));

--10) Count the number of employess fro each departmnet
SELECT workdept, count(*)
FROM employee
GROUP BY workdept;

--11) what is the max number of employee department has the maximum number of employee
SELECT MAX(numberOfEmployees)
FROM (SELECT workdept, count(*) as numberOfEmployees
		FROM employee
		GROUP BY workdept);
 

--12) according to number 11 which dept has the maximum number of employees
SELECT ecount.workdept
FROM( SELECT MAX(numberOfEmployees) as maxOfCount
		from (SELECT workdept, count(*) as numberOfEmployees
				FROM employee
				GROUP BY workdept)), (SELECT workdept, count(*) as co
									FROM employee 
									GROUP BY workdept) as ecount
WHERE maxOfCount = ecount.co;


--13) WITH clause --> not in the exam
WITH ecount(workdept,numberOfEmployee) as
	(SELECT workdept, count(*)
	FROM employee
	GROUP BY workdept)
SELECT *
from ecount;

--14) redo 12)
WITH ecount(workdept,numberOfEmployees) as
	(SELECT workdept, count(*)
	FROM employee
	GROUP BY workdept)
SELECT workdept
FROM(SELECT MAX(numberOfEmployees) as maxOfCount
	 FROM ecount), ecount
Where maxOfCount = ecount.numberOfEmployees;


--15) rewrite 14 for max of count in the WHERE clause 
WITH ecount(workdept,numberOfEmployees) as
	(SELECT workdept, count(*)
	FROM employee
	GROUP BY workdept)
select workdept
from ecount
where ecount.numberOfEmployees = (SELECT MAX(numberOfEmployees)
									FROM ecount);
	
--16) find maximum salary for each department
SELECT workdept, max(salary) 
FROM employee
GROUP BY workdept;

--17) find maximum salary among female of each department
SELECT workdept, max(salary) 
FROM employee
WHERE sex = 'F'
GROUP BY workdept;


--18) Among female of each department, how much different of here salary in comparison with the maximum salary 
WITH femaleEmp(workdept, maxSalary) as 
	(SELECT workdept, max(salary) 
		FROM employee
		WHERE sex = 'F'
		GROUP BY workdept)	
SELECT e.workdept,firstnme,lastname, maxSalary, salary, maxSalary-salary as difference
FROM employee as e, femaleEmp
WHERE e.workdept = femaleEmp.workdept
	  and e.sex = 'F'
ORDER BY e.workdept;


--19) Get rid off the same person of question 18
WITH femaleEmp(workdept, maxSalary) as 
	(SELECT workdept, max(salary) 
		FROM employee
		WHERE sex = 'F'
		GROUP BY workdept)	
SELECT e.workdept,firstnme,lastname, maxSalary, salary, maxSalary-salary as difference
FROM employee as e, femaleEmp
WHERE e.workdept = femaleEmp.workdept
	  and e.sex = 'F' and e.salary != femaleEmp.maxSalary
ORDER BY e.workdept;

--20) CASE .. WHEN 
SELECT firstnme, lastname, sex 
FROM employee;

SELECT firstnme, lastname, CASE sex WHEN 'F' THEN 'Female' WHEN 'M' THEN 'Male' ELSE 'Undefined' END
FROM employee;

--21) redo 18)

WITH femaleEmp(workdept, maxSalary) as 
	(SELECT workdept, max(salary) 
		FROM employee
		WHERE sex = 'F'
		GROUP BY workdept)	
SELECT e.workdept,firstnme,lastname, maxSalary, salary, 
		CASE maxSalary-salary WHEN 0 THEN 'MAX' else char(maxSalary-salary) END as difference
FROM employee as e, femaleEmp
WHERE e.workdept = femaleEmp.workdept
	  and e.sex = 'F'
ORDER BY e.workdept, difference desc;
