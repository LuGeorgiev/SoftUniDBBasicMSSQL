
use WMS

SELECT TOP(1) m.Name,
		COUNT(*) AS [Times Serviced],
		(SELECT ISNULL(Sum(p.Price*op.Quantity),0)
			FROM Jobs AS j
			JOIN Orders AS o ON o.JobId=j.JobId
			JOIN OrderParts AS op ON op.OrderId=o.OrderId
			JOIN Parts AS p ON p.PartId=op.PartId
			WHERE j.ModelId =m.ModelId) AS [Parts Total]
 FROM Jobs AS j
 JOIN Models AS m ON m.ModelId=j.ModelId
GROUP BY m.Name, m.ModelId
ORDER BY [Times Serviced] DESC



----Sub Query


SELECT ISNULL(Sum(p.Price*op.Quantity),0)
FROM Jobs AS j
JOIN Orders AS o ON o.JobId=j.JobId
JOIN OrderParts AS op ON op.OrderId=o.OrderId
JOIN Parts AS p ON p.PartId=op.PartId
WHERE j.ModelId =2