-- Xom Data · Customers silent for 90 days
-- Problem: https://xomdata.com/practice/hard-anti-001
-- Solved: 2026-08-16

SELECT 
    user_id,
    MAX(order_date) AS last_order_date,
    CAST(julianday((SELECT MAX(order_date) FROM orders)) - julianday(MAX(order_date)) AS INT) AS days_since_last
FROM orders
GROUP BY user_id
HAVING days_since_last >= 90
order by days_since_last desc, user_id;
