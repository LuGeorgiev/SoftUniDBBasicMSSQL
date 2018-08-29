--18

CREATE OR ALTER FUNCTION udf_GetPromotedProducts
(@CurrentDate DATE, @StartDate DATE, @EndDate DATE, @Discount INT, @FirstItemId INT, @SecondItemId INT, @ThirdItemId INT)
RETURNS VARCHAR(200)
BEGIN

	DECLARE @firstItemName NVARCHAR(50) = (SELECT Name
											FROM Items
											WHERE id=@FirstItemId)
	DECLARE @secondItemName NVARCHAR(50) = (SELECT Name
										FROM Items
										WHERE id=@SecondItemId)
	DECLARE @thirdItemName NVARCHAR(50) = (SELECT Name
										FROM Items
										WHERE id=@ThirdItemId)
	

	IF(@firstItemName IS NULL OR @secondItemName IS NULL OR @thirdItemName IS NULL)
		RETURN 'One of the items does not exists!'
	IF((@StartDate > @CurrentDate) OR (@CurrentDate > @EndDate))
		RETURN 'The current date is not within the promotion dates!'

	DECLARE @disc DECIMAL(15,2) = (100-CAST(@Discount AS decimal))/100

	DECLARE @firstItemPrice DECIMAL(15,2) = (SELECT Price
											FROM Items
											WHERE id=@FirstItemId)*@disc
		

	DECLARE @secondItemPrice DECIMAL(15,2) = (SELECT Price
										FROM Items
										WHERE id=@SecondItemId)*@disc
			

	DECLARE @thirdItemPrice DECIMAL(15,2) = (SELECT Price
										FROM Items
										WHERE id=@ThirdItemId)*@disc			

	RETURN CONCAT(@firstItemName, ' price: ',@firstItemPrice,' <-> ',@secondItemName,' price: ',@secondItemPrice,' <-> ',@thirdItemName,' price: ',@thirdItemPrice)
END


GO


SELECT dbo.udf_GetPromotedProducts('2018-08-02', '2018-08-01', '2018-08-03',13, 3,4,5)

GO

CREATE OR ALTER PROC usp_CancelOrder(@OrderId INT, @CancelDate DATE)
AS
BEGIN

	IF((SELECT Id FROM Orders WHERE Id=@OrderId) IS NULL)
		THROW 50013, 'The order does not exist!', 1

	IF(DATEDIFF(DAY,(SELECT [DateTime] FROM Orders WHERE Id=@OrderId),@CancelDate)>3)
		THROW 50013, 'You cannot cancel the order!', 1

		DELETE OrderItems
		WHERE OrderId=@OrderId

		DELETE Orders
		WHERE Id=@OrderId
END

GO
--20

CREATE TABLE DeletedOrders (
OrderId INT, 
ItemId INT, 
ItemQuantity INT
)
GO
 CREATE TRIGGER T_DeletedOrderItems
    ON OrderItems
    FOR DELETE
  AS
    BEGIN     
	 INSERT INTO DeletedOrders (OrderId,ItemId,ItemQuantity )  
	 (SELECT OrderId,ItemId,Quantity	 
	 FROM deleted )
	 --WHERE ItemId=(SELECT d.ItemId  FROM deleted AS d) 
	 --AND OrderId=(SELECT d.OrderId  FROM deleted AS d) )
    END

DELETE FROM OrderItems
WHERE OrderId = 5

DELETE FROM Orders
WHERE Id = 5 

	GO
	SELECT *
	FROM DeletedOrders