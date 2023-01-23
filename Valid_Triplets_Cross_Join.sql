# SQL-QUERIES
My SQL Queries

-- All Valid Triplets That Can Represent a Country 

-- Background: There are 3 schools in a certain place where each student is enrolled in only one school. Students need to be selected in a way that no 2 students share the same name and the same student_id. 

-- Query:

SELECT schoola.student_name AS member_A,
       schoolb.student_name AS member_B,
       schoolc.student_name AS member_C
FROM   schoola,schoolb,schoolc -- using a cross join to get all possible combinations
WHERE schoola.student_id <> schoolb.student_id
  AND schoola.student_id <> schoolc.student_id
  AND schoolb.student_id <> schoolc.student_id
  AND schoola.student_name <> schoolb.student_name
  AND schoola.student_name <> schoolc.student_name
  AND schoolb.student_name <> schoolc.student_name -- in the where condition do in such a way that no name from a specific column is repeated and neither the student_i
