USE SotUni

--P13
SELECT DepartmentID,
	  SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY DepartmentID

--P14
  SELECT DepartmentID,
	     MIN(Salary) AS MinimumSalary
	FROM Employees
   WHERE DepartmentID IN (2,5,7) 
		 AND HireDate>'01/01/2000'
GROUP BY DepartmentID

--P15 

SELECT *
INTO NewTable
FROM Employees
WHERE Salary>30000

DELETE FROM NewTable
WHERE ManagerID=42

UPDATE NewTable
SET Salary+=5000
WHERE DepartmentID=1

  SELECT DepartmentID,
		 AVG(Salary) AS AverageSalary
	FROM NewTable
GROUP BY DepartmentID


--P16
SELECT DepartmentID,
MAX(Salary) AS MaxSalary
FROM Employees
WHERE NOT Salary BETWEEN 30000 AND 70000
GROUP BY DepartmentID

--P17
SELECT COUNT(*) AS [Count]
FROM Employees
WHERE ManagerID IS NULL

--P18
 SELECT DepartmentID, 
		(SELECT DISTINCT Salary FROM Employees 
				   WHERE DepartmentID = e.DepartmentID 
		       ORDER BY Salary DESC 
						OFFSET 2 ROWS 
						FETCH NEXT 1 ROWS ONLY) AS ThirdHighestSalary
   FROM Employees e
   WHERE (SELECT DISTINCT Salary FROM Employees 
		   WHERE DepartmentID = e.DepartmentID 
	    ORDER BY Salary DESC 
				 OFFSET 2 ROWS 
				 FETCH NEXT 1 ROWS ONLY) 
		IS NOT NULL
GROUP BY DepartmentID

--19

SELECT TOP(10) FirstName,LastName,DepartmentID
FROM Employees 
WHERE Salary>(SELECT AVG(e2.Salary)
						FROM Employees e2
						WHERE DepartmentID=e2.DepartmentID)
												
ORDER BY DepartmentID