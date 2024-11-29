SELECT
    toDate(transaction_date) AS day,
    COUNT(*) AS transaction_count,
    SUM(transaction_amount) AS total_transaction_volume
FROM
    sea.transactions
WHERE
    transaction_date >= now() - INTERVAL 30 DAY
GROUP BY
    day
ORDER BY
    day DESC;
