create database Groupwork
go
use Groupwork
	create table Employee(EmployeeID int Primary Key,
						  FirstName varchar(20),
						  LastName varchar(20),
						  DepartmentCode int unique not null,
						  Adress varchar(1) not null)
	create table Department(DepartmentCode int primary Key,
							Sector varchar(150) not null,
							ManagerID int not null,
							EmployeeID int constraint FK_EmployeeID foreign key (EmployeeID) references Employee(EmployeeID))
go
