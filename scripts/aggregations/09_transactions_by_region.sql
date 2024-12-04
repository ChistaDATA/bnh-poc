SELECT
    r.region_name,
    COUNT(*) AS transaction_count,
    SUM(transaction_amount) AS total_transaction_volume
FROM
    sea.transactions t
  INNER JOIN sea.regions r ON t.region_id=r.region_id
GROUP BY
    region_name
ORDER BY
    total_transaction_volume DESC;
