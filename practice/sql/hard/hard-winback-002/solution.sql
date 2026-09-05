-- Xom Data · Đếm những sự trở lại mỗi tháng
-- Problem: https://xomdata.com/practice/hard-winback-002
-- Solved: 2026-09-05

with cte as (
    select customer_id, order_date,
            lag(order_date) over (partition by customer_id order by order_date) as last_order_date
    from orders
), cte2 as (
    select distinct customer_id,
            strftime('%Y-%m', order_date) as month,
            case
                when ((cast(strftime('%Y', order_date) as int) * 12 + cast(strftime('%m', order_date) as int)) - (cast(strftime('%Y', last_order_date) as int) * 12 + cast(strftime('%m', last_order_date) as int)) >= 3) then 1
                else 0
            end as resurrected_customer
    from cte
)

select month, count(customer_id) as resurrected_customers
from cte2
where resurrected_customer >= 1
group by month
order by month;
