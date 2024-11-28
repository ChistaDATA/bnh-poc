CREATE TABLE sea.regions
(
    region_id UInt64,                         -- Region identifier for geo-based analysis
    region_name String                       -- Region name
)
ENGINE = MergeTree
ORDER BY region_id;


INSERT INTO sea.regions(region_id, region_name)
VALUES (1, 'West'),
       (2, 'South'),
       (3, 'East'),
       (4, 'West');