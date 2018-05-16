CREATE DATABASE CarRentalDB
COLLATE Cyrillic_General_100_CI_AI

USE CarRentalDB

CREATE TABLE Categories(
Id INT PRIMARY KEY IDENTITY,
CategoryName VARCHAR(50) NOT NULL,
DailyRate DECIMAL(6,2) NOT NULL,
WeeklyRate DECIMAL(7,2) NOT NULL,
MonthlyRate DECIMAL(8,2) NOT NULL,
WeekendRate DECIMAL(6,2)
)

INSERT INTO Categories(CategoryName,DailyRate,WeeklyRate,MonthlyRate,WeekendRate)
VALUES ('Van',20.3,110.4,400.0,55.50),
('Car',15.3,90.4,300.0,45.50),
('MorotCycle',10.3,60.4,200.89,35.50)

CREATE TABLE Cars(
Id INT PRIMARY KEY IDENTITY,
PlateNumber VARCHAR(16) UNIQUE NOT NULL,
Manifacturer NVARCHAR(20) NOT NULL,
Model VARCHAR(20) NOT NULL,
CarYear INT,
CategoryId INT FOREIGN KEY REFERENCES Categories(Id),
Doors CHAR(1) NOT NULL,
Picture VARBINARY(2000),
Condition VARCHAR(2000),
Available BIT
)


INSERT INTO Cars(PlateNumber,Manifacturer,Model,CarYear,Doors,Available)
VALUES('686989NMYUO','HONDA','Civic','1979',3,0),
('LJKHI6789','MAZDA','Z3','2009',5,1),
('KOJOU&*9','MERCEDES','C180','1988',4,1)

CREATE TABLE Employees(
Id INT PRIMARY KEY IDENTITY,
FirstName NVARCHAR(30) NOT NULL,
LastName NVARCHAR(30) NOT NULL,
Title NVARCHAR(100) NOT NULL,
Notes NVARCHAR(1000)
)

INSERT INTO Employees(FirstName,LastName,Title)
VALUES('Ivan','Ivanov','Driver'),
('Петко','Петков','Бензинджия'),
('Илия','Михов','Монтьор')

CREATE TABLE Customers(
Id INT PRIMARY KEY IDENTITY,
DrivingLicenseNumber INT NOT NULL,
FullName NVARCHAR(90) NOT NULL,
[Address] NVARCHAR(300) NOT NULL,
City NVARCHAR (20) NOT NULL,
ZIPCode VARCHAR(10) NOT NULL,
Notes NVARCHAR(1000)
)

INSERT INTO Customers(DrivingLicenseNumber,FullName,Address,City,ZIPCode)
VALUES(809809089,'Ivanov Petrov Fitipaldi','Zona B-5 123','Sofia','1234'),
(899087,'Сена Петков','През девет Планини','В Десета','67ИОП'),
(8977634,'Mhail Михов','Drujba 2','Plovdiv','7890')

CREATE TABLE RentalOrders(
Id INT PRIMARY KEY IDENTITY,
EmployeeId INT FOREIGN KEY REFERENCES Employees(Id),
CustometId INT FOREIGN KEY REFERENCES Customers(Id),
CarId INT FOREIGN KEY REFERENCES Cars(Id),
TankLevel INT NOT NULL,
KilometerageStart INT NOT NULL,
KilometerageEnd INT NOT NULL,
TotalKilometrage INT,
StartDate DATE NOT NULL,
EndDate DATE NOT NULL,
TotalDays INT,
RateApplied DECIMAL(8,2) NOT NULL,
TaxRate DECIMAL(4,2)NOT NULL,
OrdereStatus VARCHAR(15) NOT NULL,
Notes NVARCHAR(1000)
)

INSERT INTO RentalOrders(EmployeeId,CustometId,CarId,TankLevel,KilometerageStart,KilometerageEnd,TotalKilometrage,
StartDate,EndDate,TotalDays,RateApplied,TaxRate,OrdereStatus)
VALUES(1,1,1,20,120000,120001,1,'2018-2-22','2018-3-22',28,23.2,4.5,'Valid'),
(2,2,2,40,140000,140001,1,'2018-3-22','2018-4-22',30,23.2,4.5,'Valid'),
(3,3,3,60,160000,160001,1,'2018-1-22','2018-2-22',31,23.2,4.5,'Invalid')

SELECT * FROM Cars
SELECT * FROM RentalOrders