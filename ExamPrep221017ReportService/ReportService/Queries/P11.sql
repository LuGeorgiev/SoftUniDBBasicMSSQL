
SELECT OpenDate,Description, u.Email AS [Reporter Email]
FROM Reports AS r
JOIN Categories AS c ON c.Id=r.CategoryId
JOIN Departments AS d ON d.Id=c.DepartmentId
JOIN Users AS u ON u.Id=r.UserId
WHERE CloseDate IS NULL
	AND LEN(Description)>20
	AND Description LIKE  '%str%'
	AND d.Id IN(1,4,5)
ORDER BY OpenDate, u.Email, r.Id