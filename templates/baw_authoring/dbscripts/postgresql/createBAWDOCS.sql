-- create user
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';

-- create database bawdocs
create database bawdocs owner <username> template template0 encoding UTF8 ;
revoke connect on database bawdocs from public;
grant all privileges on database bawdocs to <username>;
grant connect, temp, create on database bawdocs to <username>;

-- please modify location follow your requirement
create tablespace bawdocs_tbs owner <username> location '/pgsqldata/bawdocs';
grant create on tablespace bawdocs_tbs to <username>;