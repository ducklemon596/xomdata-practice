-- Xom Data · Multi-level profit margin analysis
-- Problem: https://xomdata.com/practice/hard-multicte-001
-- Solved: 2026-08-12

WITH product_metrics AS (
    SELECT 
        p.id,
        p.category,
        p.name AS product_name,
        SUM(o.quantity * o.price) AS revenue,
        SUM(o.quantity * p.unit_cost) AS cost,
        SUM(o.quantity * (o.price - p.unit_cost)) AS profit
    FROM products p
    JOIN orders o ON p.id = o.product_id
    GROUP BY p.id, p.name, p.category
)
SELECT 
    category,
    product_name,
    revenue,
    cost,
    profit,
    ROUND(profit * 100.0 / revenue, 2) AS margin_pct,
    DENSE_RANK() OVER (
        PARTITION BY category 
        ORDER BY profit DESC
    ) AS rank_in_cat,
    ROUND(profit * 100.0 / MAX(profit) OVER (PARTITION BY category), 2) AS pct_of_top_in_cat
FROM product_metrics
ORDER BY 
    category ASC,
    rank_in_cat ASC,
    product_name ASC;
