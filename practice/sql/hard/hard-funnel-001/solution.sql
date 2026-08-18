-- Xom Data · 4-step onboarding conversion rate
-- Problem: https://xomdata.com/practice/hard-funnel-001
-- Solved: 2026-08-18

with cte1 as (
    select 'signup' as step
    UNION ALL
    select 'verify_email' 
    UNION ALL
    select 'first_login'
    UNION ALL
    select 'first_purchase'
), cte2 as (
    select event_name, count(distinct user_id) as n_users
    from events
    group by event_name
)

select c1.step, COALESCE(c2.n_users, 0) as n_users,
        COALESCE(round(c2.n_users * 100.0 / nullif((select n_users from cte2 where event_name = 'signup'), 0), 2), 0) as conversion_pct
from cte1 c1
left join cte2 c2 on c1.step = c2.event_name
