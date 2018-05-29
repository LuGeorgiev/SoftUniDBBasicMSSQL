USE Gringotts

SELECT *
FROM WizzardDeposits

--P01
SELECT COUNT(*) AS [Count]
FROM WizzardDeposits

--P02
SELECT TOP(1) MagicWandSize AS LongestMAgicWand
FROM WizzardDeposits
ORDER BY MagicWandSize DESC

--P03
  SELECT w.DepositGroup,
		 MAX(w.MagicWandSize) AS LongestMagicWand
	FROM WizzardDeposits AS w
GROUP BY w.DepositGroup

--P04
 SELECT TOP(2) w.DepositGroup		 
	FROM WizzardDeposits AS w
GROUP BY w.DepositGroup
ORDER BY AVG(w.MagicWandSize) DESC

--P05
  SELECT DepositGroup,
		 SUM(DepositAmount) AS TotalSum
	FROM WizzardDeposits
GROUP BY DepositGroup

--P06
SELECT DepositGroup,
		 SUM(DepositAmount) AS TotalSum
	FROM WizzardDeposits
   WHERE MagicWandCreator='Ollivander family'
GROUP BY DepositGroup

--P07
SELECT DepositGroup,
		 SUM(DepositAmount) AS TotalSum
	FROM WizzardDeposits
	WHERE MagicWandCreator='Ollivander family'
GROUP BY DepositGroup
HAVING SUM(DepositAmount)<150000
ORDER BY SUM(DepositAmount) DESC

--P08
  SELECT DepositGroup, 
	     MagicWandCreator,
		 MIN(DepositCharge) AS MinDepositeCharge
	FROM WizzardDeposits
GROUP BY DepositGroup,MagicWandCreator
ORDER BY MagicWandCreator,DepositGroup

--P09

SELECT CASE
	WHEN Age<=10 THEN '[0-10]'
	WHEN Age<=20 THEN '[11-20]'
	WHEN Age<=30 THEN '[21-30]'
	WHEN Age<=40 THEN '[31-40]'
	WHEN Age<=50 THEN '[41-50]'
	WHEN Age<=60 THEN '[51-60]'	
	ELSE '[61+]'
END AS AgeGroup,
COUNT(*) AS WizardCount
FROM WizzardDeposits
GROUP BY CASE
	WHEN Age<=10 THEN '[0-10]'
	WHEN Age<=20 THEN '[11-20]'
	WHEN Age<=30 THEN '[21-30]'
	WHEN Age<=40 THEN '[31-40]'
	WHEN Age<=50 THEN '[41-50]'
	WHEN Age<=60 THEN '[51-60]'	
	ELSE '[61+]'
END 

--P10
SELECT LEFT(FirstName,1) AS FirstLetter
FROM WizzardDeposits
WHERE DepositGroup='Troll Chest'
GROUP BY LEFT(FirstName,1)

--P11

  SELECT DepositGroup,
		 IsDepositExpired,
		 AVG(DepositInterest) AS AverageIntrest
	FROM WizzardDeposits
   WHERE DepositStartDate>'01/01/1985'
GROUP BY DepositGroup,
		 IsDepositExpired
ORDER BY DepositGroup DESC, IsDepositExpired

--P12 CANNOT SOLEV NOW

SELECT SUM(ResultTable.[Difference]) AS SumDifference
  FROM (SELECT DepositAmount - (SELECT DepositAmount 
								FROM WizzardDeposits 
								WHERE Id = WizDeposits.Id + 1) AS [Difference] 
		FROM WizzardDeposits AS WizDeposits) AS ResultTable

--Laboratory
--STEP 1
SELECT ID,
	   FirstName,
	   DepositAmount AS Host,	   
	   LEAD(DepositAmount,1) OVER(ORDER BY Id ASC ) AS Guest,
	   DepositAmount-LEAD(DepositAmount,1) OVER(ORDER BY Id ASC ) AS [Difference]
FROM WizzardDeposits

--FOR JUDGE

SELECT SUM([Difference]) as SumDifference
FROM 
(
	SELECT
	DepositAmount-LEAD(DepositAmount,1) OVER(ORDER BY Id ASC ) AS [Difference]
	FROM WizzardDeposits
) AS Diffs
