create database OCT31_4A
GO

USE OCT31_4A
	CREATE TABLE Students (
		StudentID int not null primary key,
		FirstName varchar (20) not null,
		LastName varchar (20) not null,
		Address varchar (30),
		Sex char (1),
		Age int,
		PhoneNumber char(10) not null)

INSERT INTO  Students VALUES (1,'Ernest','John','4231 Spar Court','M','23','9044225155')
INSERT INTO  Students VALUES (2,'Janice','Galvin','51 Avenue Drive', 'F', '29','9255225133')
INSERT INTO  Students VALUES (3,'Roberto','Jones','5411 70th Street','M','28','9047226965')
select * from Students



---Adding a Computed column to a Table as FullName 
ALTER TABLE [dbo].[Students] ADD FullName AS FirstName+' , '+LastName

----To read from the Table 
SELECT * FROM [dbo].[Students]

---To delete a Computed Column 
ALTER TABLE Students
DROP COLUMN FullName;

---Deleting the Table 
DROP TABLE [dbo].[Students]

---Deleting the Database 
DROP DATABASE OCT21_C4A

---Lest create another table 
CREATE TABLE Products(
ProductID int NOT NULL,
QuantityAvailable smallint,
UnitPrice money)

-- Insert values into the table.
INSERT INTO dbo.Products VALUES (1, 25, 25)
INSERT INTO dbo.Products VALUES (2, 10, 15)

-- Display the rows in the table.
SELECT *
FROM dbo.Products;

-- Update values in the table.
UPDATE dbo.Products 
SET UnitPrice = 5
WHERE ProductID = 1;


ALTER TABLE dbo.Products ADD RetailValue AS (QuantityAvailable + UnitPrice );

-- Display the rows in the table, and the new values for RetailValue
SELECT *
FROM dbo.Products;

ALTER TABLE dbo.Products DROP COLUMN RetailValue;

DROP Table Products