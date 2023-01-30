-- Write an SQL query to report the number of calls and the total call duration between each pair of distinct persons (person1, person2) where person1 < person2.

-- Return the result table in any order.

-- The query result format is in the following example:

Calls table:
+---------+-------+----------+
| from_id | to_id | duration |
+---------+-------+----------+
| 1       | 2     | 59       |
| 2       | 1     | 11       |
| 1       | 3     | 20       |
| 3       | 4     | 100      |
| 3       | 4     | 200      |
| 3       | 4     | 200      |
| 4       | 3     | 499      |
+---------+-------+----------+


-- QUERY

SELECT from_id       AS person1,
       to_id         AS person2,
       Count(*)      AS call_count,
       Sum(duration) AS total_duration
FROM   (SELECT id,
               from_id,
               to_id,
               duration
        FROM   calls
        UNION
        SELECT id,
               to_id,
               from_id,
               duration
        FROM   calls)calls_table
WHERE  from_id < to_id
GROUP  BY 1,2
