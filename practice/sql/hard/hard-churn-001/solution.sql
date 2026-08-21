-- Xom Data · Churned and returning customers
-- Problem: https://xomdata.com/practice/hard-churn-001
-- Solved: 2026-08-21

with cte as (
    select user_id, 
            lag(order_date) over (partition by user_id order by order_date) as prev_order,
            order_date as next_order,
            julianday(order_date) - julianday(lag(order_date) over (partition by user_id order by order_date)) as gap_days
    from orders
)

select *
from cte
where gap_days >= 90
order by gap_days desc, user_id;
