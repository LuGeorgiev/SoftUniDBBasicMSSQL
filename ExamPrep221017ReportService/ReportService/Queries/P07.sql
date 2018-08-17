
SELECT FirstName, LastName,Description,FORMAT(OpenDate,'yyyy-MM-dd') AS OpenDate
FROM Reports AS r
JOIN Employees AS e ON r.EmployeeId=e.Id
ORDER BY e.Id, OpenDate, r.Id