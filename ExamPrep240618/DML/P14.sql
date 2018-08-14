SELECT	at.TripId AS Id, 
		h.Name AS HotelName, 
		r.Type AS RoomType, 
		CASE
			WHEN t.CancelDate IS NULL THEN SUM(h.BaseRate+r.Price)
			ELSE 0
		END AS [Revenue]
FROM Trips AS t
JOIN Rooms AS r ON r.Id=t.RoomId
JOIN Hotels AS h ON h.Id=r.HotelId
JOIN AccountsTrips AS at ON  at.TripId=t.Id 
GROUP BY at.TripId, h.Name, r.Type, t.CancelDate
ORDER BY RoomType, at.TripId

