--r = ordinary table, i = index, S = sequence, v = view, m = materialized view, c = composite type, t = TOAST table, f = foreign table
SELECT 
    n.nspname AS schema_name,
    c.relname AS rel_name,
    c.relkind AS rel_kind,
    pg_get_userbyid(c.relowner) AS owner_name
  FROM pg_class c
  JOIN pg_namespace n ON n.oid = c.relnamespace

UNION ALL

-- functions (or procedures)
SELECT
    n.nspname AS schema_name,
    p.proname,
    'p',
    pg_get_userbyid(p.proowner)
  FROM pg_proc p
  JOIN pg_namespace n ON n.oid = p.pronamespace;
