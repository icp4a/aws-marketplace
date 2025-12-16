-- create AWSDOCS object store database, you could update FILENAME as your requirement.
-- Please make sure you change the drive and path to your MSSQL database.
CREATE DATABASE AWSDOCS
ON PRIMARY
(  NAME = AWSDOCS_DATA,
   FILENAME = 'C:\MSSQL_DATABASE\AWSDOCS_DATA.mdf',
   SIZE = 400MB,
   FILEGROWTH = 128MB ),

FILEGROUP AWSDOCSSA_DATA_FG
(  NAME = AWSDOCSSA_DATA,
   FILENAME = 'C:\MSSQL_DATABASE\AWSDOCSSA_DATA.ndf',
   SIZE = 300MB,
   FILEGROWTH = 128MB),

FILEGROUP AWSDOCSSA_IDX_FG
(  NAME = AWSDOCSSA_IDX,
   FILENAME = 'C:\MSSQL_DATABASE\AWSDOCSSA_IDX.ndf',
   SIZE = 300MB,
   FILEGROWTH = 128MB)

LOG ON
(  NAME = 'AWSDOCS_LOG',
   FILENAME = 'C:\MSSQL_DATABASE\AWSDOCS_LOG.ldf',
   SIZE = 160MB,
   FILEGROWTH = 50MB )
GO

ALTER DATABASE AWSDOCS SET RECOVERY SIMPLE
GO

ALTER DATABASE AWSDOCS SET AUTO_CREATE_STATISTICS ON
GO

ALTER DATABASE AWSDOCS SET AUTO_UPDATE_STATISTICS ON
GO

ALTER DATABASE AWSDOCS SET READ_COMMITTED_SNAPSHOT ON
GO

-- create a SQL Server login account for the database user of each of the databases and update the master database to grant permission for XA transactions for the login account
USE MASTER
GO
-- when using SQL authentication
CREATE LOGIN <username> WITH PASSWORD='<password>'
-- when using Windows authentication:
-- CREATE LOGIN [domain\user] FROM WINDOWS
GO
CREATE USER <username> FOR LOGIN <username> WITH DEFAULT_SCHEMA=<username>
GO
EXEC sp_addrolemember N'SqlJDBCXAUser', N'<username>';
GO

-- Creating users and schemas for object store database
USE AWSDOCS
GO
CREATE USER <username> FOR LOGIN <username> WITH DEFAULT_SCHEMA=<username>
GO
CREATE SCHEMA <username> AUTHORIZATION <username>
GO
EXEC sp_addrolemember 'db_ddladmin', <username>;
EXEC sp_addrolemember 'db_datareader', <username>;
EXEC sp_addrolemember 'db_datawriter', <username>;
GO
