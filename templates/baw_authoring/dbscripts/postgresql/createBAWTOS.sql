-- create user
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';

-- create database bawtos
create database bawtos owner <username> template template0 encoding UTF8 ;
revoke connect on database bawtos from public;
grant all privileges on database bawtos to <username>;
grant connect, temp, create on database bawtos to <username>;

-- please modify location follow your requirement
create tablespace bawtos_tbs owner <username> location '/pgsqldata/bawtos';
grant create on tablespace bawtos_tbs to <username>;  