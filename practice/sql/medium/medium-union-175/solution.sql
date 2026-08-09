-- Xom Data · Summary of issues to handle
-- Problem: https://xomdata.com/practice/medium-union-175
-- Solved: 2026-08-09

with cte as (
    select 'Complaint' as type, count(*) as quantity
    from complaints
    where status = 'Pending'

    UNION ALL

    select 'Cancelled Order', count(*)
    from orders
    where status = 'Cancelled'

    UNION ALL

    select 'Out of Stock Product', count(*)
    from products
    where status = 'Out of Stock'
), cte2 as (
    select type, quantity, 
        quantity * 100.0 / (select sum(quantity) from cte) as pct_of_total,
        rank() over (order by quantity desc) as rank_pos,
        row_number() over (order by quantity desc, type) as rank_pos_tmp
    from cte
)

select type, quantity, round(pct_of_total, 2) as pct_of_total, rank_pos, 
        round(sum(pct_of_total) over(order by rank_pos_tmp), 2) as cumulative_pct
from cte2
order by rank_pos, type;
