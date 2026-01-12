/* Data Quality Rule Checks - Summary Level
   Output: RuleName | FailedCount | Status
*/

SELECT
    d.RuleName,
    d.FailedCount,
    CASE WHEN d.FailedCount = 0 THEN 'PASS' ELSE 'FAIL' END AS Status
FROM (
    SELECT
        'Missing MetricValue' AS RuleName,
        COUNT(*) AS FailedCount
    FROM PerformanceFact
    WHERE MetricValue IS NULL

    UNION ALL

    SELECT
        'Invalid Date Logic (Processed < Created)' AS RuleName,
        COUNT(*) AS FailedCount
    FROM PerformanceFact
    WHERE ProcessedDate < CreatedDate

    UNION ALL

    SELECT
        'Missing BusinessUnit' AS RuleName,
        COUNT(*) AS FailedCount
    FROM PerformanceFact
    WHERE BusinessUnit IS NULL OR LTRIM(RTRIM(BusinessUnit)) = ''

    UNION ALL

    SELECT
        'Negative MetricValue' AS RuleName,
        COUNT(*) AS FailedCount
    FROM PerformanceFact
    WHERE MetricValue < 0
) d
ORDER BY
    CASE WHEN d.FailedCount = 0 THEN 1 ELSE 0 END,  -- FAIL first
    d.FailedCount DESC;
