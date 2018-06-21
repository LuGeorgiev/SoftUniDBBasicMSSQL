CREATE TABLE Deleted_Employees(
EmployeeId INT PRIMARY KEY IDENTITY, 
FirstName VARCHAR(50) NOT NULL, 
LastName VARCHAR(50) NOT NULL, 
MiddleName VARCHAR(50) , 
JobTitle VARCHAR(50) NOT NULL, 
DepartmentId INT FOREIGN KEY REFERENCES Departments(DepartmentID), 
Salary DECIMAL (15,4)
) 

GO
--P09

CREATE TRIGGER t_FiredEmpoylees ON Employees
AFTER DELETE
AS
BEGIN
	INSERT INTO Deleted_Employees(FirstName, LastName, MiddleName, JobTitle, DepartmentId, Salary)
	SELECT FirstName,LastName,MiddleName,JobTitle,DepartmentID,Salary
	FROM deleted
END
