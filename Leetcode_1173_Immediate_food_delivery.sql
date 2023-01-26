-- Immediate Food Delivery 

Background

If the preferred delivery date of the customer is the same as the order date then the order is called immediate otherwise it’s called scheduled.

Write an SQL query to find the percentage of immediate orders in the table, rounded to 2 decimal places.

The query result format is in the following example:

Delivery table:
+-------------+-------------+------------+-----------------------------+
| delivery_id | customer_id | order_date | customer_pref_delivery_date |
+-------------+-------------+------------+-----------------------------+
| 1           | 1           | 2019-08-01 | 2019-08-02                  |
| 2           | 5           | 2019-08-02 | 2019-08-02                  |
| 3           | 1           | 2019-08-11 | 2019-08-11                  |
| 4           | 3           | 2019-08-24 | 2019-08-26                  |
| 5           | 4           | 2019-08-21 | 2019-08-22                  |
| 6           | 2           | 2019-08-11 | 2019-08-13                  |
+-------------+-------------+------------+-----------------------------+

Result table:
+----------------------+
| immediate_percentage |
+----------------------+
| 33.33                |
+----------------------+

-- Query

WITH cte_1
     AS (SELECT Min(order_date) AS first_order_date,
                customer_id
         FROM   delivery
         GROUP  BY 2), -- cte_1 to get the first order date
         
     cte_2 AS (SELECT a.first_order_date,
                a.customer_id,
                b.delivery_id,
                b.customer_pref_delivery_date,
                CASE
                  WHEN a.first_order_date = b.customer_pref_delivery_date THEN
                  'immediate'
                  ELSE 'scheduled'
                END AS order_status
         FROM   cte_1 a
                INNER JOIN delivery b
                        ON a.customer_id = b.customer_id
                           AND a.first_order_date = b.order_date) -- comparing the 1st order date with the order date in the delivery table
                           
SELECT Round(Sum(CASE
                   WHEN order_status = 'immediate' THEN 1
                   ELSE 0
                 END) * 100.0 / Count(*), 2) AS immediate_percentage
FROM   cte_2
