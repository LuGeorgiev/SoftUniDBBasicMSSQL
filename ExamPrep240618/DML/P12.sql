
 
SELECT a.Id, a.Email, c.Name as City, Count(a.Id) AS Trips
FROM AccountsTrips AS ac
JOIN Accounts AS a ON a.Id=ac.AccountId
JOIN Cities AS c ON c.Id=a.CityId
JOIN Trips AS t ON t.Id=ac.TripId
JOIN Rooms AS r ON r.Id=t.RoomId
JOIN Hotels AS h ON h.Id=r.HotelId
JOIN Cities AS cy ON cy.Id=h.CityId
Where c.Id=cy.Id
GROUP BY a.Id, a.Email, c.Name
ORDER BY Count(a.Id) DESC, a.Id