/* Data Quality Rule Checks - Summary Level
   Produces a simple output that can feed SSRS/Power BI:
   RuleName | FailedCount | Status
*/

WITH dq AS (
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
)
SELECT
    RuleName,
    FailedCount,
    CASE WHEN FailedCount = 0 THEN 'PASS' ELSE 'FAIL' END AS Status
FROM dq
ORDER BY Status DESC, FailedCount DESC;

