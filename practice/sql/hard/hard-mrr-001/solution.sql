-- Xom Data · Monthly recurring revenue (MRR) by subscription plan
-- Problem: https://xomdata.com/practice/hard-mrr-001
-- Solved: 2026-08-25

with recursive cte as (
    select strftime('%Y-%m', started_at) as started_at,
        case
            when ended_at is null then '9999-12'
            else strftime('%Y-%m', ended_at)
        end as ended_at,
        mrr
    from subscriptions
), bounds as (
    select min(started_at) as min_month,
            max(started_at) as max_month
    from cte
), list as (
    select min_month as month from bounds

    union all

    select strftime('%Y-%m', month || '-01', '+1 month')
    from list
    where month < (select max_month from bounds)
)

select list.month,
        coalesce(count(cte.mrr), 0) as active_subs,
        coalesce(sum(cte.mrr), 0) as total_mrr
from list
left join cte on list.month >= cte.started_at 
    and cte.ended_at > list.month
group by month
order by month
