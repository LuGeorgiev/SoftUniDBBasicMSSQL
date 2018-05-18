CREATE VIEW v_EmployeesHiredAfter200 
AS
SELECT FirstName,LastName
FROM Employees
WHERE DATEPART(YEAR,HireDate)>2000

SELECT *
FROM v_EmployeesHiredAfter200