-- Xom Data · Customer spending per order
-- Problem: https://xomdata.com/practice/medium-join-001
-- Solved: 2026-08-11

select c.full_name, count(total_amount) as order_count,
        sum(total_amount) as total_spending,
        avg(total_amount) as avg_order_value,
        row_number() over(order by sum(total_amount) desc, full_name) as spending_rank
from customers c
left join orders o on c.id = o.customer_id
group by c.id, c.full_name
order by spending_rank;
