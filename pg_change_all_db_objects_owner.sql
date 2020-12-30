/*
Postgres change all db objects owner

PS: This function is not completed yet. All database object's owner should change with this function. (TABLE, SEQUENCE, VIEW, MV, INDEXES, FUNCTION, SP and all FDW objects) 

This function required because of inapropriate given privileges. 
For instance some objects creates with regular user but aproper approach is that creating db objects with application user, not others. 
*/

############ #############
CREATE OR REPLACE FUNCTION dbf_alter_relations_owner(
	f_username text)
    RETURNS void
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
AS $BODY$
DECLARE
schemanames TEXT;
rec_schemas RECORD;
rec_tables RECORD;

BEGIN

	SELECT string_agg(distinct schemaname, ',') INTO schemanames
			  FROM pg_catalog.pg_tables
			 WHERE schemaname != 'pg_catalog'
			   AND schemaname != 'information_schema';  
	RAISE NOTICE 'All schemas: %', schemanames;		
		
	IF EXISTS(SELECT rolname FROM pg_catalog.pg_roles WHERE rolname=f_username) THEN 
		EXECUTE 'GRANT USAGE ON SCHEMA '|| schemanames || ' TO ' || f_username;
		RAISE NOTICE 'GRANT USAGE ON SCHEMA % TO %', schemanames, f_username;
		
		FOR rec_schemas IN SELECT distinct pgt.schemaname as schemaname
			  FROM pg_catalog.pg_tables pgt
			 WHERE pgt.schemaname != 'pg_catalog'
			   AND pgt.schemaname != 'information_schema'
		LOOP 
			EXECUTE 'GRANT SELECT ON ALL SEQUENCES IN SCHEMA '|| rec_schemas.schemaname || ' TO ' || f_username;
			RAISE NOTICE 'GRANT SELECT ON ALL SEQUENCES IN SCHEMA % TO %', schemanames, f_username;
			
			EXECUTE 'ALTER SCHEMA "'|| rec_schemas.schemaname || '" OWNER TO ' || f_username;
			RAISE NOTICE 'ALTER SCHEMA % OWNER TO %', rec_schemas, f_username;
		
			FOR rec_tables in SELECT pgt.schemaname || '."' || pgt.tablename ||'"' as tablename
			  FROM pg_catalog.pg_tables as pgt
			 WHERE pgt.schemaname = rec_schemas.schemaname
			LOOP
				EXECUTE 'ALTER TABLE ' ||  rec_tables.tablename || ' owner to ' || f_username;
				RAISE NOTICE 'ALTER TABLE  % OWNER TO %', rec_tables.tablename, f_username;
			END LOOP;
		END LOOP;
		
	ELSE 
	
		RAISE NOTICE '% user doesn''t exists. Exit.', f_username;
	
	END IF;
	
END;
$BODY$;

ALTER FUNCTION dbf_alter_relations_owner(text)
    OWNER TO postgres;
