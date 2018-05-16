
CREATE TABLE People (
	Id INT PRIMARY KEY IDENTITY(1,1),
	[Name] NVARCHAR(200) NOT NULL,
	Picture VARBINARY(2000),
	Height DECIMAL(3,2),
	[Weight] DECIMAL(5,2),
	Gender CHAR(1) NOT NULL,
	Birthdate DATE NOT NULL,
	Biography NVARCHAR(MAX)
)


INSERT INTO People([Name],Height,[Weight],Gender,Birthdate)
VALUES ('Ivan Petrov Kolarov',1.82,76.3,'M','1978-04-12'),
('Marina Petrova Ivanova',1.62,46.3,'F','1998-09-12'),
('Marin Petrov Kolarov',2.02,96.3,'M','1978-07-14'),
('Ivan Marinov Petkov',1.92,126.3,'M','2002-03-1'),
('Krasimir Petrov Kolarov',1.82,86.3,'M','1999-08-14')

SELECT * FROM People