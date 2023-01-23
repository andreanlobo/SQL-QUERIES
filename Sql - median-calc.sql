-- SQL QUERY TO CALCULATE THE MEDIAN SALARY FOR 3 COMPANIES
-- LEETCODE REFERENCE 569

TABLE
+-----+------------+--------+
|Id   | Company    | Salary |
+-----+------------+--------+
|1    | A          | 2341   |
|2    | A          | 341    |
|3    | A          | 15     |
|4    | A          | 15314  |
|5    | A          | 451    |
|6    | A          | 513    |
|7    | B          | 15     |
|8    | B          | 13     |
|9    | B          | 1154   |
|10   | B          | 1345   |
|11   | B          | 1221   |
|12   | B          | 234    |
|13   | C          | 2345   |
|14   | C          | 2645   |
|15   | C          | 2645   |
|16   | C          | 2652   |
|17   | C          | 65     |
+-----+------------+--------+

WITH CTE_1 AS (
SELECT
*,
ROUND(total_cnt * 1.0/2,1) AS range_1, -- range_1 used as helping field
ROUND(total_cnt * 1.0/2 + 1,1) AS range_2 -- range_2 used as helping field
FROM
(SELECT *,
ROW_NUMBER() OVER(PARTITION BY company ORDER BY salary) AS rn, -- give a row number to each salary value by company
COUNT(1) OVER(PARTITION BY company) AS total_cnt -- count the total employees by company
FROM employee2)A
)

SELECT
emp_id,
company,
salary AS median_salary
FROM CTE_1
WHERE rn BETWEEN range_1 AND range_2 -- check if the row_number is between the 2 helping fields. If yes then that is the median

-- Answer
+-----+------------+--------+
|Id   | Company    | Salary |
+-----+------------+--------+
|5    | A          | 451    |
|6    | A          | 513    |
|12   | B          | 234    |
|9    | B          | 1154   |
|14   | C          | 2645   |
+-----+------------+--------+
