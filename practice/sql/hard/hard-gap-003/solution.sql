-- Xom Data · Dự đoán ngày khách ghé tiếp theo
-- Problem: https://xomdata.com/practice/hard-gap-003
-- Solved: 2026-09-03

with cte as (
    select customer_id, order_date,
        julianday(order_date) - julianday(lag(order_date) over (partition by customer_id order by order_date)) as gap_days
    from orders
), cte2 as (
    select customer_id, 
            max(order_date) as last_order_date,
            cast(avg(gap_days) as integer) as avg_gap_days
    from cte
    group by customer_id
)

select *,
        date(last_order_date, '+' || avg_gap_days || ' days') as predicted_next_date
from cte2
where avg_gap_days is not null
order by predicted_next_date, customer_id
