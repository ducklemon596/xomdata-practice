-- Xom Data · D7 and D30 retention rate
-- Problem: https://xomdata.com/practice/hard-retention-001
-- Solved: 2026-08-16

with cte as (
    select s.user_id, 
            sum (
                case 
                    when a.active_date between date(s.signup_date, '+1 days') and date(s.signup_date, '+7 days') then 1
                    else 0
                end
            ) as num_D7_retained,
            sum (
                case 
                    when a.active_date between date(s.signup_date, '+1 days') and date(s.signup_date, '+30 days') then 1
                    else 0
                end
            ) as num_D30_retained
    from signups s
    left join activity a on s.user_id = a.user_id
    group by s.user_id
), cte2 as (
    select (select count(distinct user_id) from signups) as total_users,
        (
            select count(distinct user_id) 
            from cte
            where num_D7_retained > 0
        ) as d7_retained,
        (
            select count(distinct user_id) 
            from cte
            where num_D30_retained > 0
        ) as d30_retained
)

select total_users, d7_retained,
        COALESCE(round(d7_retained * 100.0 / total_users, 2), 0) as d7_rate,
        d30_retained,
        COALESCE(round(d30_retained * 100.0 / total_users, 2), 0) as d30_rate
from cte2;
