-- Xom Data · 7-day moving average of revenue
-- Problem: https://xomdata.com/practice/hard-frame-001
-- Solved: 2026-08-21

select date, amount as revenue,
        round(avg(amount) over (order by date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) as ma7
from daily_revenue
