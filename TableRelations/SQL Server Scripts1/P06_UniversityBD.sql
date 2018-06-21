CREATE DATABASE UniversityDB
COLLATE Cyrillic_General_100_CI_AI

USE UniversityDB

CREATE TABLE Subjects(
SubjectID INT,
SubjectName VARCHAR(30) NOT NULL,

CONSTRAINT PK_SubjectsId PRIMARY KEY (SubjectID)
)


CREATE TABLE Majors(
MajorID INT,
Name VARCHAR(30) NOT NULL,

CONSTRAINT PK_MajorId PRIMARY KEY (MajorID)
)


CREATE TABLE Students(
StudentId INT,
StudentNumber VARCHAR(12) NOT NULL,
StudentNAme VARCHAR(30) NOT NULL,
MajorID INT,

CONSTRAINT PK_Students PRIMARY KEY(StudentId),
CONSTRAINT FK_MajorId FOREIGN KEY (MajorID) REFERENCES Majors(MajorId)
)


CREATE TABLE Agenda(
StudentId INT,
SubjectId INT,

CONSTRAINT PK_StudentSubject PRIMARY KEY (StudentId, SubjectId),
CONSTRAINT FK_StudentId FOREIGN KEY(StudentId) REFERENCES Students(StudentId),
CONSTRAINT FK_SubjectId FOREIGN KEY(SubjectId) REFERENCES Subjects(SubjectId)
)


CREATE TABLE Payments(
PaymentId INT,
PaymentDate DATETIME NOT NULL,
PaymentAmount DECIMAL(15,2) NOT NULL,
StudentId INT,

CONSTRAINT PK_PaymentId PRIMARY KEY(PaymentId),
CONSTRAINT FK_StudentID_Payment FOREIGN KEY (StudentId) REFERENCES Students(StudentId)
)