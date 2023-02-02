-- How to calculate the year of birth from the fiscal code (Italy)
-- The fiscal code is a unique 16 letter code with the birth year on the 7th position

-- CODE

SELECT
CAST('19' || SUBSTR(FISCAL_CODE,7,2) AS INT) AS YEAR_OF_BIRTH
FROM DUAL;
