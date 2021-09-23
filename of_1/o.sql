SELECT temp.managerid 
FROM (SELECT DISTINCT D.managerid,SUM(D.budget) AS tBudget 
FROM Dept D GROUP BY D.managerid) AS temp
WHERE MAX(tBudget) from temp