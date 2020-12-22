-- Run SQL script on primary node

SELECT hfr.address AS replica_ip_in_hba, 
sr.client_addr AS replica_ip_in_stat, 
CASE WHEN sr.client_addr IS NULL THEN FALSE ELSE TRUE END AS is_reachable
FROM pg_hba_file_rules hfr 
LEFT JOIN pg_stat_replication sr ON hfr.address::TEXT = SUBSTRING(sr.client_addr::TEXT FROM 0 FOR POSITION('/' in sr.client_addr::TEXT))
WHERE hfr.database = '{replication}';

