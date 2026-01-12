/* Exception Report
   Captures detailed records failing key DQ rules.
   This output can be exported to Excel or consumed by SSRS.
*/

SELECT
    RecordID,
    BusinessUnit,
    MetricCategory,
    MetricValue,
    CreatedDate,
    ProcessedDate,
    CASE
        WHEN MetricValue IS NULL THEN 'MetricValue is NULL'
        WHEN ProcessedDate < CreatedDate THEN 'ProcessedDate < CreatedDate'
        WHEN BusinessUnit IS NULL OR LTRIM(RTRIM(BusinessUnit)) = '' THEN 'BusinessUnit missing'
        WHEN MetricValue < 0 THEN 'MetricValue is negative'
        ELSE 'Other'
    END AS ExceptionReason
FROM PerformanceFact
WHERE
    MetricValue IS NULL
    OR ProcessedDate < CreatedDate
    OR BusinessUnit IS NULL OR LTRIM(RTRIM(BusinessUnit)) = ''
    OR MetricValue < 0
ORDER BY ExceptionReason, BusinessUnit, MetricCategory;
