
SELECT c.Name as City, COUNT(h.Id) AS Hotels
FROM Cities As c
LEFT JOIN Hotels AS h
ON c.Id=h.CityId
GROUP BY c.Id, c.Name
ORDER BY Hotels DESC , City

SELECT C.Name AS City, COUNT(H.Id) AS Hotels FROM Cities C
LEFT JOIN Hotels H on C.Id = H.CityId
GROUP BY C.Id, c.Name
ORDER BY Hotels DESC, C.Name