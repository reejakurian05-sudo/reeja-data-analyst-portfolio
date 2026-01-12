# Data Quality & Reconciliation Framework (Enterprise)

## Business Problem
Organizations often face reporting inconsistencies due to:
- duplicates across source systems
- missing critical values
- mismatched totals between systems (GL vs Subledger / Claims vs Payments)
- invalid dates or orphan records

This reduces trust in dashboards, slows decision-making, and increases manual reconciliation work.

## Objective
Build a reusable SQL-based framework to:
- standardize data quality (DQ) checks
- generate exception reports for remediation
- reconcile key totals between two systems (Source A vs Source B)
- provide audit-friendly summaries for business and leadership

## Tools Used
- SQL Server
- Power BI / SSRS (for reporting exceptions)
- Excel (quick QA & stakeholder review)

## Outputs
- DQ Rule Checks (Pass/Fail + counts)
- Exception Report (records to fix)
- Reconciliation Summary (Source A vs Source B totals)
- Duplicate Detection (key-based duplicates)
