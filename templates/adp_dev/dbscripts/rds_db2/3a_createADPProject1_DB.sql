CALL rdsadmin.create_database('proj1',32768,'UTF-8','US' );

--- Comment out all SQL stored procedures below when you are creating the database.
--- Once the database is created, comment out the create_database stored procedure statement and uncomment the below statements and execute them.
--- Creation of the Database can take some time, Please wait for a few minutes before executing the statements below.

-- Create bufferpool
CALL rdsadmin.create_bufferpool('proj1','proj1BP',-1,'Y','Y',32768,0,32);
CALL rdsadmin.create_bufferpool('proj1','proj1TEMPBP',-1,'Y','Y',32768,0,32);
CALL rdsadmin.create_bufferpool('proj1','proj1SYSBP',-1,'Y','Y',32768,0,32);

-- Create table spaces
CALL rdsadmin.create_tablespace('proj1','proj1DATA','proj1BP',32768,NULL,NULL,'U','AUTOMATIC');
CALL rdsadmin.create_tablespace('proj1','USERTEMP1','proj1TEMPBP',32768,NULL,NULL,'T','AUTOMATIC');
CALL rdsadmin.create_tablespace('proj1','TEMPSYS1','proj1SYSBP',32768,NULL,NULL,'S','AUTOMATIC');

-- Create role and user
CALL rdsadmin.create_role('proj1','PROJ1');
CALL rdsadmin.add_user('<username>','<password>',null);
CALL rdsadmin.grant_role(?,'proj1','PROJ1','USER <username>','N');
CALL rdsadmin.update_db_param('proj1','APPLHEAPSZ','2560');
CALL rdsadmin.update_db_param('proj1','STMTHEAP','8192');
