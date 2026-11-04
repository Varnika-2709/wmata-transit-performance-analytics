--What is the relative performance of lines on the weekdays vs weekends?
SELECT R3.*, R1.passengerPerRevenueHour_Week, R2.passengerPerRevenueHour_Sat,R1.passengerPerRevenueHour_Week - R2.passengerPerRevenueHour_Sat as diff, R2.crowding_sat
From
(SELECT lineID, passengerPerRevenueHour_Week
FROM LineSummaryStat
WHERE fiscalYear=2024 AND timeOfWeek = 'Weekday') R1

INNER JOIN
(SELECT lineID, passengerPerRevenueHour_Sat, crowding_sat
FROM LineSummaryStat
WHERE fiscalYear=2024 AND timeOfWeek = 'Satuday') R2
ON R1.lineID = r2.lineID
INNER JOIN

(SELECT lineName, lineID
FROM Line
) R3
ON R1.lineID = R3.lineID