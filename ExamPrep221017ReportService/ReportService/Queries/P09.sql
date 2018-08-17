
SELECT c.Name AS CategoryName, Count(*) AS [Employees Number]
FROM Employees AS e
JOIN Departments AS d ON d.Id=e.DepartmentId
JOIN Categories As c ON c.DepartmentId=d.Id
GROUP BY c.Name
ORDER BY c.Name