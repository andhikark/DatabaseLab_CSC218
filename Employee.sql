select *
from db2inst1.employee;

--1) Show lastname, salary, and phone number of employee
select lastname, salary, phoneno
from db2inst1.employee;

--2) Show salary,bonus, and commision of employee
select lastname, salary, bonus, comm
from db2inst1.employee;

--3) Show first name, last name and total income of each employee
select firstnme as firstname, lastname, salary+bonus+comm as total_income
from db2inst1.employee;

--4) show name of employee and his/her date of birth 
select firstnme,lastname, birthdate
from db2inst1.employee;

--5) show name of employee, his/her date of birth, and age 
select firstnme, lastname, birthdate, year(birthdate)
from db2inst1.employee;

select firstnme, lastname, birthdate, 2023 - year(birthdate)
from db2inst1.employee;

select firstnme, lastname, birthdate, CURRENT_DATE - birthdate
from db2inst1.employee;

select firstnme, lastname, birthdate, year(CURRENT_DATE - birthdate)
from db2inst1.employee;

--6) show first name, last name, middle name, and gender of employee
select firstnme, lastname, midinit, sex
from db2inst1.employee;

--7) lady first, gentleman is not selfish
select firstnme, lastname, midinit, sex
from db2inst1.employee
order by sex;

--8) men are selfish
select firstnme, lastname, midinit, sex
from db2inst1.employee
order by sex desc;

--9) show the employee. order from highest to lowest income
select firstnme, lastname, salary+bonus+comm as income
from db2inst1.employee
order by income desc;

select firstnme, lastname, salary, bonus, comm, salary+bonus+comm as income
from db2inst1.employee
order by income desc;

--coalesce can make null to anything you want
select firstnme, lastname, salary, bonus, comm,
	salary+ coalesce(bonus,0)+coalesce(comm,0)as income
from db2inst1.employee
order by income desc;

--10) show name of employee and their salary after 5% increase 
select firstnme, lastname, salary, salary+salary*0.05 as Increased_Salary
from db2inst1.employee

select firstnme, lastname, salary, salary*1.05 as Increased_Salary
from db2inst1.employee

--11) I'm tired of db2inst1.
--11.1 let import data into your own table (under your schema)

select * 
from employee;

--12) do the same thing to table departement
select *
from department;

--13) do the same thing to table project
select *
from project;

--14) do the same thing to table emmprojact
select *
from empprojact;

--15) show name and sart and end date of the project 
select projname, prstdate, prendate
from project;

grant select on employee to user kitiphod;
grant select on department to user kitiphod;
grant select on project to user kitiphod;
grant select on empprojact to user kitiphod;



