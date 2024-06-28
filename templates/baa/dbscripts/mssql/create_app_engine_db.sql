-- create application engine database
CREATE DATABASE AAEDB;

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

-- Creating users and schemas for application engine database
USE AAEDB
GO
CREATE USER <username> FOR LOGIN <username> WITH DEFAULT_SCHEMA=<username>
GO
EXEC sp_addrolemember 'db_ddladmin', <username>;
EXEC sp_addrolemember 'db_datareader', <username>;
EXEC sp_addrolemember 'db_datawriter', <username>;
GO