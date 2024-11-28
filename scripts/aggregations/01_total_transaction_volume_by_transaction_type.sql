SELECT
    transaction_type,
    SUM(transaction_amount) AS total_transaction_volume
FROM
    sea.transactions
GROUP BY
    transaction_type
ORDER BY
    total_transaction_volume DESC;

