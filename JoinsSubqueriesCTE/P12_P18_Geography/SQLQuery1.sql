USE Geography

SELECT *
FROM Peaks 

SELECT *
FROM Mountains

--P12
SELECT  mc.CountryCode,
		m.MountainRange,
		p.PeakName,
		p.Elevation
   FROM MountainsCountries AS mc
   JOIN Peaks AS p
     ON p.MountainId=mc.MountainId
   JOIN Mountains AS m
     ON m.Id=mc.MountainId
  WHERE mc.CountryCode='BG' AND Elevation>2835
ORDER BY Elevation DESC

--P13

SELECT CountryCode,
COUNT(*) MountainRanges
FROM MountainsCountries
WHERE CountryCode IN ('BG','RU','US')
GROUP BY CountryCode

--P14

SELECT TOP (5)
		  c.CountryName,		  
		  r.RiverName
     FROM Countries AS c
LEFT JOIN CountriesRivers AS cr
	   ON cr.CountryCode=c.CountryCode
LEFT JOIN Rivers AS r
	   ON r.Id=cr.RiverId
	WHERE c.ContinentCode='AF'
 ORDER BY c.CountryName

 --P15
 --Need explanations
 
 SELECT ContinentCode,
         CurrencyCode,
		 CurrencyUsage
 FROM(
 SELECT ContinentCode,
         CurrencyCode,
		 CurrencyUsage,
		 DENSE_RANK() OVER(PARTITION BY (ContinentCode) ORDER BY CurrencyUsage DESC )AS [Rank]
 FROM( 
  SELECT ContinentCode,
         CurrencyCode,
         COUNT(CurrencyCode) AS CurrencyUsage
    FROM Countries
GROUP BY ContinentCode,
         CurrencyCode) 
	  AS curencies) 
	  AS rankedCurrencies
   WHERE rankedCurrencies.Rank=1 and CurrencyUsage>1
ORDER BY ContinentCode


--P16

   SELECT COUNT(*) AS CountryCode
	 FROM Countries AS c
LEFT JOIN MountainsCountries AS mc
       ON mc.CountryCode=c.CountryCode
	WHERE MountainId IS NULL

	--SecondApproach
SELECT COUNT(CountryCode) AS CountryCode
FROM Countries
WHERE CountryCode NOT IN (SELECT CountryCode FROM MountainsCountries)

--P17

Select TOP(5) c.CountryName,
MAX(p.Elevation) AS HighestPeak,
MAX(r.Length) AS LongestRiverLength
FROM Countries AS c
LEFT JOIN MountainsCountries AS mc
ON mc.CountryCode=c.CountryCode
LEFT JOIN Peaks as p
ON p.MountainId=mc.MountainId
LEFT JOIN CountriesRivers AS cr
ON cr.CountryCode=c.CountryCode
LEFT JOIN Rivers AS r
ON r.Id=cr.RiverId
GROUP BY c.CountryName
ORDER BY HighestPeak DESC, LongestRiverLength DESC,c.CountryName

--18
--Laboratoty excercise

SELECT TOP(5) CountryName,
	   ISNULL(PeakName,'(no highest peak)') AS [Highest Peak Name],
	   ISNULL( Elevation,0) AS [Highest Peak Elevation],
	   ISNULL(MountainRange,'(no mountain)') AS Mountain
FROM(
	SELECT CountryName, Elevation, MountainRange,PeakName,
		DENSE_RANK() OVER (PARTITION BY CountryName ORDER BY Elevation DESC) AS [Rank]
	FROM(
		SELECT c.CountryName, p.Elevation, m.MountainRange,	p.PeakName		
		FROM Countries AS c
		LEFT JOIN MountainsCountries AS mc
		ON mc.CountryCode=c.CountryCode
		LEFT JOIN Mountains AS m
		ON m.Id=mc.MountainId
		LEFT JOIN Peaks AS p
		ON p.MountainId=m.Id) AS allPeaks)
	AS rankedPeaks 
WHERE Rank=1
ORDER BY CountryName, [Highest Peak Name]

--Mine try=dead-end
SELECT 
	c.CountryName AS Country,
	CASE
		WHEN p.PeakName IS NULL THEN '(no highest peak)'
		ELSE p.PeakName
	END AS [Highest Peak Name],
	CASE
		WHEN p.Elevation IS NULL THEN 0
		ELSE p.Elevation
	END AS [Highest Peak Elevation],
	CASE
		WHEN m.MountainRange IS NULL THEN '(no mountain)'
		ELSE m.MountainRange
	END AS Mountain
FROM Countries AS c
FULL JOIN MountainsCountries AS mc
ON mc.CountryCode=c.CountryCode
FULL JOIN Mountains AS m
ON m.Id=mc.MountainId
FULL JOIN Peaks AS p
ON p.MountainId=m.Id
GROUP BY c.CountryName,p.PeakName,m.MountainRange
ORDER BY c.CountryName, p.PeakName

--Not mine subquery
 SELECT c.CountryName,
           DENSE_RANK() OVER(PARTITION BY c.CountryName ORDER BY p.Elevation DESC) AS PeakRank,
           p.PeakName,
           p.Elevation,
           m.MountainRange
    FROM Countries AS c
         LEFT JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
         LEFT JOIN Mountains AS m ON mc.MountainId = m.Id
         LEFT JOIN Peaks AS p ON m.Id = p.MountainId

--Final 
SELECT TOP (5) jt.CountryName AS Country,
               ISNULL(jt.PeakName, '(no highest peak)') AS HighestPeakName,
               ISNULL(jt.Elevation, 0) AS HighestPeakElevation,
               ISNULL(jt.MountainRange, '(no mountain)') AS Mountain
FROM
(
    SELECT c.CountryName,
           DENSE_RANK() OVER(PARTITION BY c.CountryName ORDER BY p.Elevation DESC) AS PeakRank,
           p.PeakName,
           p.Elevation,
           m.MountainRange
    FROM Countries AS c
         LEFT JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
         LEFT JOIN Mountains AS m ON mc.MountainId = m.Id
         LEFT JOIN Peaks AS p ON m.Id = p.MountainId
) AS jt
WHERE jt.PeakRank = 1
ORDER BY jt.CountryName,
         jt.PeakName;