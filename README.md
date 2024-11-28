# BNH Data Generation and Insertion

This project generates and inserts transaction data into a ClickHouse database.

## Prerequisites

1. **Install pre-requisites**

    1. Ensure you have Python 3.6 or higher installed on your system. You can download it from
       the [official Python website](https://www.python.org/downloads/).
       ```sh
       pip install -r requirements.txt
       ```
    2. Additionally, ensure you have ClickHouse Client installed. If you haven't installed it yet, follow the
       instructions in the [ClickHouse Installation and Configuration](docs/clickhouse-installation.md) guide. If this is a client
       machine, no need to install the `clickhouse-server` package. Also, no extra configurations are required on the package for
       using the client.

2. **Create Database and required tables**

   By running the scripts in the `schema` directory. Before running the scripts, make sure to replace the placeholders
   with the actual values and to export `CH_PASSWORD` environment variable.
    ```sh
    export CH_PASSWORD=<password>
    for file in schema/*.sql; do
        clickhouse-client --host=<host> --port=<port> --user=<user> --password=$CH_PASSWORD --query="$(< $file)"
    done
    ```

3. **Set environment variables**
    ```sh
    export NUMBER_OF_ROWS=180000000
    export BATCH_SIZE=10000
    export CH_HOST=localhost
    export CH_PORT=8123
    export CH_USER=default
    export CH_PASSWORD=<password>
    export DB_NAME=<database_name>
    export TABLE_NAME=transactions
    ```

4. **Trigger data generation script**
    ```sh
    python3 generate_transactions.py
    ```

## Environment Variables

- `NUMBER_OF_ROWS`: Number of rows to generate.
- `BATCH_SIZE`: Number of rows per batch.
- `CH_HOST`: ClickHouse host.
- `CH_PORT`: ClickHouse port.
- `CH_USER`: ClickHouse user.
- `CH_PASSWORD`: ClickHouse password.
- `DB_NAME`: Database name.
- `TABLE_NAME`: Table name.
