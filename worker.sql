\pset pager
\x

SELECT citus_version();

--SELECT * FROM pg_dist_partition;
--SELECT * FROM pg_dist_shard;
--SELECT * FROM pg_dist_placement;
--SELECT * FROM pg_dist_node_metadata;
--SELECT * FROM pg_dist_node;
--SELECT * FROM pg_dist_local_group;
--SELECT * FROM pg_dist_transaction;
--SELECT * FROM pg_dist_colocation;

--SELECT * FROM pg_stat_statements;
SELECT * FROM citus_stat_statements;
SELECT * FROM citus_shards;


SELECT citus_get_active_worker_nodes();
SELECT master_get_active_worker_nodes();
SELECT * FROM citus_worker_stat_activity;
