CREATE OR REPLACE VIEW vw_rolling_7d_revenue AS
SELECT
  dt,
  total_amount,
  SUM(total_amount) OVER (ORDER BY dt ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS rolling_7d_amount
FROM vw_daily_agg
ORDER BY dt;