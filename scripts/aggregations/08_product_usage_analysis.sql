SELECT
    p.product_name,
    COUNT(*) AS transaction_count,
    SUM(t.transaction_amount) AS total_product_transaction_volume
FROM
    sea.transactions t
INNER JOIN sea.products p ON t.product_id=p.product_id
GROUP BY
    product_name
ORDER BY
    transaction_count DESC;
