SELECT
    BusinessUnit,
    MetricCategory,
    COUNT(DISTINCT RecordID) AS TotalRecords,
    SUM(MetricValue) AS TotalValue
FROM PerformanceFact
GROUP BY BusinessUnit, MetricCategory;
