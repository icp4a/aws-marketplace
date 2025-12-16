--
-- IMPORTANT: Run this script as the Postgres user with admin privileges to create a database.
--

-- Please review the tablespace values below to confirm they are accurate for your environment. 
-- If you want to use the default tablespace for the database, remove the tablespace-related portions below.

CREATE TABLESPACE "proj1_tbs" OWNER "<username>" LOCATION '/pgsqldata/proj1';
CREATE DATABASE "proj1" owner "<username>" template template0 encoding UTF8 tablespace "proj1_tbs";

REVOKE CONNECT ON DATABASE "proj1" FROM PUBLIC;

GRANT ALL ON DATABASE "proj1" TO "<username>";
