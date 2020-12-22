
-- name of the table to which the TOAST index belongs

SELECT r.oid::regclass
FROM pg_class r
   JOIN pg_class t ON r.reltoastrelid = t.oid
   JOIN pg_index i ON t.oid = i.indrelid
   JOIN pg_class ti ON i.indexrelid = ti.oid
WHERE ti.relname = 'pg_toast_2619_index'
  AND ti.relnamespace = 'pg_toast'::regnamespace;
