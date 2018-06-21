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
IF(@currentEmpoyeeProj>=3)
	RAISERROR('The employee has too many projects!',16,1)
ELSE
BEGIN
	INSERT INTO EmployeesProjects VALUES
	(@emloyeeId , @projectID)
END

GO
--Using Trabsatcions. Compile time error

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
		RETURN 
	END
COMMIT
END
	
--Colleague's Approach

CREATE PROC usp_AssignProject(@EmloyeeId INT , @ProjectID INT)
AS
BEGIN TRANSACTION
DECLARE @ProjectsCount INT;
SET @ProjectsCount = (SELECT COUNT(ProjectID) 
						FROM EmployeesProjects 
					   WHERE EmployeeID = @emloyeeId)
IF(@ProjectsCount >= 3)
BEGIN 
 ROLLBACK
 RAISERROR('The employee has too many projects!', 16, 1)
 RETURN
END
INSERT INTO EmployeesProjects
     VALUES
(@EmloyeeId, @ProjectID)
 
 COMMIT