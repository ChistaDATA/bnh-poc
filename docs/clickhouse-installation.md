## ClickHouse Installation and Configuration

### Pre-requisites

#### Recommended Hardware

- CPU: 8+ cores
- RAM: 32+ GB
- Disk: SSD with high IOPS

### Installation

1. **Add the ClickHouse repository:**
    ```shell
    sudo rpm --import https://chistadata-yum.s3.us-east-1.amazonaws.com/public.gpg
    sudo tee /etc/yum.repos.d/clickhouse.repo <<EOL
    [ChistaDATA-ClickHouse24]
    name=ChistaDATA ClickHouse24 YUM Repository
    baseurl=https://chistadata-yum.s3.us-east-1.amazonaws.com/clickhouse-24/
    enabled=1
    gpgcheck=1
    gpgkey=https://chistadata-yum.s3.us-east-1.amazonaws.com/public.gpg
    EOL
    sudo yum update
    ```

2. **Install ClickHouse:**
    ```shell
    sudo yum install clickhouse-server clickhouse-client
    ```

3. **Start the ClickHouse server:**
    ```shell
    sudo service clickhouse-server start
    ```
### Configuring the Service to Auto Restart on Red Hat

To configure the ClickHouse service to automatically restart on failure, you can use the `systemctl` command to modify the service configuration.

1. **Create a systemd override file for the ClickHouse service:**
    ```shell
    sudo systemctl edit clickhouse-server
    ```

2. **Add the following configuration to the override file:**
    ```ini
    [Service]
    Restart=always
    RestartSec=5
    ```

3. **Reload the systemd daemon to apply the changes:**
    ```shell
    sudo systemctl daemon-reload
    ```

4. **Restart the ClickHouse service:**
    ```shell
    sudo systemctl restart clickhouse-server
    ```

This configuration ensures that the ClickHouse service will automatically restart 5 seconds after a failure.


### Connecting to ClickHouse

If you require to enable TLS connections you will need to configure DNS and SSL certificates. Contact the ChistaDATA
team for documentation.

1. **Using the ClickHouse client executable:**
    - Connect to the ClickHouse server using the `clickhouse-client` command:
      ```shell
      clickhouse-client --host <host> --port <port> --user <user> --password <password>
      ```

2. **Using the ClickHouse web interface:**
    - Open a web browser and navigate to `http://<host>:8123/play`.
    - Log in with your ClickHouse credentials.



### Configuration

1. **Edit the configuration file:**
    - The main configuration file is located at `/etc/clickhouse-server/config.xml`.

2. **Common configurations:**
    - **Network settings:**
        ```xml
        <listen_host>0.0.0.0</listen_host>
        <port>9000</port>
        <http_port>8123</http_port>
        ```

    - **Storage settings:**
        
        This is the default storage configuration. You can modify it based on your requirements and disk configuration.
        ```xml
        <path>/var/lib/clickhouse/</path>
        ```

    - **Setting Password Using SHA-256**

        To generate a SHA-256 hash of your password, you can use the following command in the terminal:
        ```shell
        echo -n 'your_password' | sha256sum | awk '{print $1}'
        ```

        To set the password using a SHA-256 hash, you can modify the configuration to use the `password_sha256_hex` attribute
        instead of `password`. Here is how you can do it:

        ```xml
        <users>
            <default>
                <password_sha256_hex>your_sha256_hashed_password</password_sha256_hex>
                <networks>
                    <ip>::/0</ip>
                </networks>
            </default>
        </users>
        ```

        **Note**: if you don't want to secure your password (non production environment) you can use the following attribute instead of `<password_sha256_hex>`:
        ```xml
        <password>your_password</password>
        ```

### Logging (optional for non production environments)

1. **Enable logging to ClickHouse tables:**
    - Modify the `config.xml` file to include the following logging configuration:
        ```xml
        <clickhouse>
           <query_log replace="1">
               <level>debug</level>
               <database>system</database>
               <table>query_log</table>
               <flush_interval_milliseconds>7500</flush_interval_milliseconds>
               <ttl>event_date + INTERVAL 30 DAY DELETE</ttl>
           </query_log>
           <asynchronous_metric_log replace="1">
               <level>debug</level>
               <database>system</database>
               <table>asynchronous_metric_log</table>
               <flush_interval_milliseconds>7500</flush_interval_milliseconds>
               <ttl>event_date + INTERVAL 30 DAY DELETE</ttl>
           </asynchronous_metric_log>
        </clickhouse>
        ```

2. **Create the necessary tables:**
    - Use the ClickHouse client to create the logging tables:
       ```sql
       CREATE TABLE query_log (
        `type` Enum8('QueryStart' = 1, 'QueryFinish' = 2, 'ExceptionBeforeStart' = 3, 'ExceptionWhileProcessing' = 4),
        `event_date` Date,
        `event_time` DateTime,
        `event_time_microseconds` DateTime64(6),
        `query_start_time` DateTime,
        `query_start_time_microseconds` DateTime64(6),
        `query_duration_ms` UInt64,
        `read_rows` UInt64,
        `read_bytes` UInt64,
        `written_rows` UInt64,
        `written_bytes` UInt64,
        `result_rows` UInt64,
        `result_bytes` UInt64,
        `memory_usage` UInt64,
        `current_database` String,
        `query` String,
        `formatted_query` String,
        `normalized_query_hash` UInt64,
        `query_kind` LowCardinality(String),
        `databases` Array(LowCardinality(String)),
        `tables` Array(LowCardinality(String)),
        `columns` Array(LowCardinality(String)),
        `projections` Array(LowCardinality(String)),
        `views` Array(LowCardinality(String)),
        `exception_code` Int32,
        `exception` String,
        `stack_trace` String,
        `is_initial_query` UInt8,
        `user` String,
        `query_id` String,
        `address` IPv6,
        `port` UInt16,
        `initial_user` String,
        `initial_query_id` String,
        `initial_address` IPv6,
        `initial_port` UInt16,
        `initial_query_start_time` DateTime,
        `initial_query_start_time_microseconds` DateTime64(6),
        `interface` UInt8,
        `is_secure` UInt8,
        `os_user` String,
        `client_hostname` String,
        `client_name` String,
        `client_revision` UInt32,
        `client_version_major` UInt32,
        `client_version_minor` UInt32,
        `client_version_patch` UInt32,
        `http_method` UInt8,
        `http_user_agent` String,
        `http_referer` String,
        `forwarded_for` String,
        `quota_key` String,
        `distributed_depth` UInt64,
        `revision` UInt32,
        `log_comment` String,
        `thread_ids` Array(UInt64),
        `ProfileEvents` Map(String, UInt64),
        `Settings` Map(String, String),
        `used_aggregate_functions` Array(String),
        `used_aggregate_function_combinators` Array(String),
        `used_database_engines` Array(String),
        `used_data_type_families` Array(String),
        `used_dictionaries` Array(String),
        `used_formats` Array(String),
        `used_functions` Array(String),
        `used_storages` Array(String),
        `used_table_functions` Array(String),
        `transaction_id` Tuple(UInt64, UInt64, UUID)
       ) ENGINE = MergeTree PARTITION BY toYYYYMM(event_date) ORDER BY (event_date, event_time) SETTINGS index_granularity = 8192;
       ```
       ```sql
       CREATE TABLE asynchronous_metric_log
       (
         `ch_event_time` DateTime,
         `metric` String,
         `value` Float64,
         `description` String,
         `cluster_id` Int32 NOT NULL,
         `node_id` Int32 NOT NULL
       ) ENGINE = MergeTree PARTITION BY toYYYYMM(ch_event_time) ORDER BY (ch_event_time);
       ```

3. **Restart the ClickHouse server:**
    ```shell
    sudo service clickhouse-server restart

This document provides a brief overview of installing ClickHouse, configuring it, setting up logging to ClickHouse
tables, and connecting to ClickHouse. For more detailed information, get in touch with the ChistaDATA team so they can
help you.
