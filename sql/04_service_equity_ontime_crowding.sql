--What is the relative performance of low income, high-ridership routes in terms of on-time performace 
--and crowding?
SELECT R3.*, R2.crowding,R2.passengerPerRevenueMile,r2.onTimePercent, R1.lowIncomePercent
From
(SELECT LineID, lowIncomePercent
FROM LinePerformanceFact
WHERE fiscalYear=2024 AND  lowIncomePercent IS NOT NULL) R1

INNER JOIN
(SELECT LineID, onTimePercent, crowding, passengerPerRevenueMile
FROM LineSummaryStat
WHERE fiscalYear = 2024 AND onTimePercent IS NOT NULL AND  crowding IS NOT NULL AND passengerPerRevenueMile IS NOT NULL) R2
ON R1.LineID = R2.lineID

INNER JOIN
(SELECT lineName, lineID
FROM Line
) R3
ON R1.lineID = R3.lineID
