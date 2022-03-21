--Full tutorial on how to partition using T-SQL. Full tutorial is on 
--https://www.sqlshack.com/database-table-partitioning-sql-server/
----================================================================================-------------------------

--creates our partitioning filegroup
ALTER DATABASE PartitioningDB
ADD FILEGROUP January
GO
ALTER DATABASE PartitioningDB
ADD FILEGROUP February
GO
ALTER DATABASE PartitioningDB
ADD FILEGROUP March
GO
ALTER DATABASE PartitioningDB
ADD FILEGROUP April
GO
ALTER DATABASE PartitioningDB
ADD FILEGROUP May
GO
ALTER DATABASE PartitioningDB
ADD FILEGROUP June
GO
ALTER DATABASE PartitioningDB
ADD FILEGROUP July
GO
ALTER DATABASE PartitioningDB
ADD FILEGROUP Avgust
GO
ALTER DATABASE PartitioningDB
ADD FILEGROUP September
GO
ALTER DATABASE PartitioningDB
ADD FILEGROUP October
GO
ALTER DATABASE PartitioningDB
ADD FILEGROUP November
GO
ALTER DATABASE PartitioningDB
ADD FILEGROUP December
GO


SELECT name AS AvailableFilegroups
FROM sys.filegroups
WHERE type = 'FG'

-- this creates files in each file group 
ALTER DATABASE [PartitioningDB]
    ADD FILE 
    (
    NAME = [PartJan],
    FILENAME = 'E:\TESTPRJ\Partition\PartitioningDB.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP [January]

	ALTER DATABASE [PartitioningDB]
    ADD FILE 
    (
    NAME = [PartFeb],
    FILENAME = 'E:\TESTPRJ\Partition\PartitioningDB2.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP [February]

	ALTER DATABASE [PartitioningDB]
    ADD FILE 
    (
    NAME = [PartMar],
    FILENAME = 'E:\TESTPRJ\Partition\PartitioningDB3.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP [March]

	ALTER DATABASE [PartitioningDB]
    ADD FILE 
    (
    NAME = [PartApr],
    FILENAME = 'E:\TESTPRJ\Partition\PartitioningDB4.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP [April]

	ALTER DATABASE [PartitioningDB]
    ADD FILE 
    (
    NAME = [PartMay],
    FILENAME = 'E:\TESTPRJ\Partition\PartitioningDB5.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP [May]

	ALTER DATABASE [PartitioningDB]
    ADD FILE 
    (
    NAME = [PartJun],
    FILENAME = 'E:\TESTPRJ\Partition\PartitioningDB6.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP [June]

	ALTER DATABASE [PartitioningDB]
    ADD FILE 
    (
    NAME = [PartJul],
    FILENAME = 'E:\TESTPRJ\Partition\PartitioningDB7.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP [July]

	ALTER DATABASE [PartitioningDB]
    ADD FILE 
    (
    NAME = [PartAug],
    FILENAME = 'E:\TESTPRJ\Partition\PartitioningDB8.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP [Avgust]

	ALTER DATABASE [PartitioningDB]
    ADD FILE 
    (
    NAME = [PartSep],
    FILENAME = 'E:\TESTPRJ\Partition\PartitioningDB9.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP [September]

	ALTER DATABASE [PartitioningDB]
    ADD FILE 
    (
    NAME = [PartOct],
    FILENAME = 'E:\TESTPRJ\Partition\PartitioningDB10.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP [October]

	ALTER DATABASE [PartitioningDB]
    ADD FILE 
    (
    NAME = [PartNov],
    FILENAME = 'E:\TESTPRJ\Partition\PartitioningDB11.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP [November]

	ALTER DATABASE [PartitioningDB]
    ADD FILE 
    (
    NAME = [PartDec],
    FILENAME = 'E:\TESTPRJ\Partition\PartitioningDB12.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP [December]

--cecking the filepath
	SELECT 
name as [FileName],
physical_name as [FilePath] 
FROM sys.database_files
where type_desc = 'ROWS'
GO

--creating partition functions
CREATE PARTITION FUNCTION [PartitioningByMonth] (datetime)
AS RANGE RIGHT FOR VALUES ('20140201', '20140301', '20140401',
               '20140501', '20140601', '20140701', '20140801', 
               '20140901', '20141001', '20141101', '20141201')

--creates partition scheme and distributes data into those partition groups we created earlier
CREATE PARTITION SCHEME PartitionBymonth
AS PARTITION PartitioningBymonth
TO (January, February, March, 
    April, May, June, July, 
    Avgust, September, October, 
    November, December);

--create a table with some info and apply our partitioning on it. 
CREATE TABLE Reports
(ReportDate datetime PRIMARY KEY,
MonthlyReport varchar(max))
ON PartitionBymonth (ReportDate); --this is where we are applying our partitioning, it's done on the ReportDate column
GO
 
INSERT INTO Reports (ReportDate,MonthlyReport)
SELECT '20140105', 'ReportJanuary' UNION ALL
SELECT '20140205', 'ReportFebryary' UNION ALL
SELECT '20140308', 'ReportMarch' UNION ALL
SELECT '20140409', 'ReportApril' UNION ALL
SELECT '20140509', 'ReportMay' UNION ALL
SELECT '20140609', 'ReportJune' UNION ALL
SELECT '20140709', 'ReportJuly' UNION ALL
SELECT '20140809', 'ReportAugust' UNION ALL
SELECT '20140909', 'ReportSeptember' UNION ALL
SELECT '20141009', 'ReportOctober' UNION ALL
SELECT '20141109', 'ReportNovember' UNION ALL
SELECT '20141209', 'ReportDecember'

--checks to make sure the partitioning was done right. 
SELECT 
p.partition_number AS PartitionNumber,
f.name AS PartitionFilegroup, 
p.rows AS NumberOfRows 
FROM sys.partitions p
JOIN sys.destination_data_spaces dds ON p.partition_number = dds.destination_id
JOIN sys.filegroups f ON dds.data_space_id = f.data_space_id
WHERE OBJECT_NAME(OBJECT_ID) = 'Reports'