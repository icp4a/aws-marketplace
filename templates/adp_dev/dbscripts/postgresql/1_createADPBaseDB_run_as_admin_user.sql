--
-- IMPORTANT: Run this script as the Postgres user with admin privileges to create a database.
--

-- Please review the tablespace values below to confirm they are accurate for your environment. 
-- If you want to use the default tablespace for the database, remove the tablespace-related portions below.

CREATE TABLESPACE "adpbase_tbs" OWNER "<username>" LOCATION '/pgsqldata/adpbase';

CREATE DATABASE "adpbase" owner "<username>" template template0 encoding UTF8 tablespace "adpbase_tbs";

REVOKE CONNECT ON DATABASE "adpbase" FROM PUBLIC;

GRANT ALL ON DATABASE "adpbase" TO "<username>" ;

