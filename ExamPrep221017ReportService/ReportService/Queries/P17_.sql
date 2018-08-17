
CREATE FUNCTION udf_GetReportsCount(@employeeId INT, @statusId INT)
RETURNS INT
BEGIN
	DECLARE @reportsCount INT

	SET @reportsCount=( SELECT COUNT(*)
	FROM Employees AS e
	JOIN Reports AS r ON r.EmployeeId=e.Id
	JOIN Status AS s ON s.Id=r.StatusId
	WHERE e.Id=@employeeId AND s.Id=@statusId)

	RETURN @reportsCount
END

GO

SELECT Id, FirstName, Lastname, dbo.udf_GetReportsCount(Id, 2) AS ReportsCount
FROM Employees
ORDER BY Id
