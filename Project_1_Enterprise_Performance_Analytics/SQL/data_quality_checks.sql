-- Duplicate record check
SELECT RecordID, COUNT(*)
FROM PerformanceFact
GROUP BY RecordID
HAVING COUNT(*) > 1;

-- Missing critical metric values
SELECT *
FROM PerformanceFact
WHERE MetricValue IS NULL;

-- Invalid date logic
SELECT *
FROM PerformanceFact
WHERE ProcessedDate < CreatedDate;
