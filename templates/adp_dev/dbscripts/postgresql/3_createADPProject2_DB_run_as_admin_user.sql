--
-- IMPORTANT: Run this script as the Postgres user with admin privileges to create a database.
--

CREATE DATABASE "proj2" owner "<username>" template template0 encoding UTF8;

REVOKE CONNECT ON DATABASE "proj2" FROM PUBLIC;

GRANT ALL ON DATABASE "proj2" TO "<username>";
