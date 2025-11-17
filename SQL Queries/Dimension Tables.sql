CREATE TABLE DimCustomer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50),
    signup_date DATE,
    segment VARCHAR(50)
);

CREATE TABLE DimAccount (
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(50), -- e.g., Savings, Checking, Business
    open_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES DimCustomer(customer_id)
);

CREATE TABLE DimPaymentMethod (
    method_id INT PRIMARY KEY,
    method_type VARCHAR(50) -- e.g., CreditCard, DebitCard, PayPal, BankTransfer
);
