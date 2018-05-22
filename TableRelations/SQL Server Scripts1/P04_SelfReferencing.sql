CREATE DATABASE Teachers
USE Teachers

CREATE TABLE Teachers(
TeacherID INT PRIMARY KEY IDENTITY(101,1),
Name VARCHAR(30) NOT NULL,
ManagerID INT,

CONSTRAINT FK_EmployeeManager FOREIGN KEY (ManagerID)
REFERENCES Teachers(TeacherID)
)

GO

INSERT INTO Teachers VALUES
('John', NULL),
('Maya', 106),
('Silvia', 106),
('Ted', 105),
('Mark', 101),
('Greta', 101)

GO
SELECT*
FROM Teachers

USE master
DROP DATABASE Teachers