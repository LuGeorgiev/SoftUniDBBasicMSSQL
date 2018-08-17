

SELECT u.Username
FROM Reports AS r
JOIN Users AS u ON r.UserId=u.Id
JOIN Categories AS c ON r.CategoryId=c.Id
WHERE LEFT(Username,1)=CONCAT(c.Id,'')
	OR RIGHT(Username,1)=CONCAT(c.Id,'')
GROUP BY u.Username
ORDER BY Username

-- Ani way

SELECT u.Username
FROM Reports AS r
JOIN Users AS u ON r.UserId=u.Id
JOIN Categories AS c ON r.CategoryId=c.Id
WHERE LEFT(Username,1) LIKE '[0-9]' 
AND CONVERT(VARCHAR(10),c.Id) =LEFT(Username,1)
OR RIGHT(Username,1) LIKE '[0-9]' 
AND CONVERT(VARCHAR(10),c.Id) =RIGHT(Username,1) 
GROUP BY u.Username --OR USE DISTINCT
ORDER BY Username