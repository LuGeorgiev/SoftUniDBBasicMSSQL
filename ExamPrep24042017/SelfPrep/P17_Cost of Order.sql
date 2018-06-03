
CREATE FUNCTION udf_GetCost (@jobId INT)
RETURNS DECIMAL(6,2)
BEGIN
	DECLARE @sumOfOrderedParts DECIMAL(6,2)	
	SET @sumOfOrderedParts = (SELECT SUM(p.Price*op.Quantity)
							  FROM Orders AS o
							  JOIN OrderParts AS op ON op.OrderId=o.OrderId
							  JOIN Parts AS p ON p.PartId=op.PartId
							  WHERE o.JobId=@jobId)
	RETURN ISNULL(@sumOfOrderedParts,0)
END
