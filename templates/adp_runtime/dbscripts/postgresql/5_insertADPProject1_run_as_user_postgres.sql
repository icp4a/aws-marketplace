--
-- IMPORTANT: Run this script as the Postgres user <username>
--

\c "adpbase" ;

set search_path to "<username>" ;

insert into TENANTINFO (tenantid,ontology,tenanttype,dailylimit,rdbmsengine,bacaversion,connstring,dbname,dbuser,tenantdbversion,featureflags,dbstatus,project_guid,bas_id) values ( 'proj1', 'ont1', 0, 0, 'PG', '23.0.2','DB=proj1;USR=<username>;SRV=<database_hostname>;PORT=<database_port>;Security=SSL;','proj1','<username>','23.0.2',154366,0,NULL,NULL) ;
