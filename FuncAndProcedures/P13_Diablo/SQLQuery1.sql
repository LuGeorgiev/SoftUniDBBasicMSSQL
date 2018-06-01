USE Diablo
GO
--P13
CREATE FUNCTION ufn_CashInUsersGames (@gameName NVARCHAR(20))
RETURNS TABLE
AS
RETURN
	SELECT SUM(Cash) AS SumCash
	FROM(
		   SELECT ROW_NUMBER() OVER(ORDER BY u.Cash DESC) AS Row,
				g.Name,
				u.Cash
			FROM UsersGames AS u
	   LEFT JOIN Games AS g
			  ON g.Id=u.GameId
		   WHERE g.Name=@gameName) AS Numbered
	WHERE Row % 2=1

GO
SELECT* FROM ufn_CashInUsersGames ('Love in a mist')
