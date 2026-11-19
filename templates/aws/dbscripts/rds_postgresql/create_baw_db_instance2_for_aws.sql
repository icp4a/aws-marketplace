-- create the user
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';

-- create the database:
CREATE DATABASE awsdb WITH OWNER <username> ENCODING 'UTF8';

-- Connect to your database and create schema
\c awsdb;
CREATE SCHEMA IF NOT EXISTS <username> AUTHORIZATION <username>;
GRANT ALL ON schema <username> to <username>;
