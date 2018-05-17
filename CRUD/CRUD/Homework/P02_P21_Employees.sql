USE SoftUni
--P02
SELECT * FROM Departments

--P03
SELECT Name 
  FROM Departments

--P04
SELECT FirstName,LastName,Salary 
  FROM Employees

--P05
SELECT FirstName,MiddleName, LastName 
  FROM Employees

--P06
SELECT FirstName+'.'+LastName+'@softuni.bg' 
  FROM Employees

--P07
SELECT DISTINCT Salary
  FROM Employees

 --P08
 SELECT * FROM Employees
 WHERE JobTitle='Sales Representative'

 --P09
 SELECT FirstName,LastName,JobTitle 
   FROM Employees
  WHERE Salary BETWEEN 20000 and 30000

 --P10
 SELECT FirstName+' '+MiddleName+' '+LastName AS [Full Name] 
   FROM Employees
  WHERE Salary IN( 25000, 14000,12500,23600)

 --P11
 SELECT FirstName,LastName 
   FROM Employees
  WHERE ManagerID IS NULL

 --P12
 SELECT FirstName,LastName,Salary 
   FROM Employees
  WHERE Salary>50000
ORDER BY Salary DESC

--P13
SELECT TOP (5) FirstName,LastName 
FROM Employees
ORDER BY Salary DESC

--P14
SELECT FirstName,LastName
  FROM Employees
 WHERE NOT DepartmentID = 4

 --P15
 SELECT *
 FROM Employees
 ORDER BY Salary DESC, FirstName,LastName DESC,MiddleName


 --P16
 CREATE VIEW v_EmployeeByFirstLastNameAndSalary AS
 SELECT FirstName,LastName,Salary
 FROM Employees

 SELECT * FROM v_EmployeeByFirstLastNameAndSalary

 --P17
 SELECT FirstName+' '+ISNULL(MiddleName,'')+' '+LastName AS [Full Name],
	    JobTitle
   FROM Employees

 --P18
 SELECT DISTINCT JobTitle
   FROM Employees

 --P19
 SELECT TOP(10) Name,Description,StartDate,EndDate
 FROM Projects
 ORDER BY StartDate,Name
 
 --P20
 SELECT TOP (7) FirstName,LastName,HireDate
 FROM Employees
 ORDER BY HireDate DESC

 --P21
 BACKUP DATABASE SoftUni
 TO DISK='C:\Users\lugeorgiev\Documents\Programming\SoftUni17052018.bak'
 
 --Action
 UPDATE Employees
	SET Salary *=1.12 
 FROM Employees
 WHERE DepartmentID IN (1,2,4,11)
	GO
 SELECT Salary
   FROM Employees

--Restore from backup
   USE master
   GO
DROP DATABASE SoftUni
   GO
RESTORE DATABASE SotUni
FROM DISK='C:\Users\lugeorgiev\Documents\Programming\SoftUni17052018.bak'

USE SotUni
GO
SELECT Salary,*
FROM Employees
 