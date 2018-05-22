CREATE DATABASE PersonsPasport

USE PersonsPasport

CREATE TABLE Persons(
PersonID INT,
FirstName NVARCHAR(50),
Salary DECIMAL (15,2),
PassportId INT UNIQUE,

CONSTRAINT PK_PersonID PRIMARY KEY (PersonID),
CONSTRAINT FK_PassportID FOREIGN KEY(PassportID)  REFERENCES Passports(PassportID)
)

CREATE TABLE Passports(
PassportID INT,
PassportNumber VARCHAR(10),

CONSTRAINT PK_PassportID PRIMARY KEY(PassportID),
CONSTRAINT UQ_PassportNumber UNIQUE(PassportNumber)
)

INSERT INTO Passports VALUES
(101,'N34FG21B'),
(102,'K65LO4R7'),
(103,'ZE657QP2')

INSERT INTO Persons VALUES
(1,'Roberto',43300.00,102),
(2,'Tom',56100.00,103),
(3,'Yana',60200.00,101)


