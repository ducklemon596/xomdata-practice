-- Xom Data · Sessionize logins with a 30-minute gap
-- Problem: https://xomdata.com/practice/hard-session-001
-- Solved: 2026-08-23

WITH island1 AS (
    SELECT 
        user_id, 
        event_at,
        LAG(event_at) OVER (
            PARTITION BY user_id 
            ORDER BY event_at
        ) AS prev_event_at
    FROM events
),
island2 AS (
    SELECT 
        user_id, 
        event_at,
        -- Đánh dấu phiên mới khi khoảng cách > 1800s (30 phút)
        SUM(
            CASE 
                WHEN unixepoch(event_at) - unixepoch(prev_event_at) >= 1800 THEN 1 
                ELSE 0 
            END
        ) OVER (
            PARTITION BY user_id 
            ORDER BY event_at
        ) AS island_id
    FROM island1
)
SELECT 
    user_id, 
    island_id + 1 AS session_seq,
    COUNT(*) AS n_events,
    MIN(event_at) AS session_start,
    MAX(event_at) AS session_end,
    ROUND((unixepoch(MAX(event_at)) - unixepoch(MIN(event_at))) / 60.0, 1) AS duration_min
FROM island2
GROUP BY user_id, island_id
ORDER BY user_id, session_seq;
