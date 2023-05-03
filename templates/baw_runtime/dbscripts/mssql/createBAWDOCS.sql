-- create BAWDOCS object store database, you could update FILENAME as your requirement.
-- Please make sure you change the drive and path to your MSSQL database.
CREATE DATABASE BAWDOCS
ON PRIMARY
(  NAME = BAWDOCS_DATA,
   FILENAME = 'C:\MSSQL_DATABASE\BAWDOCS_DATA.mdf',
   SIZE = 400MB,
   FILEGROWTH = 128MB ),

FILEGROUP BAWDOCSSA_DATA_FG
(  NAME = BAWDOCSSA_DATA,
   FILENAME = 'C:\MSSQL_DATABASE\BAWDOCSSA_DATA.ndf',
   SIZE = 300MB,
   FILEGROWTH = 128MB),

FILEGROUP BAWDOCSSA_IDX_FG
(  NAME = BAWDOCSSA_IDX,
   FILENAME = 'C:\MSSQL_DATABASE\BAWDOCSSA_IDX.ndf',
   SIZE = 300MB,
   FILEGROWTH = 128MB)

LOG ON
(  NAME = 'BAWDOCS_LOG',
   FILENAME = 'C:\MSSQL_DATABASE\BAWDOCS_LOG.ldf',
   SIZE = 160MB,
   FILEGROWTH = 50MB )
GO

ALTER DATABASE BAWDOCS SET RECOVERY SIMPLE
GO

ALTER DATABASE BAWDOCS SET AUTO_CREATE_STATISTICS ON
GO

ALTER DATABASE BAWDOCS SET AUTO_UPDATE_STATISTICS ON
GO

ALTER DATABASE BAWDOCS SET READ_COMMITTED_SNAPSHOT ON
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
USE BAWDOCS
GO
CREATE USER <username> FOR LOGIN <username> WITH DEFAULT_SCHEMA=<username>
GO
CREATE SCHEMA <username> AUTHORIZATION <username>
GO
EXEC sp_addrolemember 'db_ddladmin', <username>;
EXEC sp_addrolemember 'db_datareader', <username>;
EXEC sp_addrolemember 'db_datawriter', <username>;
GO