# KPI Measures (DAX)

## Total Metric Value
Total Metric Value :=
SUM ( PerformanceFact[MetricValue] )

## Average Metric Value
Average Metric Value :=
AVERAGE ( PerformanceFact[MetricValue] )

## KPI Achievement %
KPI Achievement % :=
DIVIDE (
    [Total Metric Value],
    CALCULATE (
        [Total Metric Value],
        REMOVEFILTERS ( PerformanceFact )
    )
)

## KPI Contribution %
KPI Contribution % :=
DIVIDE (
    [Total Metric Value],
    CALCULATE (
        [Total Metric Value],
        ALL ( PerformanceFact[BusinessUnit] )
    )
)
