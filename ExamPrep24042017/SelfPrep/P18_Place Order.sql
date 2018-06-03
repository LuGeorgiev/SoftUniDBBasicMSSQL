CREATE PROC usp_PlaceOrder(@jobId INT, @serialNumber VARCHAR(50), @quantity INT)
AS
BEGIN
	IF((SELECT Status FROM Jobs WHERE JobId=@jobId)IS NULL)
		BEGIN
			RAISERROR('Job not found!',16,1)
			RETURN
		END
		IF (@quantity<=0)
		BEGIN
			RAISERROR('Part quantity must be more than zero!',16,1)
			RETURN
		END
	IF((SELECT Status FROM Jobs WHERE JobId=@jobId)='Finished')
		BEGIN
			RAISERROR('This job is not active!',16,1)
			RETURN
		END
	IF((SELECT SerialNumber FROM Parts WHERE SerialNumber=@serialNumber)IS NULL)
		BEGIN
			RAISERROR('Part not found!',16,1)
			RETURN
		END
	

	BEGIN TRANSACTION
		DECLARE @orderId INT
		SET @orderId= (SELECT o.OrderId FROM Orders AS o
						JOIN OrderParts AS op ON op.OrderId = o.OrderId
						JOIN Parts AS p ON p.PartId=op.PartId
						 WHERE o.JobId=@jobId AND p.SerialNumber=@serialNumber AND IssueDate IS NULL)

		DECLARE @partId INT = (SELECT p.PartId 						
								FROM Parts AS p 
							    WHERE p.SerialNumber=@serialNumber)
		IF(@orderId IS NULL)
		--Create Order
		BEGIN
			INSERT INTO Orders(JobId,IssueDate) VALUES
			(@jobId,NULL)
			INSERT INTO OrderParts(OrderId,PartId,Quantity)VALUES
			(IDENT_CURRENT('Orders'),@partId,@quantity)
		END
		ELSE
		BEGIN
			DECLARE @partExistsInOrder INT = (SELECT @@ROWCOUNT FROM OrderParts
											WHERE OrderId=@orderId AND PartId=@partId)
			IF (@partExistsInOrder IS NULL)
			BEGIN
			--Order exist, but part do not exists
				INSERT INTO OrderParts(OrderId,PartId,Quantity) VALUES
				(@orderId,@partId,@quantity);
			END
			ELSE
			-- BOTH EXISTS
			BEGIN
				UPDATE OrderParts
				SET Quantity+=@quantity
				WHERE OrderId=@orderId AND PartId=@partId
			END
		END
	IF(@@ROWCOUNT<>1)
	ROLLBACK
	ELSE
	COMMIT
END;



