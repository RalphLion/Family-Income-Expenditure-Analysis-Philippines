-- Average Household Income per Region
SELECT region, AVG(total_household_income) AS average_household_income
FROM `projects.Family Income and Expenditure`
GROUP BY region
ORDER BY average_household_income DESC;


-- Comparison of Highest/Lowest Average Household Income to National Average Income
WITH overall_average_income AS (
  SELECT AVG(total_household_income) AS national_average_income
  FROM `projects.Family Income and Expenditure`
),
average_income_per_region AS (
  SELECT region, AVG(total_household_income) AS average_household_income
  FROM `projects.Family Income and Expenditure`
  GROUP BY region
)

SELECT average.region,
  CASE
    WHEN average.region = "NCR" THEN
     ((average.average_household_income - overall.national_average_income) / overall.national_average_income) * 100
    ELSE
     NULL
    END AS ncr_percent_difference,
  CASE
    WHEN average.region = "ARMM" THEN
     ((overall.national_average_income - average.average_household_income) / overall.national_average_income) * 100
    ELSE
     NULL
    END AS armm_percent_difference
FROM overall_average_income AS overall
JOIN average_income_per_region AS average
ON 1 = 1
WHERE average.region IN ("NCR", "ARMM");


-- Difference Between the Average Household Income of NCR and ARMM
WITH ARMM_average_income AS (
  SELECT AVG(total_household_income) AS average_income
  FROM `projects.Family Income and Expenditure`
  WHERE region = "ARMM"
),

NCR_average_income AS (
  SELECT AVG(total_household_income) AS average_income
  FROM `projects.Family Income and Expenditure`
  WHERE region = "NCR"
)

SELECT ((ncr.average_income - armm.average_income) / armm.average_income) * 100 AS percent_difference
FROM ARMM_average_income AS armm
CROSS JOIN NCR_average_income AS ncr;


-- Average Household Expenditure per Region
SELECT region, AVG(expenditure) AS average_expenditure
FROM `projects.Family Income and Expenditure`
GROUP BY region
ORDER BY average_expenditure DESC;

-- Comparison of the Highest/Lowest Average Expenditure to National Average Expenditure
WITH overall_average_expenditure AS (
  SELECT AVG(expenditure) AS national_average_expenditure
  FROM `projects.Family Income and Expenditure`
),
average_expenditure_per_region AS (
  SELECT region, AVG(expenditure) AS average_expenditure
  FROM `projects.Family Income and Expenditure`
  GROUP BY region
)

SELECT average.region,
  CASE
    WHEN average.region = "NCR" THEN
     ((average.average_expenditure - overall.national_average_expenditure) / overall.national_average_expenditure) * 100
    ELSE
     NULL
    END AS ncr_percent_difference,
  CASE
    WHEN average.region = "IX - Zamboanga Peninsula" THEN
     ((overall.national_average_expenditure - average.average_expenditure) / overall.national_average_expenditure) * 100
    ELSE
     NULL
    END AS zamboanga_percent_difference
FROM overall_average_expenditure AS overall
JOIN average_expenditure_per_region AS average
ON 1 = 1
WHERE average.region IN ("NCR", "IX - Zamboanga Peninsula");


-- Difference Between the Average Expenditure of NCR and Region IX – Zamboanga Peninsula
WITH Zamboanga_average_expenditure AS (
  SELECT AVG(expenditure) AS average_expenditure
  FROM `projects.Family Income and Expenditure`
  WHERE region = "IX - Zamboanga Peninsula"
),

NCR_average_expenditure AS (
  SELECT AVG(expenditure) AS average_expenditure
  FROM `projects.Family Income and Expenditure`
  WHERE region = "NCR"
)

SELECT ((ncr.average_expenditure - zamboanga.average_expenditure) / zamboanga.average_expenditure) * 100 AS percent_difference
FROM Zamboanga_average_expenditure AS zamboanga
CROSS JOIN NCR_average_expenditure AS ncr;


-- Average Expenditure per Expenditure Type
SELECT expenditure_type, AVG(expenditure) as average_expenditure
FROM `projects.Family Income and Expenditure`
GROUP BY expenditure_type
ORDER BY average_expenditure DESC;
