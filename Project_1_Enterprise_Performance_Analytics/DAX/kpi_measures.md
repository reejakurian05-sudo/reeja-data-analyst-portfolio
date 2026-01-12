# KPI Measures (DAX)

## Total Metric Value
Total Metric Value :=
SUM(PerformanceFact[MetricValue])
# KPI Measures (DAX)

## Total Metric Value
Total Metric Value :=
SUM(PerformanceFact[MetricValue])

## Average Metric Value :=
AVERAGE(PerformanceFact[MetricValue])

##KPI Achievement % :=
DIVIDE(
    [Total Metric Value],
    CALCULATE(
        [Total Metric Value],
        REMOVEFILTERS(PerformanceFact)
    )
)
