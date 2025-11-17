CREATE OR REPLACE VIEW cohort_retention AS
WITH cohorts AS (
  SELECT
    c.customer_id,
    DATE_FORMAT(c.signup_date, '%Y-%m') AS cohort_month
  FROM DimCustomer c
),
activity AS (
  SELECT
    f.customer_id,
    DATE_FORMAT(f.payment_date, '%Y-%m') AS activity_month
  FROM FactPayments f
)
SELECT
  cohort_month,
  activity_month,
  COUNT(DISTINCT a.customer_id) AS active_customers
FROM cohorts co
JOIN activity a ON co.customer_id = a.customer_id
GROUP BY cohort_month, activity_month
ORDER BY cohort_month, activity_month;
