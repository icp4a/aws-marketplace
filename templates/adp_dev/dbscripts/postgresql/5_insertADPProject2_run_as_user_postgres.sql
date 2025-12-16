--
-- IMPORTANT: Run this script as the Postgres user <username>
--

\c "adpbase" ;

set search_path to "<username>" ;

-- Insert the row in TenantInfo table with a placeholder for the schema_version. The version will be updated by a common function
insert into TENANTINFO (tenantid,ontology,tenanttype,dailylimit,rdbmsengine,bacaversion,connstring,dbname,dbuser,tenantdbversion,featureflags,dbstatus,project_guid,bas_id) values ( 'proj2', 'ont1', 0, 0, 'PG', '24.0.0','DB=proj2;USR=<username>;SRV=<database_hostname>;PORT=<database_port>;Security=SSL;','proj2','<username>','24.0.0',154366,0,NULL,NULL) ;
