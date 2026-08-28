-- Xom Data · Bảng theo dõi khách quay lại theo thế hệ
-- Problem: https://xomdata.com/practice/hard-cohort-002
-- Solved: 2026-08-28

WITH user_activity AS (
    SELECT 
        customer_id,
        order_date,
        -- 1. Tìm ngày đặt đơn đầu tiên của mỗi khách
        MIN(order_date) OVER (PARTITION BY customer_id) AS first_order_date
    FROM orders
),
user_diff AS (
    SELECT 
        customer_id,
        strftime('%Y-%m', first_order_date) AS cohort_month,
        -- 2. Tính chính xác khoảng cách tháng giữa ngày mua và ngày đầu tiên
        (CAST(strftime('%Y', order_date) AS INT) - CAST(strftime('%Y', first_order_date) AS INT)) * 12 
        + (CAST(strftime('%m', order_date) AS INT) - CAST(strftime('%m', first_order_date) AS INT)) AS month_diff
    FROM user_activity
)
-- 3. Pivot xoay ngang thành các cột m0, m1, m2, m3
SELECT 
    cohort_month,
    COUNT(DISTINCT CASE WHEN month_diff = 0 THEN customer_id END) AS m0,
    COUNT(DISTINCT CASE WHEN month_diff = 1 THEN customer_id END) AS m1,
    COUNT(DISTINCT CASE WHEN month_diff = 2 THEN customer_id END) AS m2,
    COUNT(DISTINCT CASE WHEN month_diff = 3 THEN customer_id END) AS m3
FROM user_diff
GROUP BY cohort_month
ORDER BY cohort_month ASC;
