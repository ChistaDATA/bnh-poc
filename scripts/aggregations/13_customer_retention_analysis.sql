WITH customer_transactions AS (
    SELECT
        customer_id,
        COUNT(*) AS transaction_count
    FROM
        sea.transactions
    GROUP BY
        customer_id
)
SELECT
    customer_id,
    transaction_count
FROM
    customer_transactions
WHERE
    transaction_count > 1  -- Customers with more than 1 transaction
ORDER BY
    transaction_count DESC;
