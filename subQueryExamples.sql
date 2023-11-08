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
