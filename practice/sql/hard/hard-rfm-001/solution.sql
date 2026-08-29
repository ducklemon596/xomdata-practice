-- Xom Data · Chấm điểm khách hàng trên ba thước đo
-- Problem: https://xomdata.com/practice/hard-rfm-001
-- Solved: 2026-08-29

with cte as (
    select customer_id,
            max(order_date) as recency,
            count(*) as frequency,
            sum(amount) as monetary
    from orders
    group by customer_id
), cte2 as (
    select customer_id,
            6 - ntile(5) over (order by recency desc) as r_score,
            6 - ntile(5) over (order by frequency desc) as f_score,
            6 - ntile(5) over (order by monetary desc) as m_score
    from cte         
)

select *, r_score + f_score + m_score as rfm_total
from cte2
