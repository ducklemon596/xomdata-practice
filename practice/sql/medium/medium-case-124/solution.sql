-- Xom Data · Classify student academic performance
-- Problem: https://xomdata.com/practice/medium-case-124
-- Solved: 2026-08-09

with cte as (
    select stu.full_name, stu.student_code,
            avg(sco.final_score) as avg_score_raw
    from students stu
    left join scores sco on stu.id = sco.student_id
    group by stu.id
)

select full_name, student_code, round(avg_score_raw, 2) as avg_score,
        case
            when avg_score_raw >= 9 then 'Excellent'
            when avg_score_raw >= 8 then 'Good'
            when avg_score_raw >= 7 then 'Fair'
            when avg_score_raw >= 5 then 'Average'
            else 'Poor'
        end as grade,
        rank() over(order by avg_score_raw desc) as class_rank
from cte
order by avg_score_raw desc
limit 20;
