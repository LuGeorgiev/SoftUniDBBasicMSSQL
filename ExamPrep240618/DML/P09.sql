
SELECT R.Id, R.Price, H.Name AS Hotel, C.Name AS City
FROM Rooms R
JOIN Hotels H ON R.HotelId=H.Id
JOIN Cities C ON H.CityId=C.Id
WHERE R.Type='First Class'
ORDER BY R.Price DESC, R.Id