-- Question:

-- Table number contains many numbers in column num including duplicated ones.

-- Can you write a SQL query to find the biggest number, which only appears once.

num
8
8
3
3
1
4
5
6


-- QUERY:

SELECT num
FROM   (SELECT num,
               Count(1) AS n_instances -- count how many times a particular number occurs in the dataset
        FROM   my_numbers
        GROUP  BY 1
        HAVING Count(1) = 1
        ORDER  BY num DESC) A
LIMIT  1

-- Answer: 6
