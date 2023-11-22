SELECT firstnme, lastname, salary from employee
where empno = '60003';
update employee set salary = 30000
where empno = '60003';

--Ex1 commit/ rollback
update employee set salary = 30000
where empno = '60003';
SELECT firstnme, lastname, salary from employee
where empno = '60003';
commit;
SELECT firstnme, lastname, salary from employee
where empno = '60003';
rollback;
SELECT firstnme, lastname, salary from employee
where empno = '60003';


--Ex 2 "READ UNCOMMITTED"
-- IBMDB2 "Uncommitted Read" UR
update employee set salary = 50000 where empno = '60003';
commit;

set current isolation level UR;
update employee set salary = 40000 where empno = '60003';
SELECT firstnme, lastname, salary from employee
where empno = '60003';
rollback;

--Ex 2.2 Lost update
commit;
SELECT firstnme, lastname, salary from employee
where empno = '60003';

update employee set salary = 35000 where empno = '60003';
commit;
SELECT firstnme, lastname, salary from employee
where empno = '60003';

--Ex3 ISOLATION LEVEL II "COMMITTED READ"
--IBM DB "Committed read, CURSOR STABILITY", "CS"
update employee set salary = 50000 where empno = '60003';
commit;

set current isolation level CS;
update employee set salary = salary + 700 where empno = '60003';
rollback;
SELECT firstnme, lastname, salary from employee
where empno = '60003';
commit;

update employee set salary = salary + 1000 where empno = '60003';
	SELECT firstnme, lastname, salary from employee
where empno = '60003';
	SELECT firstnme, lastname, salary from employee
where empno = '60001';
rollback;

	update employee set salary = salary + 2000 where empno = '60003';
SELECT firstnme, lastname, salary from employee
where empno = '60003';
commit;

--Ex 4: Isolation level III "Repeatable read"
-- BM DB2 "Repeatable read Read Stability"
update employee set salary = 50000 where empno = '60003';
update employee set salary = 50000 where empno = '60001';
commit;

set current isolation level RS;
 SELECT firstnme, lastname, salary from employee
where empno = '60003';
 SELECT firstnme, lastname, salary from employee
where empno = '60001';


--Ex 4.2
 SELECT firstnme, lastname, salary from employee
where empno = '60003';
 SELECT firstnme, lastname, salary from employee
where empno = '60001';

--Isolation Level IV "SERIALIZABLE"
-- IBMDB2 "REepeatable Read", RR
-- No Phantom Read 
update employee set salary = 50000 where empno = '60003';
update employee set salary = 50000 where empno = '60001';
commit;

set current isolation level RR;
 SELECT firstnme, lastname, salary from employee
where empno = '60003';
 SELECT firstnme, lastname, salary from employee
where empno = '60001';--not phantom

commit;

select firstnme, lastname, salary from employee
	 where firstnme like 'S%';
	 
