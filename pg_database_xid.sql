-- postgres database xid

SELECT datname
    , age(datfrozenxid)
    , current_setting('autovacuum_freeze_max_age') 
FROM pg_database 
ORDER BY 2 DESC;
