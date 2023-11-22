




--Ex 2
set current isolation level UR;
SELECT firstnme, lastname, salary from employee
where empno = '60003';
commit;

update employee set salary = 60000 where empno = '60003';
rollback;

--Ex3 ISOLATION LEVEL II "COMMITTED READ"
--IBM DB "Committed read, CURSOR STABILITY", "CS"
commit;
 set current isolation level CS;
  SELECT firstnme, lastname, salary from employee
where empno = '60003'; --will not see uncommited (have commit first)
update employee set salary = salary + 900 where empno = '60001';
commit;

SELECT firstnme, lastname, salary from employee
where empno = '60003';
update employee set lastname = 'Stark' where empno = '60003';
commit;

--Ex 4: Isolation level III "Repeatable read"
-- BM DB2 "Repeatable read Read Stability"
--prerequisite
commit;

set current isolation level RS;
update employee set salary = salary + 300 where empno = '60003';
SELECT firstnme, lastname, salary from employee
where empno = '60003';
commit;

 SELECT firstnme, lastname, salary from employee
where empno = '60003';
 SELECT firstnme, lastname, salary from employee
where empno = '60001';

--Isolation Level IV "SERIALIZABLE"
-- IBMDB2 "REepeatable Read", RR
-- No Phantom Read 
commit;

set current isolation level RR;
insert into employee
	(empno, firstnme, lastname,workdept, edlevel)
	values ('12345','Elon','Musk','A00',1); --not phantom for empno 60003 or 60001
	commit;	

	insert into employee
	(empno, firstnme, lastname,workdept, edlevel)
	values ('12345','Saddam','Musk','A00',1); --actual phantom
	
	
	
