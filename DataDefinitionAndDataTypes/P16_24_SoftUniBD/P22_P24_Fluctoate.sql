UPDATE Employees
SET Salary*=1.1

SELECT FirstName, LastName, JobTitle, Salary FROM Employees
ORDER BY Salary DESC

--P23
USE HotelDB

UPDATE Payments
SET TaxRate-=3
SELECT TaxRate FROM Payments

--P24

TRUNCATE TABLE Occupancies

SELECT * FROM Occupancies