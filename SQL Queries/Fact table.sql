CREATE TABLE FactPayments (
    payment_id INT PRIMARY KEY,
    account_id INT,
    method_id INT,
    customer_id INT,
    payment_date DATE,
    amount DECIMAL(12,2),
    currency VARCHAR(10),
    status VARCHAR(20),
    FOREIGN KEY (account_id) REFERENCES DimAccount(account_id),
    FOREIGN KEY (method_id) REFERENCES DimPaymentMethod(method_id),
    FOREIGN KEY (customer_id) REFERENCES DimCustomer(customer_id)
);
