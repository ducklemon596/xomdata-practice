-- Xom Data · Sau một tháng, còn lại bao nhiêu phần
-- Problem: https://xomdata.com/practice/hard-retention-002
-- Solved: 2026-08-26

with cte as (
    select customer_id,
            strftime('%Y-%m', order_date) as order_month,
            dense_rank() over (partition by customer_id order by strftime('%Y-%m', order_date)) as dr
    from orders
), cte2 as (
    select customer_id, 
        max(case when dr = 1 then order_month end) as register_month,
        max(case when dr = 2 then order_month end) as next_month
    from cte
    group by customer_id
), user_behavior as (
    select customer_id, register_month,
            case 
                when strftime('%Y-%m', register_month || '-01', '+1 month') = next_month then 1
                else 0
            end as is_consecutive
    from cte2
), month_list as (
    select distinct register_month
    from cte2
)
select ml.register_month as cohort_month,
        count(ub.customer_id) as cohort_size,
        coalesce(sum(ub.is_consecutive), 0) as retained_m1,
        coalesce(round(sum(ub.is_consecutive) * 100.0 / nullif(count(ub.customer_id), 0), 2), 0) as retention_pct
from month_list ml
join user_behavior ub on ml.register_month = ub.register_month
group by cohort_month
order by cohort_month;
