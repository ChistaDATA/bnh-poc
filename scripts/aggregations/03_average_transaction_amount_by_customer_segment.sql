SELECT
    customer_segment,
    AVG(transaction_amount) AS avg_transaction_amount
FROM
    sea.transactions
GROUP BY
    customer_segment
ORDER BY
    avg_transaction_amount DESC;