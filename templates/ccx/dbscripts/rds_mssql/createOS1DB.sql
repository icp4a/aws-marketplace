-- Create OS1DB object store database

-- ============================================================================
-- STEP 1: Connect to the master database
-- ============================================================================
-- :connect <rds-endpoint> -U <master_username> -P <master_password> -d master

-- 1. Create the OS1DB database
CREATE DATABASE OS1DB;
GO

-- 2. Set RECOVERY SIMPLE
ALTER DATABASE OS1DB SET RECOVERY SIMPLE;
GO

-- 3. Set AUTO_CREATE_STATISTICS ON
ALTER DATABASE OS1DB SET AUTO_CREATE_STATISTICS ON;
GO

-- 4. Set AUTO_UPDATE_STATISTICS ON
ALTER DATABASE OS1DB SET AUTO_UPDATE_STATISTICS ON;
GO

-- 5. Set READ_COMMITTED_SNAPSHOT ON
ALTER DATABASE OS1DB SET READ_COMMITTED_SNAPSHOT ON;
GO

-- 6. Create the server-level login
CREATE LOGIN <username> WITH PASSWORD='<password>';
GO

-- 7. Create the user in master (required for the SqlJDBCXAUser server role)
CREATE USER <username> FOR LOGIN <username>;
GO

-- 8. Grant server-level transaction role
ALTER ROLE SqlJDBCXAUser ADD MEMBER <username>;
GO


-- ============================================================================
-- STEP 2: Connect to the OS1DB database
-- ============================================================================
-- :connect <rds-endpoint> -U <master_username> -P <master_password> -d OS1DB

-- 1. Create the schema first so it can be assigned as the default
CREATE SCHEMA <username>;
GO

-- 2. Create the database-level user mapped to the login
CREATE USER <username> FOR LOGIN <username> WITH DEFAULT_SCHEMA = <username>;
GO

-- 3. Grant required database roles
ALTER ROLE db_ddladmin ADD MEMBER <username>;
ALTER ROLE db_datareader ADD MEMBER <username>;
ALTER ROLE db_datawriter ADD MEMBER <username>;
GO

-- 4. Allow the user to modify objects within their own schema
GRANT ALTER ON SCHEMA::<username> TO <username>;
GO
