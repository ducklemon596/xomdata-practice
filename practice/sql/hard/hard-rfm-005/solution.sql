-- Xom Data · Chấm điểm công bằng khi nhiều khách ngang tài
-- Problem: https://xomdata.com/practice/hard-rfm-005
-- Solved: 2026-09-06

with cte as (
    select customer_id, sum(amount) as total_spent,
        rank() over (order by sum(amount) desc) as rnk
    from orders
    group by customer_id
), cte2 as (
    select count(distinct customer_id) as num_customer
    from orders
), cte3 as (
    select customer_id, total_spent,
            coalesce((rnk - 1) * 1.0 / nullif((select num_customer from cte2) - 1, 0), 0) as score
    from cte
)

select customer_id, total_spent,
        case
            when score < 0.2 then 5
            when score < 0.4 then 4
            when score < 0.6 then 3
            when score < 0.8 then 2
            else 1
        end as m_score
from cte3
