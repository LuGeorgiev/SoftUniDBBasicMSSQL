CREATE DATABASE MoviesDB
COLLATE Cyrillic_General_100_CI_AI

USE MoviesDB

CREATE TABLE Directors(
Id INT PRIMARY KEY IDENTITY,
DirectorName NVARCHAR(100) NOT NULL,
Notes VARCHAR(MAX)
)

INSERT INTO Directors(DirectorName)
VALUES ('Ivan Ivanov'),
('Petkan Petkanov'),
('Zlatan Zlatanov'),
('Маргарит Карамфилов'),
('Златка Сребрева')

CREATE TABLE Ganres(
Id INT PRIMARY KEY IDENTITY,
GanreName VARCHAR(50) NOT NULL,
Notes VARCHAR(MAX)
)

INSERT INTO Ganres(GanreName)
VALUES ('Drama'),
('Comedy'),
('Action'),
('Турска Сапунка'),
('Германска Комедия')

CREATE TABLE Categories(
Id INT PRIMARY KEY IDENTITY,
CategoryName VARCHAR(50) NOT NULL,
Notes VARCHAR(MAX)
)

INSERT INTO Categories(CategoryName)
VALUES ('Series'),
('Trailer'),
('Movie'),
('China Production'),
('Europe Production')

CREATE TABLE Movies(
Id INT PRIMARY KEY IDENTITY,
Title NVARCHAR(50) NOT NULL,
DirectorId INT FOREIGN KEY REFERENCES Directors(Id) NOT NULL,
CopyRightYear INT NOT NULL,
[Length] DECIMAL(3,2) NOT NULL,
GanreId INT FOREIGN KEY REFERENCES Ganres(Id) NOT NULL,
CategoryId INT FOREIGN KEY REFERENCES Categories(Id) NOT NULL,
Rating DECIMAL(4,2) NOT NULL,
Notes VARCHAR(MAX)
)

INSERT INTO Movies(Title,DirectorId,CopyRightYear,Length,GanreId,CategoryId,Rating)
VALUES ('Instructions Not Included',1,1789,2.34,3,4,90.3),
('Game of Thrones',2,1689,2.4,2,1,70.3),
('Gladiator',3,1989,3.34,2,3,60.3),
('Monje',5,1769,0.34,4,5,40.3),
('Оркестър без име',4,2009,1.34,3,2,50.3)

SELECT * FROM Movies