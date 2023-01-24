-- Background:

-- Select all employee’s name and bonus whose bonus is < 1000.

-- Table:Employee

+-------+--------+-----------+--------+
| empId |  name  | supervisor| salary |
+-------+--------+-----------+--------+
|   1   | John   |  3        | 1000   |
|   2   | Dan    |  3        | 2000   |
|   3   | Brad   |  null     | 4000   |
|   4   | Thomas |  3        | 4000   |
+-------+--------+-----------+--------+
-- empId is the primary key column for this table.
-- Table: Bonus

+-------+-------+
| empId | bonus |
+-------+-------+
| 2     | 500   |
| 4     | 2000  |
+-------+-------+
-- empId is the primary key column for this table.
-- Example ouput:

+-------+-------+
| name  | bonus |
+-------+-------+
| John  | null  |
| Dan   | 500   |
| Brad  | null  |
+-------+-------+

-- MY SOLUTION:

SELECT
name,
bonus
FROM
(SELECT
a.empid,
a.name as "name",
a.salary,
COALESCE(b.bonus,NULL) as "bonus" 
FROM Employee a
LEFT JOIN bonus b
ON a.empid = b.empid
WHERE b.bonus < 1000
OR b.bonus IS NULL) a

-- I use a subquery to filter all records where the bonus for a particular employee is less then 1000 or does not have a bonus i.e. is not present in the bonus table. 
-- The idea is to get the list of employees with a bonus of less than 1000 or no bonus 
