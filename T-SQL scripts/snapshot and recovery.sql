create database AdventureWorks_Snapshot

on (Name = AdventureWorksDW2016_Data, Filename = 'E:\TESTPRJ\AdventureWorksDW2016_Data.ss')

as snapshot of [AdventureWorksDW2016]

restore database [AdventureWorksDW2016]
FROM Database_snapshot = 'AdventureWorks_Snapshot'
