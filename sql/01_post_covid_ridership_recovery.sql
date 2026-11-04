--What is the relative recovery post-covid of the routes most affected by covid?

SELECT R1.*, R2.FY2021_Ridership, R3.FY2024_Ridership,(R1.FY2019_Ridership-R2.FY2021_Ridership)/R1.FY2019_Ridership As Per_change FROM
(SELECT Route, Measure AS FY2019_Ridership 
FROM RouteSummaryStats
WHERE Field='TotalRidership' AND FY = 2019) R1
INNER JOIN
(SELECT Route, Measure AS FY2021_Ridership 
FROM RouteSummaryStats
WHERE Field='TotalRidership' AND FY = 2021) R2
ON R1.Route = R2.Route

INNER JOIN
(SELECT Route, Measure AS FY2024_Ridership 
FROM RouteSummaryStats
WHERE Field='TotalRidership' AND FY = 2024) R3
ON R1.Route = R3.Route
Order by Per_change DESC