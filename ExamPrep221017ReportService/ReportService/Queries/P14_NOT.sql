
SELECT Name, CONCAT(Opened,'/',em.Closed) AS [Closed Open Reports]
FROM(
SELECT CONCAT(FirstName,' '+LastName) AS Name,
		CASE 		
			WHEN CloseDate IS NULL THEN 1
			ELSE 0
		END AS [Opened],
		COUNT(r.CloseDate) AS Closed	
FROM Employees AS e
JOIN Reports AS r ON r.EmployeeId=e.Id
WHERE (CloseDate IS NULL AND YEAR(r.OpenDate)=2016)
	OR (YEAR(CloseDate)=2016 AND YEAR(OpenDate)<=2016 )
GROUP BY CONCAT(FirstName,' '+LastName), CloseDate
)
As em
GROUP


SELECT Name, CONCAT(MAX(Closed),'/',Count(Opened)) AS [Closed Open Reports]
FROM(
SELECT CONCAT(FirstName,' '+LastName) AS Name,
		CASE 		
			WHEN CloseDate IS NULL THEN 1
			ELSE 0
		END AS [Opened],
		CASE
			WHEN CloseDate IS NOT NULL THEN COUNT(*)
			ELSE 0
		END AS Closed	
FROM Employees AS e
JOIN Reports AS r ON r.EmployeeId=e.Id
WHERE (CloseDate IS NULL AND YEAR(r.OpenDate)=2016)
	OR (YEAR(CloseDate)=2016 AND YEAR(OpenDate)<=2016 )
GROUP BY CONCAT(FirstName,' '+LastName), CloseDate,OpenDate) As em
GROUP BY Name
ORDER BY Name


SELECT CONCAT(FirstName,' '+LastName) AS Name,
		CASE 		
			WHEN CloseDate IS NULL THEN count(*)
			ELSE 0
		END AS [Opened],
		CASE
			WHEN CloseDate IS NOT NULL THEN COUNT(*)
			ELSE 0
		END AS Closed	
FROM Employees AS e
JOIN Reports AS r ON r.EmployeeId=e.Id
WHERE (CloseDate IS NULL AND YEAR(r.OpenDate)=2016)
	OR (YEAR(CloseDate)=2016 AND YEAR(OpenDate)<=2016 )
GROUP BY CONCAT(FirstName,' '+LastName), CloseDate,OpenDate

--Task 14 - Count open and closed reports per employee in the last month
SELECT E.Firstname+' '+E.Lastname AS FullName, 
	   ISNULL(CONVERT(varchar, CC.ReportSum), '0') + '/' +        
       ISNULL(CONVERT(varchar, OC.ReportSum), '0') AS [Stats]
	  
FROM Employees AS E
JOIN (SELECT EmployeeId,  COUNT(1) AS ReportSum
	  FROM Reports R
	  WHERE  YEAR(OpenDate) = 2016
	  GROUP BY EmployeeId) AS OC ON OC.Employeeid = E.Id
LEFT JOIN (SELECT EmployeeId,  COUNT(1) AS ReportSum
	       FROM Reports R
	       WHERE  YEAR(CloseDate) = 2016
	       GROUP BY EmployeeId) AS CC ON CC.Employeeid = E.Id
ORDER BY FullName