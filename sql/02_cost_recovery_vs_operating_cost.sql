--What is the relative performance of the most costly routes in terms of cost recovery?

SELECT A1.*,R2019.FY2019_weekday_cr,R2020.FY2020_weekday_cr, R1.FY2021_weekday_cr ,R4.FY2022_weekday_cr, R2.FY2023_Weekday_cr,  R3.FY2024_Weekday_cr
FROM
(SELECT  Line, Saturday AS FY2019_weekday_cr
FROM LineWeekdaySummaryStats
WHERE Field='CostRecovery' AND FY = 2019) R2019
INNER JOIN
(SELECT  Line, Saturday AS FY2020_weekday_cr
FROM LineWeekdaySummaryStats
WHERE Field='CostRecovery' AND FY = 2020) R2020
ON R2020.line = R2019.line
INNER JOIN
(SELECT  Line, Saturday AS FY2021_weekday_cr
FROM LineWeekdaySummaryStats
WHERE Field='CostRecovery' AND FY = 2021) R1
ON R1.Line = R2020.Line
INNER JOIN
(SELECT Line, Saturday AS FY2023_Weekday_cr
FROM LineWeekdaySummaryStats
WHERE Field='CostRecovery' AND FY = 2023) R2
ON R1.Line = R2.Line
INNER JOIN
(SELECT  Line, Saturday AS FY2022_weekday_cr
FROM LineWeekdaySummaryStats
WHERE Field='CostRecovery' AND FY = 2022) R4
ON R1.Line = R4.Line
INNER JOIN
(SELECT Line, Saturday AS FY2024_Weekday_cr
FROM LineWeekdaySummaryStats
WHERE Field='CostRecovery' AND FY = 2024) R3
ON R1.Line = R3.Line
INNER JOIN
(SELECT line, SUM(annualOperatingCost) as Total_Operating_Cost_2021_2024 FROM line_agg

GROUP BY line) A1
ON A1.line = R1.line
Order by Total_Operating_Cost_2021_2024 Desc