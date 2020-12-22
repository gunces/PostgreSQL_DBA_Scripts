CREATE OR REPLACE FUNCTION revoke_all_privileges(f_username TEXT)
RETURNS void 
LANGUAGE PLPGSQL
AS $$

DECLARE
schemanames TEXT;
cur_database TEXT;
BEGIN

	SELECT CURRENT_DATABASE() INTO cur_database;	
	RAISE NOTICE 'Current Database: %', cur_database;
		
	IF EXISTS (SELECT rolname FROM pg_catalog.pg_roles WHERE rolname=f_username) THEN 
			
		SELECT STRING_AGG(distinct schemaname, ',') INTO schemanames
		  FROM pg_catalog.pg_tables
		 WHERE schemaname != 'pg_catalog'
		   AND schemaname != 'information_schema';  
		RAISE NOTICE 'All schemas: %', schemanames;		
		
		EXECUTE 'REVOKE ALL ON DATABASE "' || cur_database || '" FROM "' || f_username || '"';
		RAISE NOTICE 'REVOKE ALL ON DATABASE "%" FROM "%"', cur_database, f_username;

		EXECUTE 'ALTER DEFAULT PRIVILEGES IN SCHEMA "' || schemanames || '" REVOKE ALL PRIVILEGES ON TABLES FROM "' || f_username || '"';
		RAISE NOTICE 'ALTER DEFAULT PRIVILEGES IN SCHEMA "%" REVOKE ALL PRIVILEGES ON TABLES FROM "%"', schemanames, f_username;
	 
		EXECUTE 'REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA "' || schemanames || '" FROM "' || f_username || '"';
		RAISE NOTICE 'REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA "%" FROM "%"', schemanames, f_username;

		EXECUTE 'REVOKE ALL PRIVILEGES ON SCHEMA "' || schemanames || '" FROM "' || f_username || '"';
		RAISE NOTICE 'REVOKE ALL PRIVILEGES ON SCHEMA "%" FROM "%"', schemanames, f_username;

		EXECUTE 'REVOKE ALL PRIVILEGES ON ALL TABLES in SCHEMA "' || schemanames || '" FROM "' || f_username || '"';
		RAISE NOTICE 'REVOKE ALL PRIVILEGES ON ALL TABLES in SCHEMA "%" FROM "%"', schemanames, f_username;

		EXECUTE 'REVOKE ALL PRIVILEGES ON ALL SEQUENCES in SCHEMA "' || schemanames || '" FROM "' || f_username || '"';
		RAISE NOTICE 'REVOKE ALL PRIVILEGES ON ALL SEQUENCES in SCHEMA "%" FROM "%"', schemanames, f_username;


	ELSE 
  
		RAISE EXCEPTION '% user is not exists. ', f_username;
		/* 
		REVOKE ALL ON DATABASE <change dbname> FROM <change db user>;
		ALTER DEFAULT PRIVILEGES IN SCHEMA public REVOKE ALL PRIVILEGES ON TABLES FROM <change db user>;
		REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public FROM <change db user>;
		REVOKE ALL PRIVILEGES ON SCHEMA <change schema name> FROM <change db user>;
		REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA <change schema name> FROM <change db user>;
		REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA <change schema name> FROM <change db user>;
    */
    
	END IF;
END;
$$;

-- SELECT revoke_all_privileges('<change user name>');
