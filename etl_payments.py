import mysql.connector
from faker import Faker
import random
from datetime import datetime, timedelta

fake = Faker()

def run_etl():
    # -------------------------
    # Connect to MySQL
    # -------------------------
    conn = mysql.connector.connect(
    host='localhost',
    user='ba_user',
    password='YourPassword123',
    database='payments_analytics'
)
    cursor = conn.cursor()

     # -------------------------
    # 1. Insert Customers if empty
    # -------------------------
    cursor.execute("SELECT COUNT(*) FROM DimCustomer")
    if cursor.fetchone()[0] == 0:
        customers = [(i,
                      fake.name(),
                      fake.city(),
                      fake.date_between('-3y', 'today'),
                      random.choice(['Regular','VIP'])) for i in range(1, 5001)]
        cursor.executemany(
            "INSERT INTO DimCustomer (customer_id, name, city, signup_date, segment) VALUES (%s,%s,%s,%s,%s)",
            customers
        )
        conn.commit()
        print("Inserted 5000 Customers")

    # -------------------------
    # 2. Insert Accounts if empty
    # -------------------------
    cursor.execute("SELECT COUNT(*) FROM DimAccount")
    if cursor.fetchone()[0] == 0:
        accounts = []
        account_id = 1
        for customer_id in range(1,5001):
            num_accounts = random.choice([1,1,1,2])
            for _ in range(num_accounts):
                accounts.append((
                    account_id,
                    customer_id,
                    random.choice(['Savings','Checking','Business']),
                    fake.date_between('-3y','today'),
                    random.choice(['Active','Closed'])
                ))
                account_id += 1
        cursor.executemany(
            "INSERT INTO DimAccount (account_id, customer_id, account_type, open_date, status) VALUES (%s,%s,%s,%s,%s)",
            accounts
        )
        conn.commit()
        print(f"Inserted {len(accounts)} Accounts")

    # -------------------------
    # 3. Insert Payment Methods if empty
    # -------------------------
    cursor.execute("SELECT COUNT(*) FROM DimPaymentMethod")
    if cursor.fetchone()[0] == 0:
        payment_methods = [
            (1,'CreditCard'),
            (2,'DebitCard'),
            (3,'PayPal'),
            (4,'BankTransfer'),
            (5,'ApplePay')
        ]
        cursor.executemany(
            "INSERT INTO DimPaymentMethod (method_id, method_type) VALUES (%s,%s)",
            payment_methods
        )
        conn.commit()
        print("Inserted Payment Methods")

    # -------------------------
    # 4. Generate new payments incrementally
    # -------------------------
    cursor.execute("SELECT MAX(payment_id) FROM FactPayments")
    last_payment_id = cursor.fetchone()[0] or 0

    payments = []
    for i in range(1, 1001):  # generate 1000 new payments per run
        customer_id = random.randint(1,5000)
        cursor.execute("SELECT account_id FROM DimAccount WHERE customer_id=%s", (customer_id,))
        customer_accounts = [row[0] for row in cursor.fetchall()]
        account_id = random.choice(customer_accounts)
        method_id = random.randint(1,5)
        payment_date = fake.date_between('-2y','today')
        amount = round(random.uniform(10,2000),2)
        status = random.choices(['Success','Failed','Pending'], weights=[85,10,5])[0]

        payments.append((
            last_payment_id + i,
            account_id,
            method_id,
            customer_id,
            payment_date,
            amount,
            'AUD',
            status
        ))

    # Batch insert
    batch_size = 500
    for i in range(0, len(payments), batch_size):
        batch = payments[i:i+batch_size]
        cursor.executemany(
            "INSERT INTO FactPayments (payment_id, account_id, method_id, customer_id, payment_date, amount, currency, status) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)",
            batch
        )
        conn.commit()
        start_id = batch[0][0]
        end_id = batch[-1][0]
        print(f"Inserted payments {start_id} to {end_id}")

    print("ETL run completed successfully!")
    conn.close()

if __name__ == "__main__":
    run_etl()
