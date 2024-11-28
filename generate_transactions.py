import string
import clickhouse_connect
import random
import os
from datetime import datetime, timedelta
from dotenv import load_dotenv


def read_list(list_file_name):
    """
      Read file and return the items as a python list
    :param list_file_name:
    :return:
    """
    data = []
    with open('./data/{}'.format(list_file_name)) as f:
        data = f.read().splitlines()
    return data


column_names = read_list('column_names')
account_type = read_list('account_type')
branch_locations = read_list('branch_locations')


start_date = datetime(2023, 1, 1)
end_date = datetime(2024, 11, 1)


def get_dimensions_from_db(ch_client, db_name, table_name):
    """
      Get data from clickhouse table and return as list of tuples
    :param ch_client:
    :param db_name:
    :param table_name:
    :return:
    """
    # Query the ClickHouse table
    query = 'SELECT * FROM {}.{} LIMIT 10'.format(db_name, table_name)
    result = ch_client.query(query)

    # Fetch and display the results
    data = result.result_rows  # Rows as a list of tuples
    return data


def get_data(data_type='String', string_value='', int_start=0, int_end=999999999, list_name='', prefix=''):
    """

    :param data_type:
    :param string_value:
    :param int_start:
    :param int_end:
    :param list_name:
    :param prefix:
    :return:
    """
    return_value = None
    if data_type.upper() == 'STRING':
        if string_value:
            return_value = string_value

    if data_type.upper() == 'STRINGFROMLIST':
        return_value = random.choice(globals()[list_name])

    if data_type.upper() == 'RANDOMSTRING':
        return_value = random_string(prefix)

    if data_type.upper() == 'INTEGER':
        return_value = random.randint(int_start, int_end)

    if data_type.upper() == 'DATETIME':
        return_value = random_date(start_date, end_date)

    if data_type.upper() == "DECIMAL":
        # return_value = float(Decimal(random.choice(globals()[list_name])))
        return_value = float(random.choice(globals()[list_name]))

    if data_type.upper() == 'TUPLE':
        return_value = random.choice(globals()[list_name])

    return return_value


def random_string(prefix, length=100):
    random_length = random.randint(0, 100)
    letters = string.ascii_letters + string.digits
    if random_length < 20 and prefix != '':
        return prefix.join(random.choice(letters) for i in range(random_length))
    return ''.join(random.choice(letters) for i in range(random_length))


def get_random_string(prefix='', length=10):
    string_value = ''.join(random.choices(string.ascii_letters + string.digits, k=length))
    if prefix:
        string_value = '{}{}'.format(prefix, string_value)
    return string_value


def random_date(start, end):
    delta = end - start
    random_seconds = random.randint(0, int(delta.total_seconds()) * 1000)
    return start + timedelta(milliseconds=random_seconds)


def random_uint64():
    return random.randint(0, 2 ** 64 - 1)


def random_time_of_day(hour):
    if hour < 6:
        return "Early Morning"
    elif 6 <= hour < 12:
        return "Morning"
    elif 12 <= hour < 18:
        return "Afternoon"
    else:
        return "Evening"


def generate_columns(exec_time):
    """
      Generate data column values and return as list
    :param exec_time:
    :return:
    """
    single_row = []
    transaction_date = random_date(start_date, end_date)
    day_of_week = transaction_date.strftime('%A')
    hour = transaction_date.hour
    is_weekend = day_of_week in ['Saturday', 'Sunday']

    single_row.append(exec_time)  # __time
    single_row.append(random_uint64())  # transaction_id
    single_row.append(random.randint(min_customer_count, max_customer_count))  # customer_id

    # single_row.append(get_data(data_type='RandomString', prefix='CUSTOMER '))  # customer_name
    single_row.append(get_random_string('Customer-', length=20))
    single_row.append(random.choice(['retail', 'corporate']))  # transaction_status

    single_row.append(random.randint(min_account_count, max_account_count))  # account_id
    single_row.append(get_data(data_type='StringFromList', list_name='account_type'))  # account_type
    account_balance = round(random.uniform(1000, 1000000), 4)
    single_row.append(account_balance)  # account_balance
    single_row.append(transaction_date)  # transaction_date
    transaction_type = random.choice(['deposit', 'withdrawal'])
    single_row.append(transaction_type)   # transaction_type

    transaction_amount = round(random.uniform(10, 10000), 4)
    if transaction_type == 'withdrawal':
        transaction_amount = account_balance - random.randint(1, 100)

    single_row.append(transaction_amount)  # transaction_amount
    single_row.append(random.choice(['USD', 'EUR', 'INR']))  # transaction_currency
    single_row.append(random.choice(['success', 'failed']))  # transaction_status

    branch = '{}-{}_{}'.format('Branch', get_random_string(length=8), random.randint(1, 100))

    single_row.append(branch.split('_')[1])  # branch_id
    single_row.append(branch)  # branch_name

    single_row.append(get_data(data_type='StringFromList', list_name='branch_locations'))  # branch_location

    # employee = get_random_string('Employee ', length=20)
    employee = '{}{}_{}'.format('Employee ', get_random_string(length=20), random.randint(1, 500))
    single_row.append(employee.split('_')[1])  # employee_id
    single_row.append(employee)  # employee_name

    single_row.append(random_time_of_day(hour))  # time_of_day
    single_row.append(day_of_week)  # day_of_week
    single_row.append(is_weekend)  # is_weekend

    product = random.choice(product_list)
    single_row.append(product[0])  # product_id

    campaign = random.choice(campaign_list)
    single_row.append(campaign[0])  # campaign_id

    region = random.choice(region_list)
    single_row.append(region[0])  # region_id

    single_row.append('.'.join(map(str, (random.randint(0, 255) for _ in range(4)))))  # ip_address
    single_row.append(random.choice(['mobile', 'desktop', 'tablet']))  # device_type
    single_row.append(random.choice(['Chrome', 'Firefox', 'Safari']))  # browser_type
    single_row.append(random.choice(['USA', 'UK', 'India', 'Japan']))  # geo_location
    single_row.append(transaction_date)  # created_at
    single_row.append(transaction_date)  # transaction_date
    return single_row


def generate_data(num_rows, batch_exec_time):
    """
      Generate rows based on the batch size
    :param num_rows:
    :param batch_exec_time:
    :return:
    """
    data = []
    for _ in range(0, num_rows):
        row = generate_columns(batch_exec_time)
        data.append(tuple(row))
    return data


# Create a secure connection to ClickHouse
def connect_to_clickhouse(host, port, user, password, secure_conn=True):
    ch_client = clickhouse_connect.get_client(
        host=host,
        port=port,
        username=user,
        password=password,
        secure=secure_conn  # Enable SSL/TLS
    )
    return ch_client


def insert_data(ch_client, database_name, table_name, data):
    """
      Insert data to ClickHouse
    :param ch_client:
    :param database_name:
    :param table_name:
    :param data:
    :return:
    """
    try:
        ch_client.insert(table_name, data, column_names=column_names, database=database_name,
                         settings={'async_insert': 1})
    except Exception as ex:
        print(str(ex))


if __name__ == "__main__":

    load_dotenv()

    number_of_rows = os.getenv('NUMBER_OF_ROWS')
    batch_size = os.getenv('BATCH_SIZE')
    ch_host = os.getenv('CH_HOST')
    ch_port = os.getenv('CH_PORT')
    ch_user = os.getenv('CH_USER')
    ch_password = os.getenv('CH_PASSWORD')
    database = os.getenv('DB_NAME')
    table = os.getenv('TABLE_NAME')

    min_customer_count = 1000
    max_customer_count = 2000
    min_account_count = 1000
    max_account_count = 2000

    print(f'{datetime.now()}: Connecting to ClickHouse...')

    client = connect_to_clickhouse(host=ch_host, port=ch_port, user=ch_user, password=ch_password, secure_conn=False)
    print(f'{datetime.now()}: Connected to ClickHouse...')

    # Get product details
    product_list = get_dimensions_from_db(ch_client=client, db_name=database, table_name='products')
    campaign_list = get_dimensions_from_db(ch_client=client, db_name=database, table_name='campaigns')
    region_list = get_dimensions_from_db(ch_client=client, db_name=database, table_name='regions')

    for start_row in range(0, int(number_of_rows), int(batch_size)):
        exec_time = get_data(data_type='DateTime', list_name='__time')
        start_time = datetime.now()
        batch_data = generate_data(min(int(batch_size), int(number_of_rows) - start_row), exec_time)

        generate_time = datetime.now()
        insert_data(client, database_name=database, table_name=table, data=batch_data)
        end_time = datetime.now()

        print(f"{start_time}: time to generate: {generate_time - start_time} - time to insert: {end_time - generate_time} | Processed rows {start_row} to {start_row + len(batch_data) - 1}")

    client.close()
