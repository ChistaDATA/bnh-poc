SELECT
    transaction_id,
    transaction_date,
    transaction_type,
    transaction_amount,
    transaction_status,
    branch_name
FROM
    sea.transactions
WHERE
    customer_id = 1000
ORDER BY
    transaction_date DESC;
