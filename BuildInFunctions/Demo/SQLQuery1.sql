USE SotUni

--P01
SELECT FirstName,LastName
FROM Employees
WHERE LEFT(FirstName,2)='SA'