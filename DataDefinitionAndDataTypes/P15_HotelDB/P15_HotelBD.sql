CREATE DATABASE HotelDB
USE HotelDB


CREATE TABLE Empolyees(
Id INT ,
FirstName NVARCHAR(30) NOT NULL,
LastName NVARCHAR(30) NOT NULL,
Title VARCHAR (50) NOT NULL,
Notes VARCHAR (1000),

CONSTRAINT PK_Id PRIMARY KEY( Id)
)
GO
INSERT INTO Empolyees(Id,FirstName,LastName,Title,Notes)
VALUES
(1,'Ivan','Petrov','Waiter','asd'),
(2,'Pavlin','Nikolov','Piccolo','asd'),
(5,'Marin','Drumev','Receptionist','asd')


CREATE TABLE Customers(
AccountNumber INT PRIMARY KEY,
FirstName NVARCHAR(30) NOT NULL,
LastName NVARCHAR(30) NOT NULL,
PhoneNumber VARCHAR(15) NOT NULL,
EmergencyName NVARCHAR(50) NOT NULL,
EmergencyNumber VARCHAR(15) NOT NULL,
Notes VARCHAR(1000)
)


INSERT INTO Customers(AccountNumber,FirstName, LastName,PhoneNumber,EmergencyName,EmergencyNumber, Notes)
VALUES
(1,'Ivan','Ivanov','+35129..','MilkaIva','+1000jk','asd'),
(2,'Мария','Манова','+35239..','Илия','+1000jk','asd'),
(3,'Иванка','Ивова','+3532119..','Мария','+1000jk','asd')

CREATE TABLE RoomStatus(
RoomStatus VARCHAR(15) NOT NULL,
Notes VARCHAR(1000)

CONSTRAINT PK_RoomStat PRIMARY KEY(RoomStatus) 
)

INSERT INTO RoomStatus(RoomStatus,Notes)
VALUES
('Available','asd'),
('NotAvailable','asd'),
('InReconstruct', 'asd')


CREATE TABLE RoomTypes(
RoomType VARCHAR(15) NOT NULL,
Notes VARCHAR(1000)

CONSTRAINT PK_RoomType PRIMARY KEY(RoomType) 
)

INSERT INTO RoomTypes(RoomType,Notes)
VALUES
('Single','asd'),
('Double','asd'),
('Apartment', 'asd')

CREATE TABLE BedTypes(
BedType VARCHAR(15) NOT NULL,
Notes VARCHAR(1000)

CONSTRAINT PK_Bedype PRIMARY KEY(BedType) 
)

INSERT INTO BedTypes(BedType,Notes)
VALUES
('Single','asd'),
('Double','asd'),
('Large', 'asd')

CREATE TABLE Rooms(
RoomNumber INT PRIMARY KEY IDENTITY,
RoomType VARCHAR(15) FOREIGN KEY REFERENCES RoomTypes(RoomType),
BedType VARCHAR(15) FOREIGN KEY REFERENCES BedTypes(BedType),
Rate DECIMAL(10,2) NOT NULL,
RoomStatus VARCHAR(15) FOREIGN KEY REFERENCES RoomStatus(RoomStatus),
Notes VARCHAR(1000)
)

INSERT INTO Rooms(RoomType,BedType,Rate,RoomStatus,Notes)
VALUES
('Single','Double',63.34,'Available','asd'),
('Double','Single',33.34,'NotAvailable','asd'),
('Single','Double',23.34,'Available','asd')

CREATE TABLE Payments(
Id INT PRIMARY KEY IDENTITY(1,1),
EmployeeId INT FOREIGN KEY REFERENCES Empolyees(Id),
PaymentDate DATE DEFAULT GETDATE(),
AccountNumber INT FOREIGN KEY REFERENCES Customers(AccountNumber),
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
(1,'2018-3-30',1,'2018-4-13','2018-4-15',2, 340.34,2.5,20.2,360,'asd'),
(2,'2018-3-30',2,'2018-1-13','2018-2-15',32, 340.34,2.5,20.2,360,'asd'),
(5,'2018-3-30',3,'2018-1-13','2018-2-15',30, 340.34,2.5,20.2,360,'asd')

CREATE TABLE Occupancies(
Id INT PRIMARY KEY IDENTITY,
EmployeeId INT FOREIGN KEY REFERENCES Empolyees(Id),
DateOccupied DATE NOT NULL,
AccountNumber INT FOREIGN KEY REFERENCES Customers(AccountNumber),
RoomNumber INT FOREIGN KEY REFERENCES Rooms(RoomNumber),
RateApplied DECIMAL(15,2) NOT NULL,
PhoneCharge DECIMAL(15,2) NOT NULL,
Notes VARCHAR(1000)
)

INSERT INTO Occupancies
VALUES
(1,'2018-4-13', 2, 2, 23.34,  23.45,'asd'),
(2,'2018-1-13', 2, 2, 23.34,  23.45,'asd'),
(5,'2018-2-13', 2, 2, 23.34,  23.45,'asd')
