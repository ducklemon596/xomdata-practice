-- Xom Data · Còn sống sót tính từ tháng thứ hai trở đi
-- Problem: https://xomdata.com/practice/hard-retention-005
-- Solved: 2026-09-07

with cte as (
    select distinct customer_id,
            strftime('%Y-%m', order_date) as order_month,
            min(strftime('%Y-%m', order_date)) over (partition by customer_id) as reg_month
    from orders
), cte2 as (
    select reg_month as cohort_month,
            count(distinct customer_id) as cohort_size,
            count(distinct
                case    
                    when (CAST(substr(order_month, 1, 4) AS INT) * 12 + CAST(substr(order_month, 6, 2) AS INT)) - (CAST(substr(reg_month, 1, 4) AS INT) * 12 + CAST(substr(reg_month, 6, 2) AS INT)) >= 2 then customer_id
                    else -1
                end 
            ) - 1 as survivors
    from cte
    group by reg_month
)
select *, round(survivors * 100.0 / cohort_size, 2) as survival_pct
from cte2
order by cohort_month;
