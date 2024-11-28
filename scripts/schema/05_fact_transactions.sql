CREATE TABLE sea.transactions
(
    __time               DateTime,
    transaction_id       UInt64,       -- Unique identifier for the transaction
    customer_id          UInt64,       -- Unique customer identifier
    customer_name        String,       -- Customer name (optional, but denormalized for fast access)
    customer_segment     String,       -- Customer segment(eg, retail, corporate)
    account_id           UInt64,       -- Unique account identifier
    account_type         String,       -- Type of the account (e.g., savings, checking, etc.)
    account_balance      Decimal64(2), -- Balance of the account at the time of transaction
    transaction_date     DateTime,     -- Timestamp of the transaction
    transaction_type     String,       -- Type of transaction (e.g., deposit, withdrawal)
    transaction_amount   Decimal64(2), -- The amount involved in the transaction
    transaction_currency String,       -- Currency of the transaction (e.g., USD, EUR)
    transaction_status   String,       -- Status of the transaction (e.g., success, failed)
    branch_id            UInt64,       -- Branch identifier where the transaction occurred
    branch_name          String,       -- Branch name for easy access
    branch_location      String,       -- Location of the branch_locations (e.g., city, state)
    employee_id          UInt64,       -- Employee identifier handling the transaction
    employee_name        String,       -- Employee name (denormalized)
    time_of_day          String,       -- Time segment of the transaction
    day_of_week          String,       -- Day of the week
    is_weekend           Bool,         -- Indicator if the transaction occurred on the weekend
    product_id           UInt64,       -- Product identifier (e.g., loan, insurance)
    -- product_name String,               -- Name of the products used for the transaction
    campaign_id          UInt64,       -- Marketing campaign or promo identifier
    -- campaign_name String,              -- Campaign or promotion name for the transaction
    region_id            UInt64,       -- Region identifier for geo-based analysis
    -- region_name String,                -- Region name
    ip_address           String,       -- Customer's IP address during the transaction (optional)
    device_type          String,       -- Device type (e.g., mobile, desktop)
    browser_type         String,       -- Browser used for web-based transactions (optional)
    geo_location         String,       -- Geographical location based on IP address
    created_at           DateTime,     -- Date and time when the record was created
    updated_at           DateTime      -- Date and time when the record was last updated
)
    ENGINE = MergeTree
        ORDER BY (transaction_type, customer_segment, customer_id, account_id) -- Assuming transaction_id is unique for ordering;
