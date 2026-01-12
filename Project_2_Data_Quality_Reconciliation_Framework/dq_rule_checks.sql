/* =========================================================
   Data Quality Rule Checks (Claims Model) - Summary Output
   Output: RuleName | FailedCount | Status
   ========================================================= */

WITH dq AS (

    -- Rule 1: Duplicate Claim IDs
    SELECT 'Duplicate ClaimID' AS RuleName, COUNT(*) AS FailedCount
    FROM (
        SELECT ClaimID
        FROM dbo.ClaimFact
        GROUP BY ClaimID
        HAVING COUNT(*) > 1
    ) d

    UNION ALL

    -- Rule 2: Missing Facility mapping
    SELECT 'Missing FacilityDim mapping' AS RuleName, COUNT(*) AS FailedCount
    FROM dbo.ClaimFact cf
    LEFT JOIN dbo.FacilityDim fd
        ON cf.FacilityKey = fd.FacilityKey
    WHERE fd.FacilityKey IS NULL

    UNION ALL

    -- Rule 3: Missing Patient mapping
    SELECT 'Missing PatientDim mapping' AS RuleName, COUNT(*) AS FailedCount
    FROM dbo.ClaimFact cf
    LEFT JOIN dbo.PatientDim pd
        ON cf.PatientKey = pd.PatientKey
    WHERE pd.PatientKey IS NULL

    UNION ALL

    -- Rule 4: Missing Enrollment mapping (if claims should always have enrollment)
    SELECT 'Missing EnrollmentDim mapping' AS RuleName, COUNT(*) AS FailedCount
    FROM dbo.ClaimFact cf
    LEFT JOIN dbo.EnrollmentDim ed
        ON cf.EnrollmentKey = ed.EnrollmentKey
    WHERE cf.EnrollmentKey IS NOT NULL
      AND ed.EnrollmentKey IS NULL

    UNION ALL

    -- Rule 5: Financial nulls
    SELECT 'Null NetPay/Allowed/Billed Amount' AS RuleName, COUNT(*) AS FailedCount
    FROM dbo.ClaimFact
    WHERE NetPayAmount IS NULL
       OR AllowedAmount IS NULL
       OR BilledAmount IS NULL

    UNION ALL

    -- Rule 6: Negative amounts (unless your business allows it)
    SELECT 'Negative financial amounts' AS RuleName, COUNT(*) AS FailedCount
    FROM dbo.ClaimFact
    WHERE NetPayAmount < 0
       OR AllowedAmount < 0
       OR BilledAmount < 0

    UNION ALL

    -- Rule 7: Paid > Allowed (common check)
    SELECT 'NetPay > AllowedAmount' AS RuleName, COUNT(*) AS FailedCount
    FROM dbo.ClaimFact
    WHERE NetPayAmount > AllowedAmount

    UNION ALL

    -- Rule 8: Claim Paid date before Claim Received date
    SELECT 'PaidDate < ReceivedDate' AS RuleName, COUNT(*) AS FailedCount
    FROM dbo.ClaimFact
    WHERE PaidDate IS NOT NULL
      AND ReceivedDate IS NOT NULL
      AND PaidDate < ReceivedDate
)
SELECT
    RuleName,
    FailedCount,
    CASE WHEN FailedCount = 0 THEN 'PASS' ELSE 'FAIL' END AS Status
FROM dq
ORDER BY Status DESC, FailedCount DESC;
