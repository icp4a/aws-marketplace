CALL rdsadmin.create_database('adpbase',32768,'UTF-8','US' );

--- Comment out all SQL stored procedures below when you are creating the database.
--- Once the database is created, comment out the create_database stored procedure statement and uncomment the below statements and execute them.
--- Creation of the Database can take some time, Please wait for a few minutes before executing the statements below.

-- Create role for the database
CALL rdsadmin.create_role('adpbase','ADPBASE');
-- Create a user
CALL rdsadmin.add_user('<username>','<password>',null);
CALL rdsadmin.grant_role(?,'adpbase','ADPBASE','USER <username>','N');
CALL rdsadmin.dbadm_grant(?,'adpbase','DATAACCESS','USER <username>');
