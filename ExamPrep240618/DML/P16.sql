

SELECT	TripId, SUM(at.Luggage) AS Luggage,
		'$' + CONVERT(VARCHAR(10), SUM(Luggage)*
									CASE WHEN SUM(Luggage)>5 
										THEN 5
										ELSE 0			
									END ) AS Fee
FROM Trips AS t
JOIN AccountsTrips AS at ON at.TripId=t.Id
GROUP BY TripId
HAVING SUM(Luggage)>0
ORDER BY Luggage DESC

