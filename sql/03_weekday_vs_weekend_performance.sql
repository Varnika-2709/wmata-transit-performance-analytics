-- What is the relative performance of lines on weekdays vs weekends?
-- Positive diff = the line carries more passengers per revenue hour on a weekday than on a
-- Saturday (commuter-weighted); negative diff = weekend demand exceeds weekday demand.

SELECT R3.lineName,
       R3.lineID,
       R1.passengerPerRevenueHour_Week,
       R2.passengerPerRevenueHour_Sat,
       R1.passengerPerRevenueHour_Week - R2.passengerPerRevenueHour_Sat AS diff,
       R2.crowding_sat
FROM
    (SELECT lineID, passengerPerRevenueHour_Week
     FROM LineSummaryStat
     WHERE fiscalYear = 2024 AND timeOfWeek = 'Weekday') R1

INNER JOIN
    (SELECT lineID, passengerPerRevenueHour_Sat, crowding_sat
     FROM LineSummaryStat
     WHERE fiscalYear = 2024 AND timeOfWeek = 'Saturday') R2
    ON R1.lineID = R2.lineID

INNER JOIN
    (SELECT lineName, lineID
     FROM Line) R3
    ON R1.lineID = R3.lineID

ORDER BY diff DESC;
