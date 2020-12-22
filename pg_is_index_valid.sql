-- Postgres Indexes are valid?

select indisvalid,* from pg_index where indexrelid = 'history_2'::regclass;
