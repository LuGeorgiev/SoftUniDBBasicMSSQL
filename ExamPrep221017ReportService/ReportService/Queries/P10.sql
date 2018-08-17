USE ReportService

SELECT CONCAT(e.FirstName,' '+e.LastName)AS Name, Count(us.Id)As [Users Number]
FROM Employees AS e
JOIN Reports AS r ON r.EmployeeId=e.Id
JOIN Users AS us ON  us.Id=r.UserId
GROUP BY CONCAT(e.FirstName,' '+e.LastName)
ORDER BY Count(us.Id) DESC, CONCAT(e.FirstName,' '+e.LastName)

--Andriana

SELECT DISTINCT CONCAT(e.FirstName,' '+e.LastName)AS Name,
COUNT(r.UserId) AS [Users Number]
FROM Reports as r
RIGHT JOIN Employees AS e ON e.Id=r.EmployeeId
GROUP BY CONCAT(e.FirstName,' '+e.LastName)
ORDER BY [Users Number] DESC, Name