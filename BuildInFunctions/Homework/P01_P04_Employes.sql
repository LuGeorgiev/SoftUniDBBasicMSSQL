USE SotUni

--P01
SELECT FirstName,LastName
FROM Employees
WHERE LEFT(FirstName,2)='SA'

--Second way

SELECT FirstName,LastName
FROM Employees
WHERE FirstName LIKE 'sa%'

--P02

SELECT FirstName,LastName
FROM Employees
WHERE LastName LIKE '%ei%'

--Second way
SELECT FirstName,LastName
FROM Employees
WHERE CHARINDEX('ei',LastName)>0

--P03
SELECT FirstName
FROM Employees
WHERE DepartmentID IN(3,10) 
AND HireDate >='1-1-1995'
AND HireDate<='12-31-2005'

--P04

SELECT FirstName,LastName
FROM Employees
WHERE JobTitle NOT LIKE('%engineer%') 