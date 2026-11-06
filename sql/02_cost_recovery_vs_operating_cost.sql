-- Which routes, weighted by total operating cost, still have low rates of cost recovery?
-- Pairs each line's total operating cost with its Saturday cost-recovery ratio for FY2019-FY2024,
-- so that lines can be ranked by spend and read across the COVID window in one row.

SELECT A1.*,
       R2019.FY2019_saturday_cr,
       R2020.FY2020_saturday_cr,
       R2021.FY2021_saturday_cr,
       R2022.FY2022_saturday_cr,
       R2023.FY2023_saturday_cr,
       R2024.FY2024_saturday_cr
FROM
    (SELECT Line, SUM(annualOperatingCost) AS Total_Operating_Cost_2021_2024
     FROM line_agg
     GROUP BY Line) A1

INNER JOIN
    (SELECT Line, Saturday AS FY2019_saturday_cr
     FROM LineWeekdaySummaryStats
     WHERE Field = 'CostRecovery' AND FY = 2019) R2019
    ON R2019.Line = A1.Line

INNER JOIN
    (SELECT Line, Saturday AS FY2020_saturday_cr
     FROM LineWeekdaySummaryStats
     WHERE Field = 'CostRecovery' AND FY = 2020) R2020
    ON R2020.Line = A1.Line

INNER JOIN
    (SELECT Line, Saturday AS FY2021_saturday_cr
     FROM LineWeekdaySummaryStats
     WHERE Field = 'CostRecovery' AND FY = 2021) R2021
    ON R2021.Line = A1.Line

INNER JOIN
    (SELECT Line, Saturday AS FY2022_saturday_cr
     FROM LineWeekdaySummaryStats
     WHERE Field = 'CostRecovery' AND FY = 2022) R2022
    ON R2022.Line = A1.Line

INNER JOIN
    (SELECT Line, Saturday AS FY2023_saturday_cr
     FROM LineWeekdaySummaryStats
     WHERE Field = 'CostRecovery' AND FY = 2023) R2023
    ON R2023.Line = A1.Line

INNER JOIN
    (SELECT Line, Saturday AS FY2024_saturday_cr
     FROM LineWeekdaySummaryStats
     WHERE Field = 'CostRecovery' AND FY = 2024) R2024
    ON R2024.Line = A1.Line

ORDER BY Total_Operating_Cost_2021_2024 DESC;
