

SELECT m.FirstName+' '+m.LastName AS Mechanic,
		COUNT(j.JobId) AS Jobs		
FROM Mechanics AS m
LEFT JOIN Jobs  AS j
ON j.MechanicId =m.MechanicId
WHERE Status IN('In Progress','Pending')
GROUP BY m.MechanicId,m.FirstName,m.LastName
HAVING COUNT(j.JobId)>1
ORDER BY Jobs DESC
