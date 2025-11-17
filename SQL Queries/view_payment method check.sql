CREATE OR REPLACE VIEW vw_method_performance AS

SELECT
  pm.method_type,
  COUNT(f.payment_id) AS total_txns,
  SUM(f.amount)       AS total_amount,
  ROUND( SUM(CASE WHEN f.status='Success' THEN 1 ELSE 0 END) *100.0/ NULLIF(COUNT(f.payment_id),0), 2) AS success_rate_pct,
  ROUND( SUM(CASE WHEN f.status='Failed' THEN 1 ELSE 0 END) *100.0/ NULLIF(COUNT(f.payment_id),0), 2) AS fail_rate_pct
FROM FactPayments f
JOIN DimPaymentMethod pm ON f.method_id = pm.method_id
GROUP BY pm.method_id, pm.method_type
ORDER BY total_amount DESC;
