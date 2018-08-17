
CREATE TRIGGER on_ClosedDAteEnter ON Reports
AFTER UPDATE
AS
	IF( (SELECT CloseDate FROM deleted)IS NULL)
	 IF( (SELECT CloseDate FROM inserted) IS NOT NULL)
	 BEGIN
		 UPDATE Reports
		 SET StatusId = 3
		 WHERE Id = (SELECT Id FROM inserted)
	 END


UPDATE Reports
SET CloseDate = GETDATE()
WHERE EmployeeId = 5;

