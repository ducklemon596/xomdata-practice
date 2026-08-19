-- Xom Data · Top 3 products by sales in each category
-- Problem: https://xomdata.com/practice/hard-topn-001
-- Solved: 2026-08-19

with cte as (
    select category, name as product_name, sum(units_sold) as units_sold,
            dense_rank() over (partition by category order by sum(units_sold) desc) as rank_in_cat
    from products
    group by name, category
)

select *
from cte
where rank_in_cat <= 3
order by category, rank_in_cat, product_name
