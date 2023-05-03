-- create the user
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';

-- create the database:
CREATE DATABASE basdb WITH OWNER <username> ENCODING 'UTF8';
GRANT ALL ON DATABASE basdb to <username>;

-- Connect to your database and create schema
\c basdb;
SET ROLE <username>;
CREATE SCHEMA IF NOT EXISTS <username> AUTHORIZATION <username>;