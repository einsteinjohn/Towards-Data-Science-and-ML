Create table tblEmployee
(
ID int primary key,
Name nvarchar(50),
Gender nvarchar(50),
Salary int,
City nvarchar(50)
)

Insert into tblEmployee values (1, 'Peter', 'Male', 4000,'London')
Insert into tblEmployee values (2, 'Amanda', 'Female', 3000,'New York')
Insert into tblEmployee values (3, 'Willy', 'Male', 3500,'London')
Insert into tblEmployee values (4, 'Clovise', 'Male', 4500,'London')
Insert into tblEmployee values (5, 'Terry', 'Male', 2800,'Dallas')
Insert into tblEmployee values (6, 'Buke', 'Male', 7000,'New York')
Insert into tblEmployee values (7, 'Rhema', 'Female', 4800,'Dallas')
Insert into tblEmployee values (8, 'Tracy', 'Female', 5500,'New York')

Create table tblEmployee2
(
ID Bigint primary key,
Name varchar(50),
Gender varchar(50),
Salary int,
City nvarchar(50)
)

Insert into tblEmployee2 values (1, 'Peter', 'Male', 4000,'London')
Insert into tblEmployee2 values (2, 'Amanda', 'Female', 3000,'New York')
Insert into tblEmployee2 values (3, 'Willy', 'Male', 3500,'London')
Insert into tblEmployee2 values (4, 'Clovise', 'Male', 4500,'London')
Insert into tblEmployee2 values (9, 'Innocent', 'Male', 20800,'Dallas')
Insert into tblEmployee2 values (10, 'Perry', 'Male', 70000,'Ohio')
Insert into tblEmployee2 values (11, 'Adel', 'Female', 4800,'Texas')
Insert into tblEmployee2 values (12, 'Patricia', 'Female', 50500,'California')

TRUNCATE TABLE [dbo].[tblEmployees]
TRUNCATE TABLE [dbo].[tblTransactions]

INSERT INTO tblEmployees

VALUES (1, 'Dylan', 'A', 'Word', 'HN513777S', '19920914', 'Customer Relations'),
(2, 'Dylan', 'A', 'Word', 'HN513777D', '19920914', 'Customer Relations'),
(3,'Jossef', 'H', 'Wright', 'TX593671R', '19711224', 'Litigation'),
(4,'Jossef', 'H', 'Wright', 'TX593671R', '19711224', 'Litigation'),
(5, 'Dylan', 'A', 'Word', 'HN513777D', '19920914', 'Customer Relations'),
(6,'Jossef', 'H', 'Wright', 'TX593671R', '19711224', 'Litigation'),
(7,'Jossef', 'H', 'Wright', 'TX593671R', '19711224', 'Litigation'),
(8, 'Dylan', 'A', 'Word', 'HN513777D', '19920914', 'Customer Relations'),
(9,'Jossef', 'H', 'Wright', 'TX593671R', '19711224', 'Litigation'),
(10,'Jossef', 'H', 'Wright', 'TX593671R', '19711224', 'Litigation'),
(11, 'Dylan', 'A', 'Word', 'HN513777D', '19920914', 'Customer Relations'),
(12,'Jossef', 'H', 'Wright', 'TX593671R', '19711224', 'Litigation'),
(13,'Jossef', 'H', 'Wright', 'TX593671R', '19711224', 'Litigation'),
(14, 'Dylan', 'A', 'Word', 'HN513777D', '19920914', 'Customer Relations'),
(15,'Jossef', 'H', 'Wright', 'TX593671R', '19711224', 'Litigation'),
(4,'Jossef', 'H', 'Wright', 'TX593671R', '19711224', 'Litigation'),
(16, 'Dylan', 'A', 'Word', 'HN513777D', '19920914', 'Customer Relations'),
(17,'Jossef', 'H', 'Wright', 'TX593671R', '19711224', 'Litigation'),

(18,'Jossef', 'H', 'Wright', 'TX593671R', '19711224', 'Litigation'),
(19, 'Dylan', 'A', 'Word', 'HN513777D', '19920914', 'Customer Relations'),

(20,'Jossef', 'H', 'Wright', 'TX593671R', '19711224', 'Litigation'),

(21,'Jossef', 'H', 'Wright', 'TX593671R', '19711224', 'Litigation'),
(22, 'Dylan', 'A', 'Word', 'HN513777D', '19920914', 'Customer Relations'),

(23,'Jossef', 'H', 'Wright', 'TX593671R', '19711224', 'Litigation'),

(24,'Jossef', 'H', 'Wright', 'TX593671R', '19711224', 'Litigation')

Insert into tblTransactions

Values (1, 964.05,'2022-01-26'),
(1, 105.23,  '2022-02-14'),
(2, 964.05,'2022-01-26'),
(2, 105.23,   '2022-02-14'),
(2, 506.80,   '2022-01-05'),
(3, 239.55,   '2022-03-10'),
(3, 672.19,   '2022-1-31'),
(1, 788.07, '2022-03-01'),
(3, 847.08, '2022-02-04'),
(4, 807.99, '2022-02-04'),
(4, 807.10, '2022-03-04'),
(1, 105.23,  '2022-02-14'),
(2, 964.05,'2022-01-26'),
(2, 105.23,   '2022-02-14'),
(2, 506.80,   '2022-01-05'),
(3, 239.55,   '2022-03-10'),
(3, 672.19,   '2022-1-31'),
(1, 788.07, '2022-03-01'),
(3, 847.08, '2022-02-04'),
(4, 807.99, '2022-02-04'),
(4, 807.10, '2022-03-04'),
(1, 105.23,  '2022-02-14'),
(2, 964.05,'2022-01-26'),
(2, 105.23,   '2022-02-14'),
(2, 506.80,   '2022-01-05'),
(3, 239.55,   '2022-03-10'),
(3, 672.19,   '2022-1-31'),
(1, 788.07, '2022-03-01'),
(3, 847.08, '2022-02-04'),
(4, 807.99, '2022-02-04'),
(4, 807.10, '2022-03-04'),
(1, 105.23,  '2022-02-14'),
(2, 964.05,'2022-01-26'),
(2, 105.23,   '2022-02-14'),
(2, 506.80,   '2022-01-05'),
(3, 239.55,   '2022-03-10'),
(3, 672.19,   '2022-1-31'),
(1, 788.07, '2022-03-01'),
(3, 847.08, '2022-02-04'),
(4, 807.99, '2022-02-04'),
(4, 807.10, '2022-03-04'),
(5, 105.23,  '2022-02-14'),
(5, 964.05,'2022-01-26'),
(6, 105.23,   '2022-02-14'),
(6, 506.80,   '2022-01-05'),
(7, 239.55,   '2022-03-10'),
(7, 672.19,   '2022-1-31'),
(8, 788.07, '2022-03-01'),
(8, 847.08, '2022-02-04'),
(9, 807.99, '2022-02-04'),
(9, 807.10, '2022-03-04'),
(4, 807.99, '2022-02-04'),
(4, 807.10, '2022-03-04'),
(5, 105.23,  '2022-02-14'),
(5, 964.05,'2022-01-26'),
(6, 105.23,   '2022-02-14'),
(6, 506.80,   '2022-01-05'),
(7, 239.55,   '2022-03-10'),
(7, 672.19,   '2022-1-31'),
(9, 788.07, '2022-03-01'),
(9, 847.08, '2022-02-04'),
(10, 807.99, '2022-02-04'),
(10, 807.10, '2022-03-04'),
(11, 807.99, '2022-02-04'),
(11, 807.10, '2022-03-04'),
(12, 105.23,  '2022-02-14'),
(12, 964.05,'2022-01-26'),
(13, 105.23,   '2022-02-14'),
(13, 506.80,   '2022-01-05'),
(14, 239.55,   '2022-03-10'),
(14, 672.19,   '2022-1-31'),
(15, 788.07, '2022-03-01'),
(15, 847.08, '2022-02-04'),
(16, 807.99, '2022-02-04'),
(16, 807.10, '2022-03-04'),
(17, 788.07, '2022-03-01'),
(17, 847.08, '2022-02-04'),
(18, 807.99, '2022-02-04'),
(18, 807.10, '2022-03-04')


--UNION
SELECT ID, Name, Gender, Salary, City FROM tblEmployee
UNION
SELECT ID, Name, Gender, Salary, City FROM tblEmployee2

--UNION ALL
SELECT ID, Name, Gender, Salary, City FROM tblEmployee
UNION ALL
SELECT ID, Name, Gender, Salary, City FROM tblEmployee2


CREATE VIEW VW_TotalSavings AS
Select E.EmployeeNumber, EmployeeFirstName, EmployeeLastName, Sum(Savings) AS TotalSavings
From tblEmployees AS E
RIGHT JOIN
tblTransactions AS T
ON
E.EmployeeNumber = T.EmployeeNumber
--WHERE E.EmployeeNumber Between 5 and 15
GROUP BY E.EmployeeNumber, EmployeeFirstName, EmployeeLastName
GO

SELECT * FROM [dbo].[VW_TotalSavings]
