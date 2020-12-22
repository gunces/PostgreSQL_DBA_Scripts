-- PostgreSQL list user privileges
SELECT grantor, grantee, table_schema, table_name, privilege_type
FROM information_schema.table_privileges
WHERE grantee = '<user name>';
