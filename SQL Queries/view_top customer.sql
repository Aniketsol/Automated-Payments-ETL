CREATE OR REPLACE VIEW vw_top_customers AS
SELECT c.name, SUM(f.amount) AS total_paid, COUNT(f.payment_id) AS num_payments
FROM FactPayments f
JOIN DimCustomer c ON f.customer_id = c.customer_id
GROUP BY c.name
ORDER BY total_paid DESC
LIMIT 10;