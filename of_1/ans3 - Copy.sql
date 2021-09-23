select E.ename  from Emp E where exists(
  select null from Dept D where (D.budget>1000000 and E.eid=D.managerid) and D.budget<5000000
);