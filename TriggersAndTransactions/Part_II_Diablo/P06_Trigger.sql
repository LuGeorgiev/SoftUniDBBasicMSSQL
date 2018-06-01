--P06

CREATE TRIGGER tr_ItemLevelLimitation ON UserGameItems
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @userLevel INT =(SELECT Level 
						   FROM UsersGames 
						  WHERE Id = (SELECT UserGameId 
										FROM inserted))
	DECLARE @itemMinLevel INT =(SELECT MinLevel 
							   FROM Items
							  WHERE Id=(SELECT ItemId
							   FROM inserted))
	IF(@userLevel<@itemMInLevel)
		RAISERROR('My Lord you need to increase level for this item',16,1)
	ELSE
	BEGIN
		INSERT INTO UserGameItems VALUES
		((SELECT ItemId FROM inserted),(SELECT UserGameId FROM  inserted))
	END	
END

-- NOT finished

GO
SELECT *
FROM UserGameItems

SELECT *
FROM Items

SELECT *
FROM UsersGames
WHERE GameId=207