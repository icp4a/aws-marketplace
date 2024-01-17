-- create user
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';

-- please modify location follow your requirement
create tablespace gcddb_tbs owner <username> location '/pgsqldata/gcd';
grant create on tablespace gcddb_tbs to <username>;  

-- create database gcddb
create database gcddb owner <username> tablespace gcddb_tbs template template0 encoding UTF8 ;
revoke connect on database gcddb from public;
grant all privileges on database gcddb to <username>;
grant connect, temp, create on database gcddb to <username>;

-- create a schema for gcddb and set the default
-- connect to the respective database before executing the below commands
\connect gcddb;
CREATE SCHEMA IF NOT EXISTS AUTHORIZATION <username>;
SET ROLE <username>;
ALTER DATABASE gcddb SET search_path TO <username>;
