CREATE DATABASE MoviesDB
COLLATE Cyrillic_General_100_CI_AI
Go
USE MoviesDB
GO


CREATE TABLE Directors(
Id INT PRIMARY KEY ,
DirectorName VARCHAR(50) NOT NULL,
Notes VARCHAR(100)
)

INSERT INTO Directors(Id,DirectorName, Notes)
VALUES (1,'Ivan Ivanov','sdf'),
(2,'Petkan Petkanov','sdf'),
(3,'Zlatan Zlatanov','sdf'),
(4, 'Zlatan Zlatanov','sdf'),
(5,'Zlatan Zlatanov','sdf')

CREATE TABLE Ganres(
Id INT PRIMARY KEY ,
GanreName VARCHAR(50) NOT NULL,
Notes VARCHAR(100)
)

INSERT INTO Ganres(Id, GanreName,Notes)
VALUES (1,'Drama','sdf'),
(2,'Comedy','sdf'),
(3,'Action','sdf'),
(4,'Mega Action','sdf'),
(5,'Giga Action','sdf')

CREATE TABLE Categories(
Id INT PRIMARY KEY ,
CategoryName VARCHAR(50) NOT NULL,
Notes VARCHAR(100)
)

INSERT INTO Categories(Id,CategoryName,Notes)
VALUES (1,'Series','sdf'),
(2,'Trailer','sdf'),
(3,'Movie','sdf'),
(4,'China Production','sdf'),
(5,'Europe Production','sdf')

CREATE TABLE Movies(
Id INT PRIMARY KEY ,
Title VARCHAR(50) NOT NULL,
DirectorId INT FOREIGN KEY REFERENCES Directors(Id) NOT NULL,
CopyRightYear INT NOT NULL,
[Length] DECIMAL(3,2) NOT NULL,
GanreId INT FOREIGN KEY REFERENCES Ganres(Id) NOT NULL,
CategoryId INT FOREIGN KEY REFERENCES Categories(Id) NOT NULL,
Rating DECIMAL(4,2) NOT NULL,
Notes VARCHAR(100)
)

INSERT INTO Movies(Id, Title,DirectorId,CopyRightYear,Length,GanreId,CategoryId,Rating,Notes)
VALUES 
(1,'Instructions Not Included',1,1789,2.34,3,4,90.3,'sdf'),
(2,'Game of Thrones',2,1689,2.4,2,1,70.3,'sdf'),
(3,'Gladiator',3,1989,3.34,2,3,60.3,'sdf'),
(4,'Monje',5,1769,0.34,4,5,40.3,'sdf'),
(5,'No name',4,2009,1.34,3,2,50.3,'sdf')

SELECT * FROM Movies