-- Xom Data · Xếp khách vào nhóm chăm sóc phù hợp
-- Problem: https://xomdata.com/practice/hard-rfm-002
-- Solved: 2026-08-28

with cte as (
    select customer_id, 
            cast((julianday('2024-06-30') - julianday(max(order_date))) as int) as days_since,
            count(*) as order_count
    from orders
    group by customer_id
)

select *,
        case 
            when days_since <= 60 and order_count >= 3 then 'Champions'
            when days_since > 60 and order_count >= 3 then 'At Risk'
            when days_since <= 60 and order_count < 3 then 'Promising'
            else 'Hibernating'
        end as segment
from cte
