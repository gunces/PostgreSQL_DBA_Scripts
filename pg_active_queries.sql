-- PostgreSQL Active Queries

SELECT pid,usename, query_start, NOW()-query_start, query 
FROM pg_stat_activity 
WHERE state='active';
