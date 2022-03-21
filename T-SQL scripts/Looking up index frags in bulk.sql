SELECT S.name as 'Schema',
T.name as 'Table',
I.name as 'Index',
DDIPS.avg_fragmentation_in_percent,
DDIPS.page_count
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS DDIPS
INNER JOIN sys.tables T on T.object_id = DDIPS.object_id
INNER JOIN sys.schemas S on T.schema_id = S.schema_id
INNER JOIN sys.indexes I ON I.object_id = DDIPS.object_id
AND DDIPS.index_id = I.index_id
WHERE DDIPS.database_id = DB_ID()
and I.name is not null
AND DDIPS.avg_fragmentation_in_percent > 0
ORDER BY DDIPS.avg_fragmentation_in_percent desc

--Reorganize an index
ALTER INDEX Index_Name ON Table_Name REORGANIZE
ALTER INDEX PK_Employee_EmployeeID ON HumanResources.Employee REORGANIZE;
----Reorganize all indexes on a table
ALTER INDEX ALL ON HumanResources.Employee REORGANIZE;
DBCC INDEXDEFRAG('DatabaseName', 'TableName');

--Rebuild an index
ALTER INDEX Index_Name ON Table_Name REBUILD
ALTER INDEX PK_Employee_EmployeeID ON HumanResources.Employee REBUILD;

--Rebuild all indexes on a table 
ALTER INDEX ALL ON Production.Product  REBUILD 
--WITH (FILLFACTOR = 80, SORT_IN_TEMPDB = ON, STATISTICS_NORECOMPUTE = ON);
DBCC DBREINDEX ('DatabaseName', 'TableName');

--REBUILD Index with ONLINE OPTION (meaning table will still be available to use when rebuilding)
ALTER INDEX Index_Name ON Table_Name REBUILD WITH(ONLINE=ON)