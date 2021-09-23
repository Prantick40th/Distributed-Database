select e.ename 
from emp e where e.salary>all
(select D.budget from works w 
INNER JOIN Dept D on w.did = D.did 
INNER JOIN Emp e on w.eid = e.eid);