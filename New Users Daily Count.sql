-- New Users Daily Count

-- QUERY TO GET FIRST LOGIN DATE FOR EACH USER
WITH CTE_1 AS (
SELECT 
user_id,
MIN(activity_date) as first_login
FROM traffic
WHERE activity IN ('login')
GROUP BY 1),

-- IN THE 2ND CTE I'm trying to find how many users logged in by the first_logged_date

CTE_2 AS (
SELECT 
first_login as login_date,
COUNT(user_id) as user_count
FROM CTE_1
GROUP BY first_login
ORDER BY first_login DESC)

SELECT 
login_date,
user_count
FROM CTE_2
WHERE login_date >= '2019-06-30'::date - interval '90 day'
ORDER BY login_date ASC
