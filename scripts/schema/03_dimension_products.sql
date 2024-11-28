CREATE TABLE sea.products
(
    product_id UInt64,                        -- Product identifier (e.g., loan, insurance)
    product_name String                      -- Name of the products used for the transaction
)
ENGINE = MergeTree
ORDER BY product_id;


INSERT INTO sea.products(product_id, product_name)
VALUES (1, 'Savings Account'),
        (2, 'Checking Account'),
        (3, 'Personal Loan'),
        (4, 'Home Loan'),
        (5, 'Credit Card'),
        (6,	'Fixed Deposit'),
        (7,	'Mutual Fund'),
        (8,	'Car Loan'),
        (9,	'Education Loan'),
        (10, 'Business Loan'),
        (11, 'Insurance (Life)'),
        (12, 'Insurance (Health)'),
        (13, 'Retirement Fund'),
        (14, 'Wealth Management Services'),
        (15, 'Term Deposit'),
        (16, 'Stock Trading Account'),
        (17, 'Gold Investment Plan'),
        (18, 'Foreign Currency Account'),
        (19, 'Mobile Banking Services'),
        (20, 'Digital Wallet')