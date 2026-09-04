-- Xom Data · Mã ba chữ số nói lên tất cả
-- Problem: https://xomdata.com/practice/hard-rfm-004
-- Solved: 2026-09-04

with cte as (
    select customer_id,
            max(order_date) as latest_date,
            count(*) as frequency,
            sum(amount) as monetary
    from orders
    group by customer_id
), cte2 as (
    select customer_id,
            6 - ntile(5) over (order by latest_date desc) as recency,
            6 - ntile(5) over (order by frequency desc) as frequency,
            6 - ntile(5) over (order by monetary desc) as monetary
    from cte        
)

select customer_id, 
        (recency || frequency || monetary) as rfm_code
from cte2
order by rfm_code desc, customer_id;
