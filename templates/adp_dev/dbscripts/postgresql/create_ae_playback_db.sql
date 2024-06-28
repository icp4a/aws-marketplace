-- create a new user
create user <username> with password '<password>';
-- create database appdb
create database appdb owner <username>;
-- The following grant is used for databases
grant all privileges on database appdb to <username>;
