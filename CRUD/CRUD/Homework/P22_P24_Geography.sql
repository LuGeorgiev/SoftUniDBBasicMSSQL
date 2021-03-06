USE Geography
--P22

SELECT PeakName
FROM Peaks
ORDER BY PeakName

--P23
SELECT TOP(30) CountryName,Population
FROM Countries
WHERE ContinentCode = 'EU'
ORDER BY Population DESC, CountryName

---P24

SELECT CountryName,CountryCode,
CASE
	WHEN CurrencyCode='EUR' THEN 'Euro'
	ELSE 'Not Euro'
END AS CurrencyCode
FROM Countries
ORDER BY CountryName

---P25
USE Diablo

SELECT Name
FROM Characters
ORDER BY Name

--Reconfiguration for EntityFramework
EXEC sp_configure 'remote access', 0 ;  
GO  
RECONFIGURE ;  
GO  
