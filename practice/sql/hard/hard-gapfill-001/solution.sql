-- Xom Data · Daily revenue including zero-sale days
-- Problem: https://xomdata.com/practice/hard-gapfill-001
-- Solved: 2026-08-22

with recursive sequential_daily_revenue as (
    select min("date") as "date"
    from daily_revenue

    union all

    select date("date", '+1 day')
    from sequential_daily_revenue
    where "date" < (select max("date") from daily_revenue)
)

select sdr.date,
        coalesce(sum(dr.amount), 0) as revenue
from sequential_daily_revenue as sdr
left join daily_revenue dr on sdr."date" = dr."date"
group by sdr."date";
