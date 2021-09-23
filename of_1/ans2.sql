SELECT DISTINCT D2.managerid
FROM (SELECT DISTINCT D.managerid,SUM(D.budget) AS tempBudget 
FROM Dept D GROUP BY D.managerid)
AS D2 WHERE D2.tempBudget = (SELECT MAX(D2.tempBudget) FROM D2)