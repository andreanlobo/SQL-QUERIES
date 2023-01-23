-- leetcode 1831
-- Background:

Transactions table:
+----------------+--------------------+--------+
| transaction_id | day                | amount |
+----------------+--------------------+--------+
| 8              | 2021-4-3 15:57:28  | 57     |
| 9              | 2021-4-28 08:47:25 | 21     |
| 1              | 2021-4-29 13:28:30 | 58     |
| 5              | 2021-4-28 16:39:59 | 40     |
| 6              | 2021-4-29 23:39:28 | 58     |
+----------------+--------------------+--------+

Result table:
+----------------+
| transaction_id |
+----------------+
| 1              |
| 5              |
| 6              |
| 8              |
+----------------+

-- Write an SQL query to report the IDs of the transactions with the maximum amount on their respective day. 
-- If in one day there are multiple such transactions, return all of them.

WITH cte_1
     AS (SELECT Date(day)                    AS "day",
                Max(amount)
                  OVER(
                    partition BY Date(day)
                    ORDER BY transaction_id) AS max_amt -- use of window function to get max amount for a particular date
         FROM   transactions),

     cte_2
     AS (SELECT a.day,
                a.max_amt,
                b.transaction_id
         FROM   cte_1 a
                INNER JOIN transactions b -- join the previous CTE with the main transactions table on amount 
                        ON b.amount = a.max_amt)

SELECT DISTINCT transaction_id AS "transaction_id"
FROM   cte_2
ORDER  BY 1
