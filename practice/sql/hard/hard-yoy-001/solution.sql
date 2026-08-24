-- Xom Data · YoY and QoQ sales growth
-- Problem: https://xomdata.com/practice/hard-yoy-001
-- Solved: 2026-08-24

with cte as (
    select year, quarter, revenue, 
            lag(revenue) over (order by year, quarter) as prev_quarter_revenue,
            lag(revenue, 4) over (order by year, quarter) as prev_year_revenue
    from quarterly_sales
)

select *,
        round(revenue * 100.0 / prev_quarter_revenue - 100.0, 2) as qoq_pct,
        round(revenue * 100.0 / prev_year_revenue - 100.0, 2) as yoy_pct
from cte
order by year, quarter;
