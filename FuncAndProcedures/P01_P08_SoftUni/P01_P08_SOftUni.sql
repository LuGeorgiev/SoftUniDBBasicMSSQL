USE SoftUni
SELECT*
FROM Employees

GO

--P01
CREATE PROC dbo.usp_GetEmployeesSalaryAbove35000 
AS
	SELECT FirstName,LastName
	FROM Employees
	WHERE Salary>35000;
	
GO
EXEC usp_GetEmployeesSalaryAbove35000

--P02
GO

CREATE PROC dbo.usp_GetEmployeesSalaryAboveNumber (@minSalary INT=35000)
AS
	SELECT FirstName,LastName
	FROM Employees
	WHERE Salary>@minSalary;

GO
EXEC usp_GetEmployeesSalaryAboveNumber 48100

--P03

SELECT * 
From Towns
GO

CREATE OR ALTER PROC dbo.usp_GetTownsStartingWith (@startWith NVARCHAR(10))
AS
	SELECT Name
	FROM Towns
	WHERE CHARINDEX(@startWith,Name)=1 ;

EXEC usp_GetTownsStartingWith b

--P04
GO

CREATE OR ALTER PROC dbo.usp_GetEmployeesFromTown (@TownName VARCHAR(15))
AS
	SELECT e.FirstName, e.LastName
	FROM Employees AS e
	INNER JOIN Addresses AS a
	ON a.AddressID=e.AddressID
	INNER JOIN Towns AS t
	ON t.TownID=a.TownID
	WHERE t.Name=@TownName

EXEC usp_GetEmployeesFromTown Sofia

--P05
GO

CREATE FUNCTION ufn_GetSalaryLevel (@salary DECIMAL(18,4))
RETURNS VARCHAR (10)
BEGIN
	DECLARE @salaryLevel VARCHAR(10)
	IF(@salary<3000)
		SET @salaryLevel = 'Low'
	ELSE IF(@salary<=50000)
		SET @salaryLevel='Average'
	ELSE 
		SET @salaryLevel='High'
	RETURN @salaryLevel
END

--P06
GO
--P06
CREATE OR ALTER PROC dbo.usp_EmployeesBySalaryLevel (@SalaryLevel VARCHAR(10))
AS
	SELECT FirstName,
	LastName
	FROM Employees
	WHERE dbo.ufn_GetSalaryLevel(Salary)=@SalaryLevel;


EXEC usp_EmployeesBySalaryLevel 'High'

GO

--P07

CREATE FUNCTION dbo.ufn_IsWordComprised
(@setOfLetters VARCHAR(40),@word VARCHAR (200))
RETURNS BIT
BEGIN
	DECLARE @counter INT 
	SET @counter=1
	WHILE @counter<=LEN(@word)
	BEGIN
		DECLARE @charToSearch VARCHAR
		SET @charToSearch = SUBSTRING(@word,@counter,1)
		IF(CHARINDEX(@charToSearch,@setOfLetters)=0)
			RETURN 0

		SET @counter=@counter+1
	END
	RETURN 1
END


SELECT dbo.ufn_IsWordComprised('oistmiahf', 'Sofia')	
GO

--P08
BACKUP DATABASE SotUni
TO DISK='C:\Users\lugeorgiev\Documents\Programming\SoftUni30052018.bak'

GO

CREATE OR ALTER PROC usp_DeleteEmployeesFromDepartment (@departmentId INT)
AS
BEGIN
	DELETE FROM EmployeesProjects
	WHERE EmployeeID IN(
		SELECT EmployeeID FROM Employees
		WHERE DepartmentID=@departmentId)
	
	ALTER TABLE Departments
	ALTER COLUMN ManagerID INT NULL;

	UPDATE Departments
	SET ManagerID=NULL
	WHERE ManagerID IN(
		SELECT EmployeeID FROM Employees
		WHERE DepartmentID=@departmentId)

	UPDATE Employees
	SET ManagerID=NULL
	WHERE ManagerID IN(
		SELECT EmployeeID FROM Employees
		WHERE DepartmentID=@departmentId)

	DELETE FROM Employees
	WHERE DepartmentID=@departmentId

	SELECT COUNT(*)
	FROM Employees
	WHERE DepartmentID=departmentId
END;

EXEC dbo.usp_DeleteEmployeesFromDepartment 3
GO

SELECT*
FROM Employees
WHERE DepartmentID=3

GO
USE master
DROP DATABASE SotUni

RESTORE DATABASE SoftUni
FROM DISK = 'C:\Users\lugeorgiev\Documents\Programming\SoftUni30052018.bak'