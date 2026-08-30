-- Xom Data · Người mới và người quen mỗi tháng
-- Problem: https://xomdata.com/practice/hard-cohort-003
-- Solved: 2026-08-30

with cte as (
    select distinct customer_id, 
            strftime('%Y-%m', order_date) as order_month,
            min(strftime('%Y-%m', order_date)) over (partition by customer_id order by strftime('%Y-%m', order_date)) as reg_month
    from orders
)

select order_month as month,
        coalesce(sum(case when reg_month = order_month then 1 end), 0) as new_customers,
        coalesce(sum(case when reg_month != order_month then 1 end), 0) as returning_customers
from cte
group by month
order by month;
