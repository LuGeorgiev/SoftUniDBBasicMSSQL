--5.	Showroom
--Select all Manufacturers with their Models ordered by Manufacturer name (ascending) then by Model Id (descending). 
--Required columns:
--?	Manufacturer
--?	Model


SELECT Manufacturer, Model
FROM Models
ORDER BY Manufacturer, Id DESC


--Find all clients who are born between 1977 and 1994. Order the clients by First Name and then by Last Name in ascending order, and finally by Id (ascending).
--Required columns:
--?	First Name
--?	Last Name


SELECT FirstName, LastName
FROM Clients
WHERE YEAR(BirthDate)>=1977 AND YEAR(BirthDate)<=1994
ORDER BY FirstName, LastName, Id

--7.	Spacious Office
--Select all offices which have a parking lot with more than 25 places. Order them by their Town’s name (ascending) and then by Office Id (ascending).
--Required columns:
--?	TownName
--?	OfficeName
--?	ParkingPlaces


SELECT t.Name AS TownName,
		o.Name AS OfficeName,
		o.ParkingPlaces
FROM Offices AS o
JOIN Towns As t ON t.Id=o.TownId
WHERE o.ParkingPlaces>25
ORDER BY t.Name, o.Id

--Show all available vehicles. (A vehicle is not available if it is reserved for an order and is not turned back yet)
--Required columns:
--?	Model
--?	Seats
--?	Mileage
--Order the results by Mileage (ascending), then by the Model’s number of seats (descending) and finally by Model Id (ascending).

--TODO
SELECT m.Model,m.Seats,v.Mileage
FROM Orders AS o
RIGHT JOIN Vehicles AS v ON o.VehicleId=v.Id
JOIN Models AS m ON m.Id=v.ModelId
WHERE o.ReturnDate IS NULL OR o.CollectionDate IS NULL 
OR (o.ReturnDate IS NOT NULL AND o.CollectionDate IS NOT NULL)
GROUP BY m.ID, m.Model,m.Seats,v.Mileage
ORDER BY Mileage, Seats DESC, m.Id

--9. Select all towns and show the total number of offices per each town.
--Required columns:
--?	TownName
--?	OfficesNumber
--Order the results by OfficesNumber descending and then by TownName ascending.

SELECT t.Name As TownName, COUNT(*) AS OfficesNumber
FROM Offices As o
JOIN Towns AS t ON t.Id=o.TownId
GROUP BY t.Name
ORDER BY COUNT(*) DESC, t.Name

--10.	Buyers Best Choice 
--Select all vehicle models and show how many times each of them have been ordered.
--Required columns:
--?	Manufacturer
--?	Model
--?	TimesOrdered
--Order by total TimesOrdered descending, then by Manufacturer descending and then by Model (ascending).

SELECT Manufacturer, Model, SUM(TimesOrdered) AS TimesOrdered
FROM(
	SELECT m.Manufacturer, m.Model, Count(o.Id) AS TimesOrdered
	FROM Orders AS o
	RIGHT JOIN Vehicles AS v ON o.VehicleId=v.Id
	RIGHT JOIN Models AS m ON m.Id=v.ModelId
	GROUP BY m.Manufacturer, m.Model, o.VehicleId) AS e
GROUP BY Manufacturer, Model
ORDER BY TimesOrdered DESC, Manufacturer DESC, Model 

--11.	Kinda Person
--Select the clients who have placed an order and print their most frequent choice of vehicle’s class. 
--If a client’s most frequent choice is equally spread over different vehicle classes show all the choices 
--on separate lines.
--Required columns:
--?	Names - Clients first and last name separated by space
--?	Class - Most frequent class choice
--Order them by client’s Names, then by Class and then by Client Id (all in ascending order).

SELECT Names,
		Class
FROM(
SELECT CONCAT(c.FirstName,' '+c.LastName) AS Names,
			c.Id AS ID,
			m.Class AS Class,
			COUNT(m.Class) AS Counts,
			DENSE_RANK() OVER(PARTITION BY CONCAT(c.FirstName,' '+c.LastName)
			 ORDER BY COUNT(m.class) DESC) AS Ranked			
	FROM Clients As c
	JOIN Orders AS o ON o.ClientId=c.Id
	JOIN Vehicles AS v ON v.Id=o.VehicleId
	JOIN Models AS m ON m.Id=v.ModelId		
	GROUP BY CONCAT(c.FirstName,' '+c.LastName), m.Class, c.Id
	) AS e
WHERE Ranked=1
ORDER BY Names,Class,ID

--12.	Age Groups Revenue
--Show the clients who have placed an order distributed in age groups according to the year they are born in:
--?	from 1970 until 1979 - labeled “70’s”
--?	from 1980 until 1989 - labeled “80’s”
--?	from 1990 until 1999 - labeled “90’s”
--?	all clients who doesn’t fall in none of the above groups should be put in the group “Others”
--For each group show the Revenue (sum of bills paid) and the average driven mileage.
--Order the results by Age Group (ascending).
--Required columns:
--?	Age Group
--?	Revenue
--?	AverageMileage

SELECT AgeGroup,
		SUM(Bill) AS Revenue,
		AVG(TotalMileage) AS AverageMileage
FROM(
	SELECT CASE
			WHEN YEAR(c.BirthDate)<=1979 AND YEAR(c.BirthDate)>=1970 THEN '70''s'
			WHEN YEAR(c.BirthDate)<=1989 AND YEAR(c.BirthDate)>=1980 THEN '80''s'
			WHEN YEAR(c.BirthDate)<=1999 AND YEAR(c.BirthDate)>=1990 THEN '90''s'
			ELSE 'Others'
		END AS AgeGroup,
		o.Bill,
		o.TotalMileage
	FROM Clients As c
	JOIN Orders AS o ON o.ClientId=c.Id
	JOIN Vehicles AS v ON v.Id=o.VehicleId	
	) AS e
GROUP BY AgeGroup

--13.	Consumption in Mind
--Select the seven most ordered vehicle models. Group them by manufacturers and show only these who have average fuel consumption between 5 and 15.
--Required columns:
--?	Manufacturer 
--?	AverageConsumption 
--Order them by Manufacturer alphabetically and then by AverageConsumption ascending.


SELECT Manufacturer,cons AS AverageConsumption
FROM(
	SELECT TOP(7) m.Id, 
		m.Manufacturer, 
		COUNT(o.Id) AS Ordered,
		AVG(m.Consumption) AS cons
	FROM Orders AS o
	JOIN Vehicles AS v ON v.Id=o.VehicleId
	JOIN Models AS m ON m.Id=v.ModelId
	GROUP BY m.Id, m.Manufacturer
	ORDER BY COUNT(o.Id) DESC) AS e
WHERE cons>=5 AND cons <=15
ORDER BY Manufacturer, cons

--14.	Debt Hunter
--Select the clients who have placed an order with invalid credit card. Show only the first two clients per town with the biggest Bill. An order is invalid when the card’s validity date is before the collection date.
--Order them by Town’s Name alphabetically, then by Bill Amount (descending) and then by Client Id (ascending).
--Required columns:
--?	Names
--?	Email
--?	Bill
--?	Town

SELECT [Category Name],
		Email,
		Bill,
		Town		
FROM(
	SELECT CONCAT(FirstName,' ',LastName) AS [Category Name],
		Email,
		Bill,
		t.Name AS Town,
		RANK() OVER (PARTITION BY t.Name ORDER BY Bill DESC) AS Ranked
	FROM Clients as C
	JOIN Orders AS o ON o.ClientId=c.Id
	JOIN Towns AS t ON t.Id=o.TownId
	WHERE c.CardValidity < o.CollectionDate AND Bill IS NOT NULL	
	) AS e
WHERE Ranked IN (1,2)
ORDER BY Town, Bill 

--15.	Town Statistics
--Select all towns and show the distribution of the placed orders between male and female clients in percentages.
--Required columns:
--?	TownName
--?	MalePercent
--?	FemalePercent
--Order them by TownName alphabetically and then by Town Id ascending.
GO

WITH cte_Males 
AS
(
SELECT t.Id AS [TownId],
               t.Name AS [Town],
               COUNT(c.Id) AS [Male]
          FROM Clients c
     LEFT JOIN Orders o
            ON o.ClientId = c.Id
     LEFT JOIN Towns t
            ON t.Id = o.TownId
         WHERE c.Gender = 'M'
      GROUP BY t.Name,
               t.Id
),
cte_Females 
AS
(
SELECT t.Id AS [TownId],
               t.Name AS [Town],
               COUNT(c.Id) AS [Female]
          FROM Clients c
     LEFT JOIN Orders o
            ON o.ClientId = c.Id
     LEFT JOIN Towns t
            ON t.Id = o.TownId
         WHERE c.Gender = 'F'
      GROUP BY t.Name,
               t.Id
)

SELECT t.Name AS TownName,
		CAST(m.Male * 100 / (ISNULL(m.Male, 0) + ISNULL(f.Female, 0)) AS INT) AS [MalePercent],
        CAST(f.Female * 100 / (ISNULL(m.Male, 0) + ISNULL(f.Female, 0)) AS INT) AS [FemalePercent]
FROM Towns AS t
LEFT JOIN cte_Males AS m ON m.TownId=t.Id
LEFT JOIN cte_Females AS f ON f.TownId=t.Id
ORDER BY t.Name, t.Id

--16.	Home Sweet Home
--Select all vehicles and show their current location:
--•	If a vehicle has never been on a rent, it’s location should be labeled as “home”
--?	If a vehicle has been turned back from rent to an office different from it’s home one - print the name of the town and the name of the office, it was turned back to in the following format - “TownName - OfficeName”
--?	If a vehicle is rented and still not turned back, it’s location should be labeled as “on a rent”
--Required columns:
--?	Vehicle - print the manufacturer’s name and the model’s name in the following format - “Manufacturer - Model”
--?	Location
--Order them by vehicle alphabetically and then by vehicle Id (ascending).

WITH cte_AllCars 
AS
(
        SELECT v.Id,
               o.ReturnOfficeId,
               v.OfficeId,
               m.Manufacturer,
               m.Model,
               DENSE_RANK() OVER (PARTITION BY v.Id ORDER BY o.CollectionDate DESC) AS [Rank]
          FROM Vehicles AS v
    INNER JOIN Models m 
            ON m.Id = v.ModelId
     LEFT JOIN Orders o 
            ON o.VehicleId = v.Id
)

  SELECT CONCAT(cte.Manufacturer, ' - ',  cte.Model) AS [Vehicle],
         CASE
             WHEN (SELECT COUNT(*) FROM Orders WHERE VehicleId = cte.Id) = 0 OR cte.OfficeId = cte.ReturnOfficeId THEN 'home'
             WHEN cte.ReturnOfficeId IS NULL THEN 'on a rent'
             WHEN cte.OfficeId <> cte.ReturnOfficeId THEN
                  (    SELECT CONCAT(t.[Name], ' - ', o.[Name])
                         FROM Offices AS o
                   INNER JOIN Towns AS t ON t.Id = o.TownId
                        WHERE cte.ReturnOfficeId = o.Id)
         END AS [Location]
    FROM cte_AllCars cte
   WHERE cte.[Rank] = 1
ORDER BY Vehicle, 
         cte.Id

SELECT *
FROM Models