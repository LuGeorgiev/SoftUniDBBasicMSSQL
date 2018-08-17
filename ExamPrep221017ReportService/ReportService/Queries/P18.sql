USE ReportService
go

CREATE PROC usp_AssignEmployeeToReport(@employeeId INT, @reportId INT)
AS 
BEGIN
	DECLARE @reportDepartmentId INT
	SET @reportDepartmentId = (
		SELECT c.DepartmentId
		FROM Reports AS r
		JOIN Categories AS c ON c.Id=r.CategoryId
		WHERE r.Id= @reportId
		)	

	DECLARE @empDepartmentId INT
	SET @empDepartmentId = (
		SELECT DepartmentId
		FROM Employees
		WHERE Id=@employeeId
	)

	IF(@empDepartmentId<>@reportDepartmentId)
		THROW 50013, 'Employee doesn''t belong to the appropriate department!', 1
	ELSE
	BEGIN
		UPDATE Reports
		SET EmployeeId=@employeeId
		WHERE Id=@reportId
	END
END

