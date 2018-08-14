
SELECT AccountId,Email, CountryCode, Trips
FROM(
SELECT	a.Id AS AccountId, 
		a.Email,
		c.CountryCode, 
		COUNT(*) AS Trips,
		DENSE_RANK() OVER(PARTITION BY c.CountryCode ORDER BY COUNT(*) DESC, a.Id ) As [Rank]
FROM AccountsTrips AS ac
JOIN Accounts AS a ON a.Id=ac.AccountId
JOIN Trips AS t ON t.Id=ac.TripId
JOIN Rooms AS r ON r.Id=t.RoomId
JOIN Hotels AS h ON h.Id=r.HotelId
JOIN Cities AS c ON c.Id=h.CityId
GROUP BY a.Id, a.Email,c.CountryCode
) As e
WHERE Rank=1
ORDER BY Trips DESC, AccountId

