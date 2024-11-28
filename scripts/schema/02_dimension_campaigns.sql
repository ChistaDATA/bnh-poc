CREATE TABLE sea.campaigns
(
    campaign_id UInt64,                       -- Marketing campaign or promo identifier
    campaign_name String,                     -- Campaign or promotion name for the transaction
    start_date Date,
    end_date Date,
    campaign_type String,
    target_audience String
)
ENGINE = MergeTree
ORDER BY campaign_id;


INSERT INTO sea.campaigns(campaign_id, campaign_name, start_date, end_date, campaign_type, target_audience) VALUES
(1, 'New Year Savings Bonus', '2024-01-01', '2024-01-31', 'Bonus', 'Existing Customers'),
(2, 'Low Interest Home Loan Offer', '2024-03-01', '2024-06-30', 'Loan Promotion', 'Homebuyers'),
(3, 'Credit Card Cashback Promotion', '2024-04-01', '2024-04-30', 'Cashback', 'New Credit Card Holders'),
(4, 'Back-to-School Education Loan', '2024-07-01', '2024-08-31', 'Loan Promotion', 'Students & Parents'),
(5, 'Summer Savings Account Rate', '2024-06-01', '2024-08-31', 'Interest Rate Boost', 'All Customers'),
(6, 'Business Loan Expansion Discount', '2024-05-01', '2024-05-31', 'Loan Discount', 'Small Businesses'),
(7, 'Retirement Plan Enrollment Drive', '2024-04-01', '2024-06-30', 'Retirement Offer', 'Employees Over 40'),
(8, 'Gold Investment Plan Special', '2024-03-01', '2024-03-31', 'Investment Promotion', 'High Net-Worth Individuals'),
(9, 'Refer a Friend - Get $50', '2024-02-01', '2024-04-30', 'Referral', 'Existing Customers'),
(10, 'Black Friday Shopping Credit Card', '2024-11-01', '2024-11-30', 'Seasonal Promotion', 'All Customers'),
(11, 'Mobile Banking App Sign-Up Bonus', '2024-01-01', '2024-03-31', 'App Promotion', 'Tech-Savvy Customers'),
(12, 'Loyalty Reward for Long-Term Clients', '2024-05-01', '2024-05-31', 'Loyalty Program', 'Customers Over 5 Years'),
(13, 'Summer Auto Loan Discount', '2024-06-01', '2024-06-30', 'Loan Discount', 'Car Buyers'),
(14, 'Holiday Season Savings Match', '2024-12-01', '2024-12-31', 'Bonus', 'All Customers'),
(15, 'Exclusive Wealth Management Offer', '2024-04-01', '2024-04-30', 'Exclusive Offer', 'High Net-Worth Individuals');

