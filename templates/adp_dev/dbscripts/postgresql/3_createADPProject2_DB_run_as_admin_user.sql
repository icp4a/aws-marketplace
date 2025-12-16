--
-- IMPORTANT: Run this script as the Postgres user with admin privileges to create a database.
--

-- Please review the tablespace values below to confirm they are accurate for your environment. 
-- If you want to use the default tablespace for the database, remove the tablespace-related portions below.

CREATE TABLESPACE "proj2_tbs" OWNER "<username>"" LOCATION '/pgsqldata/proj2';

CREATE DATABASE "proj2" owner "<username>" template template0 encoding UTF8 tablespace "proj2_tbs";

REVOKE CONNECT ON DATABASE "proj2" FROM PUBLIC;

GRANT ALL ON DATABASE "proj2" TO "<username>";
