-- PostgreSQL ALTER TABLE autovacuum settings

ALTER TABLE history SET (autovacuum_vacuum_scale_factor = 0, autovacuum_vacuum_threshold = 10000000);
ALTER TABLE history RESET (autovacuum_vacuum_scale_factor,autovacuum_vacuum_threshold);
