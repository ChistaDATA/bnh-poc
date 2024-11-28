SELECT count(*) FROM sea.transactions;

-----------
SELECT
    database,
    table,
    formatReadableSize(sum(data_compressed_bytes) AS size) AS compressed,
    formatReadableSize(sum(data_uncompressed_bytes) AS usize) AS uncompressed,
    round(usize / size, 2) AS compr_rate,
    sum(rows) AS rows,
    count() AS part_count
FROM clusterAllReplicas(default, system, parts)
WHERE (active = 1) AND (database = 'sea') AND (table = 'transactions')
GROUP BY
    database,
    table
ORDER BY size DESC;

/*
 database	sea
table	transactions
compressed	1.43 GiB
uncompressed	2.71 GiB
compr_rate	1.9
rows	10000000 (10 Million)
part_count	7

 */
SELECT
    name,
    path,
    formatReadableSize(free_space) AS free,
    formatReadableSize(total_space) AS total,
    formatReadableSize(keep_free_space) AS reserved
FROM system.disks

-------------

