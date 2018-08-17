
SELECT c.Name AS CategoryName, COUNT(*) AS ReportsNumber
FROM Reports AS r
JOIN Categories AS c ON c.Id=r.CategoryId
GROUP BY c.Name
ORDER BY COUNT(*) DESC, c.Name