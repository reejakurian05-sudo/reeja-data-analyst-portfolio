/* =========================================================
   Duplicate Detection - Business Key Level
   Example: duplicates at ClaimID+ClaimLine (or ClaimID only)
   ========================================================= */

-- A) Duplicate ClaimID
SELECT
    cf.ClaimID,
    COUNT(*) AS DuplicateCount
FROM dbo.ClaimFact cf
GROUP BY cf.ClaimID
HAVING COUNT(*) > 1
ORDER BY DuplicateCount DESC;

-- B) If you have ClaimLineNumber in ClaimFact
-- SELECT cf.ClaimID, cf.ClaimLineNumber, COUNT(*) AS DuplicateCount
-- FROM dbo.ClaimFact cf
-- GROUP BY cf.ClaimID, cf.ClaimLineNumber
-- HAVING COUNT(*) > 1
-- ORDER BY DuplicateCount DESC;
