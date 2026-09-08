-- Xom Data · Quãng im lặng dài nhất của mỗi khách
-- Problem: https://xomdata.com/practice/hard-gap-002
-- Solved: 2026-09-08

with cte as (
    select customer_id,
            order_date as gap_end,
            lag(order_date) over (partition by customer_id order by order_date) as gap_start,
            julianday(order_date) - julianday(lag(order_date) over (partition by customer_id order by order_date)) as gap_days
    from orders
), cte2 as (
    select *,
            rank() over (partition by customer_id order by gap_days desc, gap_start) as rnk
    from cte
    where gap_days is not null
)

select customer_id, gap_start, gap_end, gap_days
from cte2
where rnk = 1
order by gap_days desc, customer_id asc;
