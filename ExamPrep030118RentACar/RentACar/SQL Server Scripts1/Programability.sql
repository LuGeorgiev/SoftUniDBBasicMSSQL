CREATE OR ALTER FUNCTION udf_CheckForVehicle(@townName NVARCHAR(50), @seatsNumber INT)
RETURNS VARCHAR(50)
BEGIN
	DECLARE @result NVARCHAR(50)

	SET @result =(
		SELECT TOP (1) CONCAT(o.Name,' - ',m.Model)
		FROM Vehicles AS v
		JOIN Models As m ON m.Id=v.ModelId
		JOIN Offices As o ON o.Id=v.OfficeId
		JOIN Towns As t ON t.Id=o.TownId
		WHERE t.Name=@townName AND m.Seats=@seatsNumber
		ORDER BY o.Name)
	IF(@result IS NULL)
		RETURN 'NO SUCH VEHICLE FOUND'
	
		RETURN @result
END

GO

CREATE PROC usp_MoveVehicle(@vehicleId INT, @officeId INT) 
AS
BEGIN
	DECLARE @carsInOffice INT 
	SET @carsInOffice=(
		SELECT Count(v.Id)
		FROM Vehicles AS v
		JOIN Offices AS o ON o.Id=v.OfficeId
		WHERE o.Id=@officeId)
	
	DECLARE @parkPlaces INT
	SET @parkPlaces = (
		SELECT ParkingPlaces
		FROM Offices
		WHERE Id=@officeId)

	IF(@carsInOffice>=@parkPlaces)
		THROW 50013, 'Not enough room in this office!', 1
	ELSE
	BEGIN
		UPDATE Vehicles
		SET OfficeId=@officeId
		WHERE Id= @vehicleId
	END
END

GO

CREATE TRIGGER on_TotalMillageUpdate ON Orders
AFTER UPDATE
AS
	IF((SELECT TotalMileage FROM inserted) IS NOT NULL)
		BEGIN
			UPDATE Vehicles
			SET Mileage+=(SELECT TotalMileage FROM inserted)
			WHERE Id=(SELECT VehicleId FROM inserted)
		END

