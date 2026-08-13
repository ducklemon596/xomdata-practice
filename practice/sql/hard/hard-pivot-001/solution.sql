-- Xom Data · Revenue pivoted by product type
-- Problem: https://xomdata.com/practice/hard-pivot-001
-- Solved: 2026-08-13

SELECT 
    strftime('%Y-%m', sale_date) AS month,
    COALESCE(SUM(CASE WHEN category = 'Electronics' THEN amount END), 0) AS electronics,
    COALESCE(SUM(CASE WHEN category = 'Clothing' THEN amount END), 0) AS clothing,
    COALESCE(SUM(CASE WHEN category = 'Food' THEN amount END), 0) AS food,
    COALESCE(SUM(amount), 0) AS total
FROM sales
GROUP BY month
ORDER BY month ASC;
