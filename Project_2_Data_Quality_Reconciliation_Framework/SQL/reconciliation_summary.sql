/* Reconciliation Summary: Source A vs Source B
   Example scenario:
   - SourceA_Fact: operational/transaction system totals
   - SourceB_Fact: finance/ledger/reporting system totals
*/

WITH a AS (
    SELECT
        BusinessUnit,
        MetricCategory,
        SUM(MetricValue) AS TotalA
    FROM SourceA_Fact
    GROUP BY BusinessUnit, MetricCategory
),
b AS (
    SELECT
        BusinessUnit,
        MetricCategory,
        SUM(MetricValue) AS TotalB
    FROM SourceB_Fact
    GROUP BY BusinessUnit, MetricCategory
)
SELECT
    COALESCE(a.BusinessUnit, b.BusinessUnit) AS BusinessUnit,
    COALESCE(a.MetricCategory, b.MetricCategory) AS MetricCategory,
    ISNULL(a.TotalA, 0) AS Total_SourceA,
    ISNULL(b.TotalB, 0) AS Total_SourceB,
    ISNULL(a.TotalA, 0) - ISNULL(b.TotalB, 0) AS Variance,
    CASE
        WHEN ABS(ISNULL(a.TotalA, 0) - ISNULL(b.TotalB, 0)) = 0 THEN 'MATCH'
        WHEN ABS(ISNULL(a.TotalA, 0) - ISNULL(b.TotalB, 0)) <= 10 THEN 'MINOR VARIANCE'
        ELSE 'MISMATCH'
    END AS ReconStatus
FROM a
FULL OUTER JOIN b
    ON a.BusinessUnit = b.BusinessUnit
    AND a.MetricCategory = b.MetricCategory
ORDER BY ReconStatus DESC, ABS(ISNULL(a.TotalA, 0) - ISNULL(b.TotalB, 0)) DESC;
