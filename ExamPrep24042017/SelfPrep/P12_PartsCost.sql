

SELECT ISNULL( SUM(p.Price*op.Quantity) ,0)AS [Parts Total]
FROM Orders AS o
JOIN OrderParts AS op ON op.OrderId=o.OrderId
JOIN Parts AS p ON p.PartId=op.PartId
WHERE DATEDIFF(DAY,IssueDate,'04-24-2017')<=21
