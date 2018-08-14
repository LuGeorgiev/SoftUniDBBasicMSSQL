

SELECT TOP(5) C.Id, C.Name AS City, C.CountryCode AS Country, COUNT(c.Id) AS Accounts
FROM Cities C JOIN Accounts A
ON C.Id=A.CityId
GROUP BY C.CountryCode, C.Id, C.Name
ORDER BY COUNT(c.Id) DESC