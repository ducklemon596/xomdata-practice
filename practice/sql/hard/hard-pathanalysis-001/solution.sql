-- Xom Data · Most common 3-step user path
-- Problem: https://xomdata.com/practice/hard-pathanalysis-001
-- Solved: 2026-08-15

with cte as (
    select user_id, page,
        lag(page, 1) over (partition by user_id order by viewed_at) as prev_page,
        lag(page, 2) over (partition by user_id order by viewed_at) as second_prev_page
    from page_views
)

select (second_prev_page || ' > ' || prev_page || ' > ' || page) as path,
        count(distinct user_id) as n_users
from cte
where (prev_page IS NOT NULL) and (second_prev_page IS NOT NULL)
group by path
order by n_users desc, path
limit 10;
