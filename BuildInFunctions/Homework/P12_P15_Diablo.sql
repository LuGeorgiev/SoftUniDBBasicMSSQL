USE Diablo
GO

--P12
SELECT TOP(50) Name,
		CONVERT(DATE,[Start]) AS Start
  FROM Games
 WHERE DATEPART(YEAR,[Start])=2011 
   OR DATEPART(YEAR,[Start])=2012
 ORDER BY Start, [Name]

 --P13
 SELECT Username,
		RIGHT(Email,LEN(Email)-CHARINDEX('@',Email)) 
		AS[Email Provider]
 FROM Users
 ORDER BY [Email Provider]

 --P14

 SELECT Username,IpAddress AS [IP Address]
 FROM Users
 WHERE IpAddress LIKE('___.1%.%.___')
 ORDER BY Username

 --P15
 SP_RENAME 'Games.Duration','DurationId','Column'
 
 SELECT *
 FROM Games

 SELECT Name AS Game,
	CASE
		WHEN DATEPART(HOUR,Start)>=0 AND DATEPART(HOUR,Start)<12 THEN 'Morning'
		WHEN DATEPART(HOUR,Start)>=12 AND DATEPART(HOUR,Start)<18 THEN 'Afternoon'
		ELSE 'Evening'
	END AS [Part of the Day],	
	CASE	
		WHEN DurationId<=3 THEN 'Extra Short'
		WHEN DurationId<=6 THEN 'Short'
		WHEN DurationId>6 THEN 'Long'
		ELSE 'Extra Long'
	END AS Duration
 FROM Games
 ORDER BY Name,DurationId DESC