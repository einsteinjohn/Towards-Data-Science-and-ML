CREATE DATABASE JoinITSolutionsAssignments
GO

USE [JoinITSolutionsAssignments]
GO
ALTER AUTHORIZATION ON DATABASE :: [JoinITSolutionsAssignments] TO [SA]

GO

USE [JoinITSolutionsAssignments]
GO
ALTER DATABASE JoinITSolutionsAssignments
MODIFY FILE
	(NAME = JoinITSolutionsAssignments,
	SIZE= 100MB,
	MAXSIZE=UNLIMITED,
	FILEGROWTH=120MB);
GO
ALTER DATABASE JoinITSolutionsAssignments
MODIFY FILE 
	(NAME = JoinITSolutionsAssignments_log,
	size=100MB,
	MAXSIZE=UNLIMITED,
	filegrowth=120MB);

GO

