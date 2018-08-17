
SELECT	d.Name AS [Department Name],
		CASE
			WHEN AVG(DATEDIFF(DAY,r.OpenDate,r.CloseDate)) IS NULL THEN 'no info'
			ELSE  CONCAT (AVG(DATEDIFF(DAY,r.OpenDate,r.CloseDate)),'')
			END as [Average Duration]
FROM Departments AS d
JOIN Categories AS c ON c.DepartmentId=d.Id
JOIN Reports AS r oN r.CategoryId=c.Id
GROUP BY d.Name
ORDER BY d.Name


--OAni

SELECT d.Name, 
	ISNULL(CONVERT(VARCHAR(10),AVG(DATEDIFF(DAY,r.OpenDate,r.CloseDate)),'no info') 
AS [Average Duration]
FROM Departments AS d
JOIN Categories AS c ON c.DepartmentId=d.Id
JOIN Reports AS r oN r.CategoryId=c.Id
GROUP BY d.Name