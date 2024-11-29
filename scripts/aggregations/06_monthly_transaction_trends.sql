SELECT
    toStartOfMonth(transaction_date) AS month,
    COUNT(*) AS transaction_count,
    SUM(transaction_amount) AS total_transaction_volume
FROM
    sea.transactions
GROUP BY
    month
ORDER BY
    month DESC;
