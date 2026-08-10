-- Xom Data · Average score per subject
-- Problem: https://xomdata.com/practice/medium-groupby-027
-- Solved: 2026-08-10

with cte as (
    select s.subject_name, s.credits, g.final_score,
        case 
            when g.final_score >= 5 then 1
            else 0
        end as is_passed
    from subjects s
    join grades g on s.id = g.subject_id
), cte2 as (
    select subject_name, credits, avg(final_score) as avg_score,
            sum(is_passed) as pass_num,
            count(*) as student_count
    from cte
    group by subject_name
)
    
select subject_name, credits, student_count, round(avg_score, 2) as avg_score,
        round(pass_num * 100.0 / student_count, 2) as pass_rate,
        rank() over (order by avg_score desc) as rank_by_avg,
        NTILE(4) over (order by avg_score desc, subject_name) as difficulty_quartile
from cte2
order by rank_by_avg, subject_name;
