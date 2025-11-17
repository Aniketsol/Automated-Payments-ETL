WITH first_purchase AS (
  SELECT customer_id,MIN(payment_date) AS first_dt
  FROM FactPayments
  GROUP BY customer_id
),
within_30 AS (
  SELECT f.customer_id, SUM(f.amount) AS spend_30d
  FROM FactPayments f
  JOIN first_purchase fp ON f.customer_id = fp.customer_id
  WHERE f.payment_date BETWEEN fp.first_dt AND DATE_ADD(fp.first_dt, INTERVAL 30 DAY)
  GROUP BY f.customer_id
)
SELECT customer_id, spend_30d
FROM within_30
WHERE spend_30d > 1000
ORDER BY spend_30d DESC;
