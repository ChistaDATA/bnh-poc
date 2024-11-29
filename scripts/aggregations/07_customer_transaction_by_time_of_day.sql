SELECT
    time_of_day,
    COUNT(*) AS transaction_count,
    SUM(transaction_amount) AS total_transaction_volume
FROM
    sea.transactions
GROUP BY
    time_of_day
ORDER BY
    transaction_count DESC;
