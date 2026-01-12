/* Duplicate Detection
   Example key: BusinessUnit + MetricCategory + CreatedDate + RecordID
   Adjust keys based on business logic.
*/

SELECT
    BusinessUnit,
    MetricCategory,
    RecordID,
    COUNT(*) AS DuplicateCount
FROM PerformanceFact
GROUP BY
    BusinessUnit,
    MetricCategory,
    RecordID
HAVING COUNT(*) > 1
ORDER BY DuplicateCount DESC;
