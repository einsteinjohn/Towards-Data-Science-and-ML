USE [master]
GO

/****** Object:  Database [SnapshotDB]    Script Date: 2/16/2022 1:36:11 PM ******/
CREATE DATABASE [SnapshotDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SnapshotDB', FILENAME = N'E:\TESTPRJ\SnapshotDB.mdf'  ),
( NAME = N'SnapshotDB_S', FILENAME = N'E:\TESTPRJ\SnapshotDB_S.ndf' , )
 

create database Snapshot_Snapshot
--Note here, copy all file names from the database here below.
on (NAME = N'SnapshotDB', FILENAME = N'E:\TESTPRJ\SnapshotDB.ss'),
   ( NAME = N'SnapshotDB_S', FILENAME = N'E:\TESTPRJ\SnapshotDB_S.ss')

as snapshot of [SnapshotDB]

create table Test(ID int, name VARCHAR(20))

INSERT INTO TEST VALUES (1, 'Adel')

restore database [SnapshotDB]
FROM Database_snapshot = 'Snapshot_Snapshot'
