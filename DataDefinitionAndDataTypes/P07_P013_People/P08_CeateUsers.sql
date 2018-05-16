CREATE TABLE Users(
Id INT PRIMARY KEY IDENTITY,
Username VARCHAR(30) NOT NULL,
[Password] VARCHAR(26)NOT NULL,
ProgilePicture VARBINARY(900),
LastLogTime DATETIME2,
IsDeleter BIT
)

INSERT INTO Users(Username,Password,IsDeleter)
VALUES('Kuciq','IvanCho123',1),
('Krasivata','fURIA123',0),
('Lud_S_Kartechnica','123123',1),
('Ivancoco','marincho',1),
('MilliM','milko324',1);

INSERT INTO Users(Username,Password,IsDeleter,ID)
VALUES('mishko','34567',1,6),
('MILENCO','milllen32',0,7)

SELECT * FROM Users
USE People
