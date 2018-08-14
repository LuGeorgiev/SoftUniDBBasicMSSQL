CREATE PROCEDURE usp_SwitchRoom (@TripId INT, @TargetRoomId INT)
AS
BEGIN 
	DECLARE @currentHotel INT
	SET @currentHotel = (SELECT h.Id 
						FROM Hotels H 
						JOIN Rooms R ON R.HotelId=H.Id
						JOIN Trips T ON T.RoomId=R.Id
						WHERE t.Id=@TripId);
	DECLARE @tratgetHotel INT;
	SET @tratgetHotel = (SELECT h.Id 
						FROM Hotels H 
						JOIN Rooms R ON R.HotelId=H.Id
						WHERE r.Id=@TargetRoomId)
	IF(@currentHotel<>@tratgetHotel)
		THROW 50013, 'Target room is in another hotel!', 1
			
	DECLARE @accountInTrip INT
	SET @accountInTrip = (SELECT COUNT(*)
                           FROM AccountsTrips
                           WHERE TripId = @TripId)
	DECLARE @targetRoomBeds INT
	SET @targetRoomBeds = (SELECT r.Beds
							FROM Rooms r
							WHERE r.Id=@TargetRoomId)
	IF(@targetRoomBeds<@accountInTrip)
		THROW 50013, 'Not enough beds in target room!', 1

		UPDATE Trips
		SET RoomId=@targetRoomBeds
		WHERE Id=@TripId	
END;



EXEC usp_SwitchRoom 10, 8
SELECT RoomId FROM Trips WHERE Id = 10