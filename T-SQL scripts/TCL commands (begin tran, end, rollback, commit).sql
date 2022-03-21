--TCL: BEGIN TRAN, END, ROLLBACK, COMMIT
--(run with data from Joins)--

--Update
BEGIN TRAN
UPDATE tblEmployees
Set EmployeeNumber = 6
WHERE EmployeeNUMBER = 1 AND EmployeeFirstName ='Innocent'
SELECT * FROM tblEmployees
ROLLBACK
Commit

--Delete
BEGIN TRAN
Delete --tblEmployees
From tblEmployees
WHERE EmployeeNumber = 1
SELECT * FROM tblEmployees
ROLLBACK

--Truncate
BEGIN TRAN
Truncate Table tblEmployees
SELECT * FROM tblEmployees
ROLLBACK