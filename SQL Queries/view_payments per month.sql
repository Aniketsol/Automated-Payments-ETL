CREATE OR REPLACE VIEW vw_payments_per_month AS
SELECT YEAR(payment_date) AS year,
       MONTH(payment_date) AS month,
       SUM(amount) AS total_amount,
       COUNT(*) AS total_payments
FROM FactPayments
GROUP BY year, month
ORDER BY year, month;