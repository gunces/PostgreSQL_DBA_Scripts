SELECT extract(EPOCH FROM now()-query_start::timestamp)::int as second, 
        heap_blks_total-heap_blks_scanned as blks_left,
        c.relname as relname,
        (100*heap_blks_scanned)/heap_blks_total as scanned_perc, 
        spv.pid, spv.phase, spv.heap_blks_total, 
        spv.heap_blks_scanned, 
        spv.heap_blks_vacuumed, 
        spv.index_vacuum_count, 
        spv.max_dead_tuples, 
        spv.num_dead_tuples 
FROM pg_stat_progress_vacuum spv 
  INNER JOIN pg_class c ON c.oid=spv.relid 
  INNER JOIN pg_stat_activity sa ON sa.pid=spv.pid
WHERE sa.state='active';
