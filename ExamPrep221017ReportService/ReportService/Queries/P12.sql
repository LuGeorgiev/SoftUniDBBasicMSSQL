USE ReportService

SELECT c.Name As [Category Name]
FROM Reports AS r
RIGHT JOIN Users AS u ON U.Id=r.UserId
RIGHT JOIN Categories AS c ON c.Id=r.CategoryId
WHERE MONTH(u.BirthDate)=MONTH(r.OpenDate)
	AND DAY(u.BirthDate)=DAY(r.OpenDate)
GROUP BY c.Name
ORDER BY c.Name

