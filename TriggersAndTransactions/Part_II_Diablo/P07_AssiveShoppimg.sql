--P07
DECLARE @userId INT = (SELECT Id FROM Users WHERE Username ='Stamat') 
DECLARE @gameId INT = (SELECT Id FROM Games WHERE[Name]='Safflower')
DECLARE @userGameId INT = (SELECT Id FROM UsersGames WHERE UserId=@userId AND GameId=@gameId)
BEGIN TRY
BEGIN TRANSACTION
	UPDATE UsersGames
	SET Cash-=(SELECT SUM(Price) FROM Items WHERE MinLevel IN(11,12))
	WHERE Id=@userGameId

	DECLARE @userBalance DECIMAL(15,4)=(SELECT Cash FROM UsersGames WHERE Id=@userGameId) 
	IF (@userBalance<0)
	BEGIN
		ROLLBACK
		--RETURN
	END
	INSERT INTO UserGameItems
	SELECT Id , @userGameId FROM Items WHERE MinLevel IN (11,12)
COMMIT
END TRY
BEGIN CATCH
	ROLLBACK	
END CATCH

BEGIN TRY
BEGIN TRANSACTION
	UPDATE UsersGames
	SET Cash-=(SELECT SUM(Price) FROM Items WHERE MinLevel BETWEEN 19 AND 21)
	WHERE Id=@userGameId

	SET @userBalance =(SELECT Cash FROM UsersGames WHERE Id=@userGameId) 
	IF (@userBalance<0)
	BEGIN
		ROLLBACK
		RETURN
	END
	INSERT INTO UserGameItems
	SELECT Id,@userGameId FROM Items WHERE MinLevel BETWEEN 19 AND 21
COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH

SELECT i.Name AS [Item Name]
FROM Items AS i
JOIN UserGameItems AS u ON u.ItemId=i.Id
WHERE u.UserGameId=@userGameId
ORDER BY [Item Name]


