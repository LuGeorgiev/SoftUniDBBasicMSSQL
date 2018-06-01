SELECT * 
FROM AccountHolders
SELECT *
FROM Accounts
GO

--P09
CREATE PROC usp_GetHoldersFullName 
AS
SELECT FirstName+' '+LastName AS [Full Name]
FROM AccountHolders

EXEC dbo.usp_GetHoldersFullName
GO

--P10
CREATE PROC usp_GetHoldersWithBalanceHigherThan (@totalSum DECIMAL(15,2))
AS
	SELECT FirstName,LastName 
	  FROM AccountHolders AS h
RIGHT JOIN Accounts AS a
	    ON a.AccountHolderId=h.Id
  GROUP BY FirstName,LastName
	HAVING SUM(Balance)>@totalSum

EXEC dbo.usp_GetHoldersWithBalanceHigherThan 15000
GO

--P11

CREATE OR ALTER FUNCTION ufn_CalculateFutureValue (@initialSum DECIMAL(15,4),@intrestYear FLOAT,@years INT)
RETURNS DECIMAL(15,4)
BEGIN
	DECLARE @futureValue DECIMAL(15,4)
	SET @futureValue=@initialSum*(POWER(1+@intrestYear,@years))
	RETURN @futureValue
END

GO
SELECT dbo.ufn_CalculateFutureValue (1000,0.1,5)
SELECT POWER(3, 2)
GO
--P12
CREATE PROC usp_CalculateFutureValueForAccount (@accountId INT,@intrestYear FLOAT)
AS
BEGIN
    SELECT a.Id AS [Account Id],
		  FirstName AS [First Name],
		  LastName AS [Last Name],
		  a.Balance AS [Current Balance],
		  dbo.ufn_CalculateFutureValue (a.Balance,@intrestYear,5) AS [Balance in 5 years]
	  FROM AccountHolders AS h
RIGHT JOIN Accounts AS a
	    ON a.AccountHolderId=h.Id
	 WHERE a.Id=@accountId
END

EXEC dbo.usp_CalculateFutureValueForAccount 3,0.5
	
