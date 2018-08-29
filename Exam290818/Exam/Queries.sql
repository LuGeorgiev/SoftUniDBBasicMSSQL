use Supermarket



SELECT Id, FirstName
FROM Employees
WHERE Salary>6500
ORDER BY FirstName,Id


GO
--6

SELECT FirstName+' '+LastName AS [Full Name],
Phone AS [Phone Number]
FROM Employees
WHERE Phone LIKE '3%'
ORDER BY FirstName,Phone

--7

SELECT FirstName,LastName, Count(*)
FROM Employees AS e
JOIN Orders AS o ON o.EmployeeId=e.Id
GROUP BY FirstName,LastName
ORDER BY COUNT(*) DESC, FirstName

--8

SELECT FirstName,LastName, AVG(DATEDIFF(HOUR,CheckIn,CheckOut)) AS [Work hours]
FROM Employees AS e
JOIN Shifts AS s ON s.EmployeeId=e.Id
GROUP BY FirstName,LastName, e.Id
HAVING AVG(DATEDIFF(HOUR,CheckIn,CheckOut))>7
ORDER BY AVG(DATEDIFF(HOUR,CheckIn,CheckOut)) DESC, e.Id

--9

SELECT TOP(1) 
		o.Id AS OrderId,
		SUM(i.Price*oi.Quantity) AS [TotalPrice]
FROM Orders as o
JOIN OrderItems as oi ON oi.OrderId=o.Id
JOIN Items as i ON i.Id=oi.ItemId
GROUP BY o.Id
ORDER BY SUM(i.Price*oi.Quantity) DESC



--10
WITH cte_High AS
(
SELECT OrderId,Price AS High
FROM(
SELECT  o.Id AS OrderId,	
		i.Price AS Price,		
		DENSE_RANK () OVER(PARTITION BY o.Id ORDER BY i.Price DESC) AS Ranked
FROM Orders as o
JOIN OrderItems as oi ON oi.OrderId=o.Id
JOIN Items as i ON i.Id=oi.ItemId
GROUP BY o.Id,i.price) As h
WHERE Ranked=1
 ),
cte_Low AS
(
SELECT OrderId,Price AS Low
FROM(
SELECT  o.Id AS OrderId,	
		i.Price AS Price,		
		DENSE_RANK () OVER(PARTITION BY o.Id ORDER BY i.Price) AS Ranked
FROM Orders as o
JOIN OrderItems as oi ON oi.OrderId=o.Id
JOIN Items as i ON i.Id=oi.ItemId
GROUP BY o.Id,i.price) AS Low
WHERE Ranked=1
)

SELECT TOP(10) Lo.OrderId,Hi.High AS ExpensivePrice, Lo.Low AS CheapPrice
FROM cte_Low AS Lo
JOIN cte_High AS Hi ON Hi.OrderId=Lo.OrderId
ORDER BY ExpensivePrice DESC, Lo.OrderId

--11

SELECT e.Id, FirstName,LastName
FROM Employees AS e
JOIN Orders AS o ON o.EmployeeId=e.Id
GROUP BY e.Id, FirstName,LastName
ORDER BY e.Id


--12

SELECT e.Id, FirstName+' '+LastName AS [Full Name]
FROM Employees AS e
JOIN Shifts AS s ON s.EmployeeId=e.Id
GROUP BY FirstName,LastName, e.Id, DATEDIFF(HOUR,CheckIn,CheckOut)
HAVING DATEDIFF(HOUR,CheckIn,CheckOut) <4
ORDER BY e.Id

--13

SELECT TOP(10) FirstName+' '+LastName AS [Full Name],
	SUM(oi.Quantity*i.Price) AS [Total Price],
	SUM(oi.Quantity) AS Items
FROM Employees AS e
JOIN Orders AS o ON o.EmployeeId=e.Id
JOIN OrderItems AS oi ON oi.OrderId=o.Id
JOIN Items AS i ON i.Id=oi.ItemId
WHERE o.DateTime<'2018-06-15'
GROUP BY FirstName+' '+LastName
ORDER BY [Total Price] DESC, Items DESC

--14


SELECT FirstName+' '+LastName AS [Full Name],
DATENAME(WEEKDAY,CheckIn)
FROM Employees AS e
JOIN Shifts AS s ON s.EmployeeId=e.Id
LEFT JOIN Orders AS o ON o.EmployeeId=e.Id
WHERE DATEDIFF(HOUR,CheckIn,CheckOut)>12 AND o.Id IS NULL
ORDER BY e.Id

--15

SELECT FirstName+' '+LastName AS [Full Name],
		DATEDIFF(HOUR,CheckIn, CheckOut) AS WorkHours,		
		SUM(oi.Quantity*i.Price) AS TotalPrice,
		DENSE_RANK() OVER(PARTITION BY FirstName+' '+LastName ORDER BY SUM(oi.Quantity*i.Price)DESC )	
FROM Employees AS e
JOIN Orders AS o ON o.EmployeeId=e.Id
JOIN OrderItems AS oi ON oi.OrderId=o.Id
JOIN Items AS i ON i.Id=oi.ItemId
JOIN Shifts AS s ON s.Id=e.Id
GROUP BY FirstName+' '+LastName, o.Id,DATEDIFF(HOUR,CheckIn, CheckOut)
ORDER BY FirstName+' '+LastName, WorkHours DESC ,SUM(oi.Quantity*i.Price) DESC

--16

SELECT DAY(o.DateTime) As DAY,
	FORMAT(AVG(oi.Quantity*i.Price),'N2') AS [Total profit]
FROM Orders AS O
JOIN OrderItems AS oi ON oi.OrderId=o.Id
JOIN Items AS i ON i.Id=oi.ItemId
GROUP BY DAY(o.DateTime)
ORDER BY DAY(o.DateTime)

--17

SELECT i.Name AS Item,
		c.Name AS Category,
		SUM (oi.Quantity) AS [Count],
		CAST(SUM(oi.Quantity*i.Price) AS decimal(15,2)) AS TotalPrice 
FROM Items As i
LEFT JOIN OrderItems AS oi ON i.Id=oi.ItemId
LEFT JOIN Categories AS c ON c.Id=i.CategoryId
GROUP BY i.Name, c.Name
ORDER BY TotalPrice DESC, [Count] DESC


