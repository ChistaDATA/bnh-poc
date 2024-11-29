SELECT
    branch_name,
    SUM(transaction_amount) AS total_transaction_volume
FROM
    sea.transactions
GROUP BY
    branch_name
ORDER BY
    total_transaction_volume DESC;
