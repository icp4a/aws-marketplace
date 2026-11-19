-- create user <username>
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';

-- please modify location follow your requirement
create tablespace gcddb_tbs owner <username> location '/pgsqldata/gcd';
grant create on tablespace gcddb_tbs to <username>;  

-- create database gcddb
create database gcddb owner <username> tablespace gcddb_tbs template template0 encoding UTF8 ;
-- Connect to your database and create schema
\c gcddb;
CREATE SCHEMA IF NOT EXISTS <username> AUTHORIZATION <username>;
GRANT ALL ON schema <username> to <username>;

-- create a schema for gcddb and set the default
-- connect to the respective database before executing the below commands
SET ROLE <username>;
ALTER DATABASE gcddb SET search_path TO <username>;
revoke connect on database gcddb from public;