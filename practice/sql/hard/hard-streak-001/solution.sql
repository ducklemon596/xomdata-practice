-- Xom Data · Chuỗi tháng ghé đều dài nhất
-- Problem: https://xomdata.com/practice/hard-streak-001
-- Solved: 2026-08-31

with cte as (
    select distinct customer_id, strftime('%Y-%m', order_date) as order_month
    from orders
), cte2 as (
    select customer_id, order_month,
            lag(order_month) over (partition by customer_id order by order_month) as prev_month
    from cte
), cte3 as (
    select customer_id, 
            sum(
                case 
                    when strftime('%Y-%m', prev_month || '-01', '+1 month') = order_month then 0
                    else 1
                end
            ) over (partition by customer_id order by order_month) as group_id
    from cte2
), cte4 as (
    select customer_id, count(*) as streak
    from cte3
    group by customer_id, group_id
)

select customer_id, 
        max(streak) as longest_streak
from cte4
group by customer_id
order by longest_streak desc, customer_id;
