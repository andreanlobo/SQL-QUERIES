-- Question: Query to fix names such that only the first letter is capitalized

Users table:
+---------+-------+
| user_id | name  |
+---------+-------+
| 1       | aLice |
| 2       | bOB   |
+---------+-------+
Result table:
+---------+-------+
| user_id | name  |
+---------+-------+
| 1       | Alice |
| 2       | Bob   |
+---------+-------+

-- Answer:

WITH CTE_1 AS(
SELECT 
user_id,
LOWER(name) as name -- get the names in small
FROM users)

SELECT 
user_id,
INITCAP(name) as name -- using INITCAP() get starting letter in capitals
FROM CTE_1
