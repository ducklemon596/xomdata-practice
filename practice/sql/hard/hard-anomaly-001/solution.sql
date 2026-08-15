-- Xom Data · Detect anomalous days vs the average
-- Problem: https://xomdata.com/practice/hard-anomaly-001
-- Solved: 2026-08-15

with cte as (
    select date, value, 
            avg(value) over() as mean,
            (value - avg(value) over()) * (value - avg(value) over()) as variance
    from daily_metrics
), cte2 as (
    select date, value, mean,
            (select NULLIF(sqrt(avg(variance)), 0) from cte) as stddev
    from cte
)

select date, value, 
        round(mean, 2) as mean, 
        COALESCE(round(stddev, 2), 0) as stddev,
        COALESCE(round((value - mean) * 1.0 / stddev, 2), 0) as z_score,
        case 
            when (value - mean) * 1.0 / stddev > 2 then 'high'
            when (value - mean) * 1.0 / stddev < -2 then 'low'
            else 'normal'
        end as flag
from cte2;
