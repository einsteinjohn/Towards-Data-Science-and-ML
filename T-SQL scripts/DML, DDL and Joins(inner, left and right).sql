--DDL
--create, alter, Drop, Truncate, Use
--Create
CREATE DATABASE C4AClassDB

CREATE Table tblEmployees
(
EmployeeNumber INT NOT NULL,
EmployeeFirstName VARCHAR(30) NOT NULL,
EmployeeMiddleName VARCHAR(30) NULL,
EmployeeLastName VARCHAR(30),
EmployeeGovernmentID VARCHAR(10) NULL,
DateofBirth Datetime
);

--alter
ALTER Table tblEmployees
ADD Department VARCHAR(10)

ALTER Table tblEmployees
ALTER COLUMN Department VARCHAR(20)
--Drop 
Drop Table tblEmployees

SELECT * 
FROM tblEmployees

--DML
--Insert
INSERT INTO tblEmployees
VALUES (1, 'Dylan', 'A', 'Word', 'HN513777S', '19920914', 'Customer Relations'),
(2, 'Dylan', 'A', 'Word', 'HN513777D', '19920914', 'Customer Relations'),
(3,'Jossef', 'H', 'Wright', 'TX593671R', '19711224', 'Litigation'),
(4,'Jossef', 'H', 'Wright', 'TX593671R', '19711224', 'Litigation')

CREATE Table tblTransactions
(
EmployeeNumber INT,
Savings money,
DateofTransaction Datetime
)

Insert into tblTransactions --([EmployeeNumber],[Savings],[DateofTransaction])

Values ('', 964.05,'2022-01-26'),

('', 105.23,  '2022-02-14'),

(1, 964.05,'2022-01-26'),

(1, 105.23,   '2022-02-14'),

(2, 506.80,   '2022-01-05'),

(3, 239.55,   '2022-03-10'),

(3, 672.19,   '2022-1-31'),

(1, 788.07, '2022-03-01'),

(3, 847.08, '2022-02-04'),

(2, 807.99, '2022-02-04'),

(2, 807.10, '2022-03-04');

--JOIN(INNER JOIN)
SELECT E.EmployeeNumber,EmployeeFirstName,EmployeeLastName,SUM(Savings) AS TotalSavings
FROM tblEmployees AS E
Inner Join
tblTransactions T
ON
E.EmployeeNumber = T.EmployeeNumber
GROUP BY E.EmployeeNumber,EmployeeFirstName,EmployeeLastName

--LEFT JOIN OR LEFT OUTER JOIN

SELECT E.EmployeeNumber,EmployeeFirstName,EmployeeLastName, SUM(Savings) AS TotalSavings
FROM tblEmployees AS E
LEFT Join
tblTransactions T
ON
E.EmployeeNumber = T.EmployeeNumber
GROUP BY E.EmployeeNumber,EmployeeFirstName,EmployeeLastName

--RIGHT JOIN OR RIGHT OUTER JOIN
SELECT E.EmployeeNumber,EmployeeFirstName,EmployeeLastName,SUM(Savings) AS TotalSavings
FROM tblEmployees AS E
RIGHT Join
tblTransactions T
ON
E.EmployeeNumber = T.EmployeeNumber
GROUP BY E.EmployeeNumber,EmployeeFirstName,EmployeeLastName
