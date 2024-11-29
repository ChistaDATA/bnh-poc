SELECT
    branch_name,
    AVG(transaction_amount) AS avg_transaction_amount
FROM
    sea.transactions
GROUP BY
    branch_name
ORDER BY
    avg_transaction_amount DESC
LIMIT 10;
