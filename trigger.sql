-- <ScriptOptions statementTerminator="$" />
CREATE TRIGGER ST21865247."employee_10k" 
NO CASCADE BEFORE INSERT ON ST21865247.EMPLOYEE 
REFERENCING NEW AS newEmployee 
FOR EACH ROW MODE DB2SQL NOT SECURED 
  WHEN( newEmployee.salary < 10000 ) 
begin atomic 
  set newEmployee.salary = 10000; 
end$

insert into employee values
	('444444','Jacky','K','Twin','A01','8333','2023-11-15','Coder',12,'M','2000-01-01', 6000,0,0)$
	
	select * from employee where empno = '444444'$

--------------------------------------------------------------------------  

-- <ScriptOptions statementTerminator="$" />
CREATE TRIGGER ST21865247."Invalid_DOB" 
AFTER INSERT ON ST21865247.EMPLOYEE 
 REFERENCING NEW AS newEmp 
 FOR EACH ROW MODE DB2SQL NOT SECURED 
	WHEN( newEmp.birthdate <= '1900-01-01' ) 
  begin atomic
	update employee 
	set birthdate = '2000-01-01'
	where employee.empno = newEmp.empno;
  end$

--------------------------------------------------------------------------  

-- <ScriptOptions statementTerminator="$" />
CREATE TRIGGER ST21865247."set_country" 
AFTER INSERT ON ST21865247.DEPARTMENT 
REFERENCING NEW TABLE AS NewDepartmentSet 
FOR EACH STATEMENT MODE DB2SQL NOT SECURED 
WHEN( EXISTS ( select *
			   from newDepartmentSet
			   where location in ('New York','San Francisco','Houston')) ) 
begin atomic		   
	update department 
	set location = 'USA'
	where deptno in ( select nd.deptno
					  from newDepartmentSet as nd
					  where location in  ('New York','San Francisco','Houston'));
end$

insert into department values 
	('M01','Quality Assurance', '000010','A01','New York'),
	('M02','Quality Assurance2', '000010','A01','Houston'),
	('M03','Quality Assurance2', '000010','A01','Australia')$
	

select * from department where deptno like 'M%'$

--------------------------------------------------------------------------  

-- Deletion (new become old because it;s new data)
create table employeebackup like employee$

CREATE TRIGGER ST21865247."employeeDeletionBackup" 
AFTER DELETE ON ST21865247.EMPLOYEE 
REFERENCING OLD TABLE AS deletedRecords
FOR EACH STATEMENT MODE DB2SQL NOT SECURED 

begin atomic		   
	insert into employeebackup select * from deletedRecords;
end$

select * from employee where empno = '444444'$
delete from employee where empno = '444444'$
select * from employeebackup$

--------------------------------------------------------------------------  

-- <ScriptOptions statementTerminator="$" />
CREATE TRIGGER ST21865247."salary_increase" 
AFTER UPDATE OF SALARY ON ST21865247.EMPLOYEE 
REFERENCING NEW ROW AS newSalaryRecord OLD ROW AS oldSalaryRecord 
FOR EACH ROW MODE DB2SQL NOT SECURED 
WHEN( newSalaryRecord.salary > oldSalaryRecord.salary*1.20) 
begin atomic			     
	update employee
	set salary = oldSalaryRecord.salary*1.20
	where empno = oldSalaryRecord.empno;
end$

insert into employee values
	('444449','Jacky','K','Twin','A01','8333','2023-11-15','Coder',12,'M','2000-01-01', 60000,0,0)$
insert into employee values
	('444450','Jeans','K','Twin','A01','8333','2023-11-15','Coder',12,'M','2000-01-01', 100000,0,0)$
insert into employee values
	('444451','Ne','K','Twin','A01','8333','2023-11-15','Coder',12,'M','2000-01-01', 80000,0,0)$
	
select * from employee where empno like '444%'$
update employee set salary = 101000 where empno like '444%'$
	

