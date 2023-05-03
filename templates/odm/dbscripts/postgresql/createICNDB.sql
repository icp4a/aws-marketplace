-- create user
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';

-- create database icndb
create database icndb owner <username> template template0 encoding UTF8 ;
revoke connect on database icndb from public;
grant all privileges on database icndb to <username>;
grant connect, temp, create on database icndb to <username>;

-- please modify location follow your requirement
create tablespace icndb_tbs owner <username> location '/pgsqldata/icndb';
grant create on tablespace icndb_tbs to <username>;  