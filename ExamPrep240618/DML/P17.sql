SELECT		T.Id AS Id,
			CONCAT(A.FirstName,' '+ A.MiddleName,' ',A.LastName  ) AS [Full Name],
			CA.Name AS [From], 
			CH.Name AS [To],
				CASE
					WHEN t.CancelDate IS NOT NULL THEN 'Canceled'
					ELSE CONCAT(DATEDIFF(DAY,T.ArrivalDate, T.ReturnDate),' days')
				END AS Duration
FROM Trips T
JOIN AccountsTrips AT ON T.Id=AT.AccountId
JOIN Accounts A ON AT.AccountId=a.Id
JOIN Rooms R ON T.RoomId=R.Id
JOIN Hotels H ON R.HotelId=H.Id
JOIN Cities CH ON H.CityId=CH.Id
JOIN Cities CA ON A.CityId=Ca.Id
ORDER BY [Full Name], T.Id
--cannot find the difference but mine (first) is wrong
SELECT
  T.Id,
  CONCAT(A.FirstName, ' ' + A.MiddleName, ' ', A.LastName) AS [Full Name],
  AC.Name                                                  AS [From],
  HC.Name                                                  AS [To],
  CASE 
	  WHEN CancelDate IS NOT NULL   THEN 'Canceled'
	  ELSE CONCAT(DATEDIFF(DAY, T.ArrivalDate, T.ReturnDate), ' days')
  END                                                      AS Duration
FROM Trips T
  JOIN AccountsTrips AT on T.Id = AT.TripId
  JOIN Accounts A ON AT.AccountId = A.Id
  JOIN Rooms R ON T.RoomId = R.Id
  JOIN Hotels H on R.HotelId = H.Id
  JOIN Cities HC on H.CityId = HC.Id
  JOIN Cities AC on A.CityId = AC.Id
ORDER BY [Full Name], T.Id