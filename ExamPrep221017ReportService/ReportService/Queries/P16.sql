USE ReportService


SELECT  [Department Name],
		[Category Name],
		ROUND((CAST(Cats AS float)/Deps)*100,0) as [Percentage]
FROM(
	SELECT	d.Name AS [Department Name],
			c.Name AS [Category Name],		
			COUNT(r.Id) OVER(PARTITION BY d.Name) AS Deps,
			COUNT(r.Id) OVER(PARTITION BY d.Name, c.Name) AS Cats,
			ROW_NUMBER() OVER(PARTITION BY d.Name, c.Name ORDER BY d.Name, c.Name) AS Ranked
	FROM Departments AS d
	 JOIN Categories AS c ON c.DepartmentId=d.Id
	 JOIN Reports AS r ON r.CategoryId=c.Id
	 WHERE r.UserId IS NOT NULL
	GROUP BY d.Name, c.Name, r.Id
	) AS e
WHERE Ranked=1
ORDER BY [Department Name],[Category Name],[Percentage]