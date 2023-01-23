
Description

UnitedHealth Group has a program called Advocate4Me, which allows members to call an advocate and receive support for their health care needs – whether that's behavioral, clinical, well-being, health care financing, benefits, claims or pharmacy help.
Write a query to get the patients who made a call within 7 days of their previous call. If a patient called more than twice in a span of 7 days, count them as once.
Callers Table

Column Name
Type
policy_holder_id
integer
case_id
varchar
call_category
varchar
call_received
timestamp
call_duration_secs
integer
original_order
integer


Query

I started this query using a CTE (common table expression) using the LAG() function to take into consideration the previous call made by the policyholder 

WITH cte_1 AS
(
         SELECT   policy_holder_id,
                  call_received                                                                     AS "1st_call_received",
                  Lag(call_received) OVER(partition BY policy_holder_id ORDER BY call_received ASC) AS prev_call_received,
                  call_category
         FROM     datalemur_datasets.callers
         ORDER BY policy_holder_id ASC), 


In the second CTE I take the difference in days between the first call made and the previous call. 


cte_2 AS
(
       SELECT policy_holder_id,
              call_category,
              1st_call_received,
              prev_call_received,
              ifnull(datediff(1st_call_received, prev_call_received),'n/a') AS day_diff
       FROM   cte_1
       WHERE  ifnull(datediff(1st_call_received, prev_call_received),'n/a') <= 7
       AND    ifnull(datediff(1st_call_received, prev_call_received),'n/a') NOT IN ('n/a') )


In the above clause I filter out all those records where the difference in days exceeds 7 days or more or if it’s Not Available (N/A). 


SELECT count(DISTINCT policy_holder_id) AS patient_count
FROM   cte_2

