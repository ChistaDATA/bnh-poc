SELECT
    t.__time,
    t.transaction_id,
    t.customer_id,
    t.customer_name,
    t.customer_segment,
    t.account_id,
    t.account_type,
    t.account_balance,
    t.transaction_date,
    t.transaction_type,
    t.transaction_amount,
    t.transaction_currency,
    t.transaction_status,
    t.branch_id,
    t.branch_name,
    t.branch_location,
    t.employee_id,
    t.employee_name,
    t.time_of_day,
    t.day_of_week,
    t.is_weekend,
    t.product_id AS product_id,
    p.product_name AS product_name,
    t.campaign_id AS campaitn_id,
    c.campaign_name AS campaign_name,
    t.region_id AS region_id,
    r.region_name AS region_name,
    t.ip_address,
    t.device_type,
    t.browser_type,
    t.geo_location,
    t.created_at,
    t.updated_at
FROM sea.transactions t
INNER JOIN sea.products p ON t.product_id=p.product_id
INNER JOIN sea.campaigns c ON t.campaign_id=c.campaign_id
INNER JOIN sea.regions r ON t.region_id=r.region_id
WHERE t.__time >= '2024-10-01' AND t.__time <= '2024-10-31'
