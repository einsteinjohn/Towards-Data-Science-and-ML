alter table [HumanResources].[Employees]
	add PhoneNumber int;

Alter table [HumanResources].[Employee]
	drop column PhoneNumber

select * from [HumanResources].[Employees]