INSERT INTO Towns
VALUES
('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas')

INSERT INTO Departments
VALUES
('Engineering'), 
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance')


INSERT INTO Adresses
VALUES
('Hadji Dimitar 55',1),
('Izgrev',2),
('Zalez',3),
('Samolet',4)

INSERT INTO Employees(FirstName,MiddleName,LastName,JobTitle,DepartmentId,HireDate,Salary,AddressId)
Values('Ivan','Ivanov','Ivanov','.NET Developer',4,'2013-02-01',3500.00,1),
('Petar','Petarov','Petarov','Senior Engineer',1,'2004-03-02',4000.00,2),
('Maria','Petrova','Ivanova','Intern',5,'2016-08-28',525.25,1),
('Georgi','Terziev','Ivanov','CEO',2,'2007-12-09',3000.00,2),
('Petar','Pan','Pan','Intern',3,'2016-08-28', 599.88,1)

SELECT* FROM Employees