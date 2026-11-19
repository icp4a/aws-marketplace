-- create user <username>
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';

-- please modify location follow your requirement
create tablespace aeos_tbs owner <username> location '/pgsqldata/aeos';

grant create on tablespace aeos_tbs to <username>;

-- create database aeos
create database aeos owner <username> tablespace aeos_tbs template template0 encoding UTF8 ;

-- Connect to your database and create schema
\c aeos;

CREATE SCHEMA IF NOT EXISTS <username> AUTHORIZATION <username>;
GRANT ALL ON schema <username> to <username>;

-- create a schema for aeos and set the default
-- connect to the respective database before executing the below commands
SET ROLE <username>;
ALTER DATABASE aeos SET search_path TO <username>;
revoke connect on database aeos from public;