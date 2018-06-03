

SELECT m.ModelId,
		m.Name,
		CONCAT(AVG(DATEDIFF(DAY,j.IssueDate,j.FinishDate)),' days') AS [Average Service Time]
FROM Jobs AS j
JOIN Models AS m ON m.ModelId=j.ModelId
WHERE j.Status='Finished'
GROUP BY m.Name, m.ModelId
ORDER BY AVG(DATEDIFF(DAY,j.IssueDate,j.FinishDate))
