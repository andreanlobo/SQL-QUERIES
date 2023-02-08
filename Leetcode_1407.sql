-- Top Travellers
-- Leetcode 1407

-- QUERY

WITH CTE AS (
SELECT 
b.id,
b.name,
COALESCE(a.distance,0) AS distance -- GIVE 0 IF THE USER NEVER TOOK A RIDE
FROM Rides a
RIGHT JOIN Users b -- USING RIGHT JOIN TO GET USERS WHO DID NOT TAKE A RIDE
ON b.id = a.user_id)

SELECT 
name,
SUM(distance) AS travelled_distance
FROM CTE
GROUP BY name
ORDER BY 2 DESC,1 ASC
