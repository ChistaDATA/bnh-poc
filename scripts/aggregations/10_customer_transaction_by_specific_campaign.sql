SELECT
    c.campaign_name,
    COUNT(*) AS campaign_transaction_count,
    SUM(transaction_amount) AS total_campaign_transaction_volume
FROM
    sea.transactions t
  INNER JOIN sea.campaigns c ON t.campaign_id=c.campaign_id
WHERE
    campaign_id = 3
GROUP BY
    campaign_name
ORDER BY
    total_campaign_transaction_volume DESC;
