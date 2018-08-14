CREATE TABLE Cities( 
Id INT	PRIMARY KEY IDENTITY,
Name	NVARCHAR(20) NOT NULL,
CountryCode CHAR(2) NOT NULL
)

CREATE TABLE Hotels(
Id		INT PRIMARY KEY IDENTITY,
Name	NVARCHAR(30) NOT NULL,
CityId	INT  NOT NULL,
EmployeeCount INT NOT NULL,
BaseRate	DECIMAL (15,2),
CONSTRAINT FK_Hotel_City FOREIGN KEY (CityId) REFERENCES Cities(Id)
)

CREATE TABLE Rooms(
Id		INT PRIMARY KEY IDENTITY,
Price	DECIMAL (15,2)  NOT NULL,
Type	NVARCHAR(20) NOT NULL,
Beds	INT NOT NULL,
HotelId INT NOT NULL,
CONSTRAINT FK_Room_Hotel FOREIGN KEY (HotelId) REFERENCES Hotels(Id)
)

CREATE TABLE Trips(
Id INT PRIMARY KEY IDENTITY,
RoomId INT NOT NULL ,
BookDate DATE NOT NULL ,
ArrivalDate Date NOT NULL,
ReturnDate Date NOT NULL, 
CancelDate Date ,
CONSTRAINT FK_Trip_Room FOREIGN KEY (RoomId) REFERENCES Rooms(Id),
CONSTRAINT CK_BookDate_ArrivalDate CHECK(BookDate<ArrivalDate),
CONSTRAINT CK_ArrivalDate_ReturnDate CHECK(ArrivalDate<ReturnDate),
)

CREATE TABLE Accounts(
Id INT PRIMARY KEY IDENTITY,
FirstName NVARCHAR(50) NOT NULL,
MiddleName  NVARCHAR(20),
LastName NVARCHAR(50) NOT NULL,
CityId INT NOT NULL ,
BirthDate Date NOT NULL,
Email VARCHAR(100) NOT NULL,
CONSTRAINT FK_Account_City FOREIGN KEY (CityId) REFERENCES Cities(Id),
CONSTRAINT UQ_Email UNIQUE (Email)
)

CREATE TABLE AccountsTrips(
AccountId INT NOT NULL,
TripId INT NOT NULL,
Luggage INT NOT NULL ,
CONSTRAINT PK_AccountTrip PRIMARY KEY(AccountId, TripId),
CONSTRAINT FK_AccountTrip_Account FOREIGN KEY (AccountId) REFERENCES Accounts(Id),
CONSTRAINT FK_AccountTrip_Trip FOREIGN KEY (TripId) REFERENCES Trips(Id),
CONSTRAINT CK_Luggage CHECK(Luggage>=0)
)