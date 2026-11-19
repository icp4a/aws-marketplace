-- create user <username>
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';

-- please modify location follow your requirement
create tablespace icndb_tbs owner <username> location '/pgsqldata/icndb';
grant create on tablespace icndb_tbs to <username>;  

-- create database icndb
create database icndb owner <username> tablespace icndb_tbs template template0 encoding UTF8 ;

\c icndb;

CREATE SCHEMA IF NOT EXISTS <username> AUTHORIZATION <username>;
GRANT ALL ON schema <username> to <username>;

-- create a schema for icndb and set the default
-- connect to the respective database before executing the below commands
SET ROLE <username>;
ALTER DATABASE icndb SET search_path TO <username>;
revoke connect on database icndb from public;

