

SELECT  p.PartId, 
		p.Description,
		SUM(pn.Quantity) AS Required,
		SUM(p.StockQty) AS [In Stock],
		SUM(ISNULL(op.Quantity,0)) AS Ordered
FROM PartsNeeded As pn
LEFT JOIN Jobs AS j ON j.JobId=pn.JobId
LEFT JOIN Parts AS p ON p.PartId=pn.PartId
LEFT JOIN Orders AS o ON o.JobId=j.JobId
LEFT JOIN OrderParts AS op ON op.OrderId=o.OrderId
WHERE j.Status<>'Finished'
GROUP BY p.PartId,p.Description
HAVING SUM(p.StockQty)+SUM(ISNULL(op.Quantity,0))<SUM(pn.Quantity)
ORDER BY p.PartId

