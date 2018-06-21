CREATE DATABASE University
USE University

CREATE TABLE Students(
StudentID INT,
Name VARCHAR(50) NOT NULL,

CONSTRAINT PK_StudentID PRIMARY KEY (StudentID)
)

INSERT INTO Students VALUES
(1,'Mila'),
(2,'Toni'),
(3,'Ron')

CREATE TABLE Exams(
ExamID INT,
Name VARCHAR(50) NOT NULL,

CONSTRAINT PK_ExamID PRIMARY KEY (ExamID)
)

INSERT INTO Exams VALUES
(101,'SpringMVC'),
(102,'Neo4j'),
(103,'Oracle 11g')

CREATE TABLE StudentsExams(
StudentID INT,
ExamID INT,

CONSTRAINT PK_StudentExam 
PRIMARY KEY (StudentID,ExamID),
CONSTRAINT FK_StudentID 
FOREIGN KEY (StudentId) REFERENCES Students(StudentID),
CONSTRAINT FK_ExamID
FOREIGN KEY (ExamID) REFERENCES Exams(ExamID)
)

INSERT INTO StudentsExams VALUES
(1,101),
(1,102),
(2,101),
(3,103),
(2,102),
(2,103)

SELECT *
FROM StudentsExams

USE master
DROP DATABASE University