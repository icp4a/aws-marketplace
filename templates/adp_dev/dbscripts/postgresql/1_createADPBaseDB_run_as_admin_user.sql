--
-- IMPORTANT: Run this script as the Postgres user with admin privileges to create a database.
--

CREATE DATABASE "adpbase" owner "<username>" template template0 encoding UTF8;

REVOKE CONNECT ON DATABASE "adpbase" FROM PUBLIC;

GRANT ALL ON DATABASE "adpbase" TO "<username>" ;

