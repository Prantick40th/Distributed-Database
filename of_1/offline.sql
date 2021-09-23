clear screen;

--Drop table--
drop table Emp;
drop table Works;
drop table Dept;

--Creating table--
create table Emp(eid number, ename varchar2(25), age number, salary real);
create table works(eid number, did number, pct_time number);
create table Dept(did number, dname varchar2(15), budget real, managerid number);

--Inserting Data--
insert into Emp values(1, 'Alex', 25, 100000);
insert into Emp values(2, 'Bran', 32, 200000);
insert into Emp values(3, 'Clark', 30, 300000);
insert into Emp values(4, 'Dom', 28, 25000000);
insert into Emp values(5, 'Eleza', 26, 75000000);
insert into Emp values(6, 'Flame', 26, 5000000);

insert into works values(1, 04, 30);
insert into works values(1, 03, 35);
insert into works values(2, 01, 80);
insert into works values(2, 03, 15);
insert into works values(3, 05, 10);
insert into works values(4, 03, 20);
insert into works values(4, 05, 30);
insert into works values(4, 01, 40);
insert into works values(5, 04, 10);
insert into works values(6, 04, 50);
insert into works values(6, 08, 10);

insert into Dept values(04, 'CSE', 3400000, 6);
insert into Dept values(03, 'CIVIL', 1020000, 1);
insert into Dept values(05, 'EEE', 550000, 4);
insert into Dept values(01, 'Archi', 400000, 5);
insert into Dept values(08, 'TEXTILE', 4000000, 6);

commit;

--Table showing
select * from Emp;
select * from works;
select * from Dept;


/*1. Print the name of each employee whose salary exceeds 
the budget of all of the departments that he or she works in.*/

select e.ename 
from emp e where e.salary> ALL
(select D.budget from works w 
INNER JOIN Dept D on w.did = D.did 
INNER JOIN Emp e on w.eid = e.eid);

----------------------------------------------------------------

/*2. Find the managerids of managers who control the largest amounts*/


SELECT DISTINCT D.managerid,SUM(D.budget) as total
FROM Dept D where rownum <=3 GROUP BY D.managerid; 
--showing Top 3 ids

-----------------------------------------------------------------

/*3. Find the enames of managers who manage only departments with
budgets larger than $1 million, but at least one department with budget
less than $5 million.*/

select E.ename  from Emp E where EXISTS(
  select null from Dept D where (D.budget>1000000 and E.eid=D.managerid) and D.budget<5000000
);

-------------------------------------------------------------------



