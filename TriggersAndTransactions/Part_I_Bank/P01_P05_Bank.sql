
--P01

CREATE TABLE Logs (
LogID INT IDENTITY PRIMARY KEY,
AccountID INT FOREIGN KEY REFERENCES Accounts(Id),
OldSum DECIMAL(15,2) NOT NULL,
NewSum DECIMAL(15,2) NOT NULL
)

GO
--TRIGGER Compile time error in Judge
CREATE TRIGGER tr_BalanceChange ON Accounts
FOR UPDATE,INSERT
AS
DECLARE @oldSum DECIMAL(15,2)
DECLARE @newSum DECIMAL(15,2)
DECLARE @accountId INT
	IF(UPDATE(Balance))
	BEGIN 
		IF((SELECT Balance FROM deleted) IS NULL)
			BEGIN
				SET @oldSum=0
			END
		ELSE
			BEGIN
				SET @oldSum = (SELECT Balance FROM deleted)
			END
		SET @newSum =(SELECT Balance FROM inserted)
		SET @accountId = (SELECT Id FROM inserted)

		INSERT INTO Logs VALUES
		(@accountId,@oldSum,@newSum)
	END;
	
--TESTS:
UPDATE Accounts
SET Balance = 200
WHERE Id=1

INSERT INTO Accounts VALUES
(21,5,200)

--P02

CREATE TABLE NotificationEmails (
EmailId INT IDENTITY PRIMARY KEY,
RecepientId INT FOREIGN KEY REFERENCES Accounts(Id),
Subject VARCHAR(100) NOT NULL,
Body VARCHAR(500) NOT NULL
)

GO
CREATE TRIGGER tr_CreateMail ON Logs
FOR INSERT
AS
BEGIN
	DECLARE @recepientId INT
	DECLARE @subject VARCHAR(100)
	DECLARE @body VARCHAR(500)
	IF (@@ROWCOUNT= 0)
		RETURN;
	SET @recepientId=(SELECT AccountID FROM inserted)
	SET @subject =CONCAT('Balance change for account: ',(SELECT AccountID FROM inserted))
	SET @body = CONCAT('On ',GETDATE(),' your balance was changed from ',(SELECT OldSum FROM inserted),' to ',(SELECT NewSum FROM inserted),'.')
	 
	INSERT INTO NotificationEmails(RecepientId,Subject,Body)
	 VALUES
	(@recepientId,@subject,@body)
END

GO
--P03
CREATE PROC usp_DepositMoney (@accountId INT, @moneyAmount DECIMAL(15,4))
AS
IF(@moneyAmount>=0)
BEGIN
	UPDATE Accounts
	SET Balance=Balance+@moneyAmount
	FROM Accounts
	WHERE Id=@accountId
END

GO
--P04
CREATE PROC usp_WithdrawMoney (@accountId INT, @moneyAmount DECIMAL(15,4))
AS
BEGIN
	IF(@moneyAmount)<=0
		RAISERROR('Invalid withdrow amount',16,1)
	DECLARE @currentAmount DECIMAL(15,4)
	SET @currentAmount = (SELECT Balance FROM Accounts WHERE Id=@accountId)
	IF(@currentAmount IS NULL)
		RAISERROR('Account Id is not correct',16,2)
	ELSE IF(@currentAmount<@moneyAmount)
		RAISERROR('Not enought money in this account',16,3)
	ELSE
	BEGIN
		UPDATE Accounts
		SET Balance = @currentAmount-@moneyAmount
		WHERE Id=@accountId
	END
END;

GO
--P05
CREATE PROC usp_TransferMoney(@senderId INT, @receiverId INT, @amount DECIMAL (15,4))
AS
BEGIN TRANSACTION
	EXEC usp_WithdrawMoney @senderId, @amount
	DECLARE @senderBalance DECIMAL(15,4) = (SELECT Balance FROM Accounts WHERE Id=@senderId)
	EXEC usp_DepositMoney @receiverId,@amount
	IF(@senderBalance<@amount)
		ROLLBACK
COMMIT TRANSACTION

GO
--Snippets for tests
EXEC usp_TransferMoney 1,2, 2200

SELECT*
FROM NotificationEmails
SELECT *
FROM Accounts
SELECT *
FROM Logs
USE Bank
EXEC usp_WithdrawMoney 5,5000