USE Diablo
GO

--P12 CANNOT PASS JUDGE
SELECT TOP(50) Name,
		CONVERT(DATE,[Start]) AS Start
  FROM Games
 WHERE DATEPART(YEAR,[Start])=2011 
   OR DATEPART(YEAR,[Start])=2012
 ORDER BY Start, [Name]

 --P12 Secon way for Judge
 SELECT [Name],		
		FORMAT(Start,'yyyy-MM-dd') AS [Start Date]
FROM Games
WHERE (SELECT YEAR(Start)) IN (2011, 2012)
ORDER BY [Start Date], [Name]

 --P13
 SELECT Username,
		RIGHT(Email,LEN(Email)-CHARINDEX('@',Email)) 
		AS[Email Provider]
 FROM Users
 ORDER BY [Email Provider],Username

 --P14

 SELECT Username,IpAddress AS [IP Address]
 FROM Users
 WHERE IpAddress LIKE('___.1%.%.___')
 ORDER BY Username

 --P15
 --This is to change teh Column name to DurationId   SP_RENAME 'Games.Duration','DurationId','Column'
 

 SELECT *
 FROM Games

 SELECT Name AS Game,
	CASE
		WHEN DATEPART(HOUR,Start)<12 THEN 'Morning'
		WHEN DATEPART(HOUR,Start)<18 THEN 'Afternoon'
		ELSE 'Evening'
	END AS [Part of the Day],	
	CASE	
		WHEN Duration<=3 THEN 'Extra Short'
		WHEN Duration<=6 THEN 'Short'
		WHEN Duration>6 THEN 'Long'
		ELSE 'Extra Long'
	END AS [Duration]
 FROM Games
 ORDER BY Name,Duration