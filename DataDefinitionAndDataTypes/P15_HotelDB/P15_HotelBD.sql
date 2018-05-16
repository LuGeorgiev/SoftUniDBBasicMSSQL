USE HotelDB

CREATE TABLE Empolyees(
Id INT NOT NULL,
FirstNme NVARCHAR(30) NOT NULL,
LastNAme NVARCHAR(30) NOT NULL,
Title VARCHAR (50) NOT NULL,
Notes VARCHAR (1000),

CONSTRAINT PK_Id PRIMARY KEY( Id)
)
GO
INSERT INTO Empolyees
VALUES
(1,'Ivan','Petrov','Waiter',NULL),
(2,'Pavlin','Nikolov','Piccolo',NULL),
(5,'Marin','Drumev','Receptionist',NULL)


CREATE TABLE Customers(
AccountNumber BIGINT PRIMARY KEY,
FirstName NVARCHAR(30) NOT NULL,
LastName NVARCHAR(30) NOT NULL,
PhoneNumber VARCHAR(15) NOT NULL,
EmergencyName NVARCHAR(50) NOT NULL,
EmergencyNumber VARCHAR(15) NOT NULL,
Notes VARCHAR(1000)
)


INSERT INTO Customers
VALUES
(1,'Ivan','Ivanov','+35129..','MilkaIva','+1000jk',NULL),
(2,'Мария','Манова','+35239..','Илия','+1000jk',NULL),
(3,'Иванка','Ивова','+3532119..','Мария','+1000jk',NULL)

CREATE TABLE RoomStatus(
RoomStatus VARCHAR(15) NOT NULL,
Notes VARCHAR(1000)

CONSTRAINT Un_RoomStat UNIQUE(RoomStatus) 
)

INSERT INTO RoomStatus
VALUES
('Available',NULL),
('NotAvailable',NULL),
('InReconstruct', NULL)
GO
SELECT* FROM RoomStatus

CREATE TABLE RoomTypes(
RoomTypes VARCHAR(15) NOT NULL,
Notes VARCHAR(1000)

CONSTRAINT Un_RoomType UNIQUE(RoomTypes) 
)
GO
INSERT INTO RoomTypes
VALUES
('Single',NULL),
('Double',NULL),
('Apartment', NULL)
GO
SELECT* FROM RoomTypes


CREATE TABLE BedTypes(
BedTypes VARCHAR(15) NOT NULL,
Notes VARCHAR(1000)

CONSTRAINT Un_Bedype UNIQUE(BedTypes) 
)
GO
INSERT INTO BedTypes
VALUES
('Single',NULL),
('Double',NULL),
('Large', NULL)
GO
SELECT* FROM BedTypes


CREATE TABLE Rooms(
RoomNumber INT PRIMARY KEY IDENTITY(1,1),
RoomType VARCHAR(15) FOREIGN KEY REFERENCES RoomTypes(RoomTypes),
BedType VARCHAR(15) FOREIGN KEY REFERENCES BedTypes(BedTypes),
Rate DECIMAL(10,2) NOT NULL,
RoomStatus VARCHAR(15) FOREIGN KEY REFERENCES RoomStatus(RoomStatus),
Notes VARCHAR(1000)
)
GO
INSERT INTO Rooms
VALUES
('Single','Double',63.34,'Available',NULL),
('Double','Single',33.34,'NotAvailable',NULL),
('Single','Double',23.34,'Available',NULL)

SELECT *FROM Rooms

CREATE TABLE Payments(
Id INT PRIMARY KEY IDENTITY(1,1),
EmployeeId INT FOREIGN KEY REFERENCES Empolyees(Id),
PaymentDate DATE DEFAULT GETDATE(),
AccountNumber BIGINT FOREIGN KEY REFERENCES Customers(AccountNumber),
FirstDateOccupied DATE NOT NULL,
LastDateOccupied DATE NOT NULL,
TotalDays INT NOT NULL,
AmmountCharged DECIMAL(15,2) NOT NULL,
TaxRate DECIMAL(5,2) NOT NULL,
TaxAmmount DECIMAL(15,2) NOT NULL,
PaymentTotal DECIMAL(15,2) NOT NULL,
Notes VARCHAR(1000)
)

INSERT INTO Payments
VALUES
(1,'2018-3-30',1,'2018-4-13','2018-4-15',2, 340.34,2.5,20.2,360,NULL),
(2,'2018-3-30',2,'2018-1-13','2018-2-15',32, 340.34,2.5,20.2,360,NULL),
(5,'2018-3-30',3,'2018-1-13','2018-2-15',30, 340.34,2.5,20.2,360,NULL)

CREATE TABLE Occupancies(
Id INT PRIMARY KEY IDENTITY(1,1),
EmployeeId INT FOREIGN KEY REFERENCES Empolyees(Id),
DateOccupied DATE NOT NULL,
AccountNumber BIGINT FOREIGN KEY REFERENCES Customers(AccountNumber),
RoomNumber INT FOREIGN KEY REFERENCES Rooms(RoomNumber),
RateApplied DECIMAL(15,2) NOT NULL,
PhoneCharge DECIMAL(15,2) NOT NULL,
Notes VARCHAR(1000)
)

INSERT INTO Occupancies
VALUES
(1,'2018-4-13', 2, 2, 23.34,  23.45,NULL),
(2,'2018-1-13', 2, 2, 23.34,  23.45,NULL),
(5,'2018-2-13', 2, 2, 23.34,  23.45,NULL)