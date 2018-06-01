SELECT *
FROM EmployeesProjects

GO
--Without transaction
CREATE PROC usp_AssignProject (@emloyeeId INT, @projectID INT)
AS
DECLARE @currentEmpoyeeProj INT
SET @currentEmpoyeeProj = (SELECT COUNT(*)
						  	FROM EmployeesProjects
							WHERE EmployeeID=@emloyeeId)
IF(@currentEmpoyeeProj>3)
	RAISERROR('The employee has too many projects!',16,1)
ELSE
BEGIN
	INSERT INTO EmployeesProjects VALUES
	(@emloyeeId , @projectID)
END

GO
--Using Trabsatcions

CREATE OR ALTER PROC usp_AssignProject (@emloyeeId INT, @projectID INT)
AS
BEGIN TRANSACTION
	INSERT INTO EmployeesProjects VALUES
		(@emloyeeId , @projectID)
	DECLARE @currentEmpoyeeProj INT
	SET @currentEmpoyeeProj = (SELECT COUNT(*)
						  		FROM EmployeesProjects
								WHERE EmployeeID=@emloyeeId)
	IF(@currentEmpoyeeProj>3)
	BEGIN
		RAISERROR('The employee has too many projects!',16,1)
		ROLLBACK
		--RETURN --Probably to be confirmed by Judge
	END
COMMIT
END
	


