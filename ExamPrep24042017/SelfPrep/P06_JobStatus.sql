

SELECT Status,IssueDate
FROM Jobs
WHERE Status IN ('Pending','In Progress')
ORDER BY IssueDate,JobId