CREATE DATABASE Cars
USE Cars


CREATE TABLE Manifacturers(
ManifacturerID INT PRIMARY KEY IDENTITY,
Name VARCHAR(30) UNIQUE NOT NULL,
EstablishedOn DATE
)
GO
INSERT INTO Manifacturers VALUES
('BMW','07/03/1916'),
('Tesla','01/01/2003'),
('Lada','01/05/1966')


CREATE TABLE Models(
ModelID INT PRIMARY KEY IDENTITY(101,1),
Name VARCHAR(30) NOT NULL,
ManifacturerID INT FOREIGN KEY REFERENCES Manifacturers(ManifacturerID)
)
GO
INSERT INTO Models VALUES
('X1',1),
('i6',1),
('MOdel S',2),
('Model X',2),
('Model 3',2),
('Nova',3)

SELECT *
FROM Models


USE master
DROP DATABASE Cars