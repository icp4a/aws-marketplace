-- create user
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';

-- create database bawdos
create database bawdos owner <username> template template0 encoding UTF8 ;
revoke connect on database bawdos from public;
grant all privileges on database bawdos to <username>;
grant connect, temp, create on database bawdos to <username>;

-- please modify location follow your requirement
create tablespace bawdos_tbs owner <username> location '/pgsqldata/bawdos';
grant create on tablespace bawdos_tbs to <username>;  