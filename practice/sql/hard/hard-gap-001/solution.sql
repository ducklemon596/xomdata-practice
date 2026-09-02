-- Xom Data · Nhịp mua hàng và tín hiệu rời bỏ
-- Problem: https://xomdata.com/practice/hard-gap-001
-- Solved: 2026-09-02

with cte as (
    select customer_id, 
            julianday(order_date) - julianday(lag(order_date) over (partition by customer_id order by order_date)) as date_diff
    from orders
)

select customer_id,
        round(avg(date_diff), 1) as avg_gap_days,
        case
            when avg(date_diff) is null then 'single'
            when avg(date_diff) <= 30 then 'fast'
            else 'slow'
        end as pace
from cte
group by customer_id;
