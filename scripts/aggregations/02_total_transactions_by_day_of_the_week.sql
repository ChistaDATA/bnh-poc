SELECT
    day_of_week,
    COUNT(*) AS transaction_count
FROM
    sea.transactions
GROUP BY
    day_of_week
ORDER BY
    transaction_count DESC;
