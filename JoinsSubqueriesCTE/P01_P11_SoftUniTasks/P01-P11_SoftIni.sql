 use SoftUni  
   --P01
   SELECT TOP(5) EmployeeID AS EmployeeId,
	 	   JobTitle AS JobTitle,
	   	   e.AddressID AS AddressId,
		   a.AddressText AS AddressText
      FROM Employees AS e
INNER JOIN Addresses AS a
        ON a.AddressID=e.AddressID
  ORDER BY AddressId

--P02
 SELECT TOP(50)  
		   e.FirstName,
	 	   e.LastName,
	   	   t.Name AS Town,
		   a.AddressText
      FROM Employees AS e
INNER JOIN Addresses AS a
        ON a.AddressID=e.AddressID
INNER JOIN Towns AS t
		ON t.TownID=a.TownID
  ORDER BY e.FirstName,e.LastName

  --P03
  --HAVE TO BE SORTED IF DO NOT PASS JUDGE
  SELECT e.EmployeeID,
	e.FirstName,
	e.LastName,
	d.Name AS DepartmentName
  FROM Employees AS e
  INNER JOIN Departments AS d
  ON e.DepartmentID=d.DepartmentID
  WHERE d.Name='Sales'

  --P04
  SELECT TOP(5)
		e.EmployeeID,
		e.FirstName,
		e.Salary,
		d.Name AS DepartmentName
   FROM Employees AS e
  INNER JOIN Departments AS d
    ON e.DepartmentID=d.DepartmentID
 WHERE e.Salary>15000
 ORDER BY e.DepartmentID

 --P05
 SELECT TOP(3)
		em.EmployeeID,
		em.FirstName
   FROM Employees AS em
 LEFT JOIN EmployeesProjects AS emPrj
     ON em.EmployeeID=emPrj.EmployeeID
  WHERE emPrj.ProjectID IS NULL
  ORDER BY em.EmployeeID

  --P06
  SELECT FirstName,
	LastName,
	HireDate,
	d.Name AS DeptName
  FROM Employees AS a
  INNER JOIN Departments AS d
  ON a.DepartmentID=d.DepartmentID
  WHERE HireDate>'1.1.1999' AND d.Name IN ('Sales','Finance')
  ORDER BY HireDate

  --Second way

  SELECT e.FirstName,
		 e.LastName,
		 e.HireDate,
		 d.Name AS deptName
  FROM  (
		   SELECT *
		     FROM Employees
		    WHERE HireDate>'1.1.1999') AS e
INNER JOIN Departments AS d
	    ON e.DepartmentID=d.DepartmentID
     WHERE d.Name IN ('Sales','Finance')
  ORDER BY HireDate

--P07

SELECT TOP(5) e.EmployeeID,
	   e.FirstName,
	   p.Name AS ProjectName 
FROM Employees AS e
INNER JOIN EmployeesProjects AS ep
ON ep.EmployeeID = e.EmployeeID
INNER JOIN Projects AS p	
ON p.ProjectID = ep.ProjectID
WHERE  p.EndDate IS NULL AND p.StartDate>'8.13.2002'
ORDER BY e.EmployeeID

--P08 
SELECT e.EmployeeID,
	   e.FirstName,
	   ProjectName=	
		CASE
			WHEN p.StartDate >='1.1.2005' THEN NULL
			ELSE  p.Name
		END 
   FROM EmployeesProjects AS ep
   JOIN Employees AS e
     ON e.EmployeeID=ep.EmployeeID
   JOIN Projects AS p
     ON p.ProjectID=ep.ProjectID
  WHERE e.EmployeeID=24

  --P09

  SELECT e.EmployeeID,
		 e.FirstName,		 
		 e.ManagerID,
		 m.FirstName AS ManagerName
  FROM Employees AS e
  JOIN Employees AS m
  ON m.EmployeeID=e.ManagerID
  WHERE e.ManagerID IN (3,7)
  ORDER BY EmployeeID


  --P10
 SELECT TOP(50)
		  e.EmployeeID,
		 e.FirstName+' '+e.LastName AS EmployeeName,		
		 m.FirstName+' '+m.LastName AS ManagerName,
		 d.Name AS DepartmentName
    FROM Employees AS e
    JOIN Employees AS m
      ON m.EmployeeID=e.ManagerID
    JOIN Departments AS d
      ON e.DepartmentID=d.DepartmentID
ORDER BY e.EmployeeID

--P11

WITH AVGSalary_CTE (Salary)
AS
(
	SELECT AVG(Salary)
	FROM Employees
	GROUP BY DepartmentID
)

SELECT MIN(AVGSalary_CTE.Salary) AS MinAverageSalary
FROM AVGSalary_CTE
