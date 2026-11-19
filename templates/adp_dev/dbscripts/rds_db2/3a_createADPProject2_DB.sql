CALL rdsadmin.create_database('proj2',32768,'UTF-8','US' );

--- Comment out all SQL stored procedures below when you are creating the database.
--- Once the database is created, comment out the create_database stored procedure statement and uncomment the below statements and execute them.
--- Creation of the Database can take some time, Please wait for a few minutes before executing the statements below.

-- Create bufferpool
CALL rdsadmin.create_bufferpool('proj2','proj2BP',-1,'Y','Y',32768,0,32);
CALL rdsadmin.create_bufferpool('proj2','proj2TEMPBP',-1,'Y','Y',32768,0,32);
CALL rdsadmin.create_bufferpool('proj2','proj2SYSBP',-1,'Y','Y',32768,0,32);

-- Create table spaces
CALL rdsadmin.create_tablespace('proj2','proj2DATA','proj2BP',32768,NULL,NULL,'U','AUTOMATIC');
CALL rdsadmin.create_tablespace('proj2','USERTEMP1','proj2TEMPBP',32768,NULL,NULL,'T','AUTOMATIC');
CALL rdsadmin.create_tablespace('proj2','TEMPSYS1','proj2SYSBP',32768,NULL,NULL,'S','AUTOMATIC');

-- Create role and user
CALL rdsadmin.create_role('proj2','PROJ2');
CALL rdsadmin.add_user('<username>','<password>',null);
CALL rdsadmin.grant_role(?,'proj2','PROJ2','USER <username>','N');
CALL rdsadmin.update_db_param('proj2','APPLHEAPSZ','2560');
CALL rdsadmin.update_db_param('proj2','STMTHEAP','8192');
