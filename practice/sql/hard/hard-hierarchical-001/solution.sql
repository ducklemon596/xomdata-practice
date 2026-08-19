-- Xom Data · Total sales by org branch
-- Problem: https://xomdata.com/practice/hard-hierarchical-001
-- Solved: 2026-08-19

WITH RECURSIVE team_members AS (
    SELECT id AS leader_id, id AS member_id
    FROM agents

    UNION ALL

    SELECT tm.leader_id, a.id AS member_id
    FROM team_members tm
    JOIN agents a ON tm.member_id = a.manager_id
)
SELECT 
    leader.id AS agent_id,
    leader.name AS agent_name,
    leader.direct_sales,
    SUM(member.direct_sales) AS team_total
FROM agents leader
JOIN team_members tm ON leader.id = tm.leader_id
JOIN agents member ON tm.member_id = member.id
GROUP BY leader.id, leader.name, leader.direct_sales
ORDER BY team_total DESC, leader.id;
