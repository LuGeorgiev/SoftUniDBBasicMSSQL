

SELECT m.FirstName+' '+m.LastName AS Mechanic,
		AVG( DATEDIFF(DAY,j.IssueDate,j.FinishDate)) AS [Average Days]		
FROM Mechanics AS m
LEFT JOIN Jobs  AS j
ON j.MechanicId =m.MechanicId
WHERE Status='Finished'
GROUP BY m.MechanicId, m.FirstName,m.LastName
ORDER BY m.MechanicId

