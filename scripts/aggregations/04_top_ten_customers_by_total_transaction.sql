SELECT
    customer_id,
    customer_name,
    SUM(transaction_amount) AS total_spent
FROM
    sea.transactions
WHERE
    transaction_date >= '2024-10-01' AND transaction_date < '2024-11-01'
GROUP BY
    customer_id, customer_name
ORDER BY
    total_spent DESC
LIMIT 10;
