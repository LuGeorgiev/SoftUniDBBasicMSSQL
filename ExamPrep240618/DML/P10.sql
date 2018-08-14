
	SELECT A.Id AS AccountId, A.FirstName+' '+A.LastName AS Fullname, 
	MAX(DATEDIFF(DAY, T.ArrivalDate, T.ReturnDate)) AS [LongestTrip],
	MIN(DATEDIFF(DAY, T.ArrivalDate, T.ReturnDate)) AS [ShortestTrip]
	FROM Trips T JOIN AccountsTrips AC
	ON t.Id=Ac.TripId
	JOIN Accounts A
	ON AC.AccountId=A.Id
	WHERE A.MiddleName IS NULL AND T.CancelDate IS NULL
	GROUP BY A.Id, A.FirstName+' '+A.LastName
	Order BY [LongestTrip] DESC, A.Id
