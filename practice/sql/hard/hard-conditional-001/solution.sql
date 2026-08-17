-- Xom Data · Cumulative revenue from successful transactions only
-- Problem: https://xomdata.com/practice/hard-conditional-001
-- Solved: 2026-08-17

select "date", status, amount,
        sum(
            case 
                when status == 'success' then amount
                else 0
            end
        ) over(order by "date", status, id) as running_success_total
from transactions
