-- Create database
CREATE DATABASE IF NOT EXISTS international_debt;

-- Create table
CREATE TABLE international_debt
(
  country_name character varying(50),
  country_code character varying(50),
  indicator_name text,
  indicator_code text,
  debt numeric
);

SELECT * FROM international_debt;

-- -----------------------------------------------------------

-- 1.The World Bank's international debt data
SELECT * FROM international_debt;

-- 2.Finding the number of distinct countries
SELECT COUNT(DISTINCT country_name) AS no_of_countries FROM international_debt;

-- 3.Finding out the distinct debt indicators
SELECT DISTINCT indicator_name FROM international_debt;

-- 4.Totaling the amount of debt owed by the countries
SELECT ROUND(SUM(debt)/1000000, 2) as total_debt
FROM international_debt;

-- 5.Country with the highest debt
SELECT country_name,SUM(debt) AS total_debt
FROM international_debt
GROUP BY country_name
ORDER BY total_debt DESC
LIMIT 1;

-- 6.Average amount of debt across indicators
SELECT indicator_name,AVG(debt) AS avg_debt
FROM international_debt
GROUP BY indicator_name
ORDER BY avg_debt DESC;

-- 7.The highest amount of principal repayments
SELECT * FROM international_debt
WHERE debt = (SELECT MAX(debt) FROM international_debt
			WHERE indicator_name LIKE 'Principal repayments%')
ORDER BY debt DESC;

-- 8.The most common debt indicator
SELECT indicator_code, COUNT(indicator_code) AS code_count
FROM international_debt
GROUP BY indicator_code
ORDER BY code_count DESC;

-- 9.The maximum amount of debt that each country has
SELECT country_name,MAX(debt) AS maximum_debt
FROM international_debt
GROUP BY country_name
ORDER BY maximum_debt DESC
LIMIT 10;
