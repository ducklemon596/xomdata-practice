-- Xom Data · Median and percentile salary by department
-- Problem: https://xomdata.com/practice/hard-percentile-001
-- Solved: 2026-08-17

WITH cte AS (
    SELECT 
        department, 
        salary,
        ABS(PERCENT_RANK() OVER (PARTITION BY department ORDER BY salary) - 0.25) AS abs_p25,
        ABS(PERCENT_RANK() OVER (PARTITION BY department ORDER BY salary) - 0.50) AS abs_p50,
        ABS(PERCENT_RANK() OVER (PARTITION BY department ORDER BY salary) - 0.75) AS abs_p75
    FROM employees
)
SELECT DISTINCT 
    department,
    FIRST_VALUE(salary) OVER (PARTITION BY department ORDER BY abs_p25 ASC, salary ASC) AS p25,
    FIRST_VALUE(salary) OVER (PARTITION BY department ORDER BY abs_p50 ASC, salary ASC) AS p50,
    FIRST_VALUE(salary) OVER (PARTITION BY department ORDER BY abs_p75 ASC, salary ASC) AS p75
FROM cte
ORDER BY department ASC;
