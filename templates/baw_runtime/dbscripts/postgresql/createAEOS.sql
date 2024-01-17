-- create user
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';

-- please modify location follow your requirement
create tablespace aeos_tbs owner <username> location '/pgsqldata/aeos';
grant create on tablespace aeos_tbs to <username>;

-- create database aeos
create database aeos owner <username> tablespace aeos_tbs template template0 encoding UTF8 ;
revoke connect on database aeos from public;
grant all privileges on database aeos to <username>;
grant connect, temp, create on database aeos to <username>;

-- create a schema for aeos and set the default
-- connect to the respective database before executing the below commands
\connect aeos;
CREATE SCHEMA IF NOT EXISTS AUTHORIZATION <username>;
SET ROLE <username>;
ALTER DATABASE aeos SET search_path TO <username>;