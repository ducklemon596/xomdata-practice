-- Xom Data · Total payroll by org branch
-- Problem: https://xomdata.com/practice/hard-recursive-001
-- Solved: 2026-08-27

with recursive cte as (
    select id as manager_id, manager_id as direct_manager_id, id, name, salary
    from employees

    union all

    select cte.manager_id, cte.id, e.id, e.name, e.salary
    from employees e
    inner join cte on cte.id = e.manager_id
)

select manager_id, name as manager_name,
        sum(
            case 
                when manager_id = direct_manager_id then 1
                else 0
            end
        ) as direct_reports,
        count(id) as subtree_size,
        sum(salary) as subtree_salary
from cte
group by manager_id
having direct_reports > 0
order by subtree_salary desc, manager_id;
