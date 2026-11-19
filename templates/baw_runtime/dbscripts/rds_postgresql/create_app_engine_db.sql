-- create a new user
create user <username> with password '<password>';

-- create database aaedb
create database aaedb owner <username>;

-- The following grant is used for databases
grant all privileges on database aaedb to <username>;