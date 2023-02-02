-- How to calculate the year of birth from the fiscal code (Italy)
-- The fiscal code is a unique 16 letter code with the birth year on the 7th position
-- This is obviously assuming that the people being analyzed were born in the 90's

-- CODE

SELECT
CAST('19' || SUBSTR(FISCAL_CODE,7,2) AS INT) AS YEAR_OF_BIRTH
FROM DUAL;
