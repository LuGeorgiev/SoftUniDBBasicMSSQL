USE ReportService


SELECT [Category Name],
   SUM([Reports]) AS [Reports Number],
   [Main Status]
FROM(
	SELECT [Category Name],
			[Reports],
			CASE
				WHEN [Category Name]= LEA THEN 'equal'
				ELSE [Status]
			END
			AS [Main Status]
	FROM(
		SELECT [Category Name],
				[Reports],
				[Status],
				LEAD([Category Name],1) OVER(ORDER BY [Category Name])AS LEA
		FROM(
			SELECT c.Name as [Category Name],
					 Count(*) as [Reports], s.Label AS [Status],
				DENSE_RANK() OVER(PARTITION BY c.Name, s.Label ORDER BY c.Name, Count(*)) AS Ranked
			FROM Categories AS c
			JOIN Reports AS r ON r.CategoryId=c.Id
			JOIN Status AS s ON s.Id=r.StatusId
			WHERE r.StatusId IN (1,2) 
			GROUP BY c.Name, s.Label
			) As e
		WHERE Ranked=1
		) AS em
	) AS eme
	GROUP BY [Category Name],[Main Status]

	--ANI way
	SELECT c.Name,
		COUNT(r.Id) AS [Reports Name],
		CASE
			WHEN SUM(CASE WHEN r.StatusId=2 THEN 1 ELSE 0 END)>
			 SUM(CASE WHEN r.StatusId=1 THEN 1 ELSE 0 END) THEN 'in progress'
			WHEN SUM(CASE WHEN r.StatusId=2 THEN 1 ELSE 0 END)<
			 SUM(CASE WHEN r.StatusId=1 THEN 1 ELSE 0 END) THEN 'waiting'
			ELSE 'eqial'
		END AS MainStatus
	FROM Reports AS r
	JOIN Categories AS c ON r.CategoryId=c.Id
	WHERE r.StatusId IN (1,2) 
	GROUP BY c.Name

	--Author way

	SELECT c.Name,
	  COUNT(r.Id) AS ReportsNumber,
	  CASE 
	      WHEN InProgressCount > WaitingCount THEN 'in progress'
		  WHEN InProgressCount < WaitingCount THEN 'waiting'
		  ELSE 'equal'
	  END AS MainStatus	  
FROM Reports AS r
    JOIN Categories AS c ON c.Id = r.CategoryId
    JOIN Status AS s ON s.Id = r.StatusId
    JOIN (SELECT r.CategoryId, 
		         SUM(CASE WHEN s.Label = 'in progress' THEN 1 ELSE 0 END) as InProgressCount,
		         SUM(CASE WHEN s.Label = 'waiting' THEN 1 ELSE 0 END) as WaitingCount
		  FROM Reports AS r
		  JOIN Status AS s on s.Id = r.StatusId
		  WHERE s.Label IN ('waiting','in progress')
		  GROUP BY r.CategoryId
		 ) AS sc ON sc.CategoryId = c.Id
WHERE s.Label IN ('waiting','in progress') 
GROUP BY C.Name,
	     CASE 
		     WHEN InProgressCount > WaitingCount THEN 'in progress'
		     WHEN InProgressCount < WaitingCount THEN 'waiting'
		     ELSE 'equal'
	     END
ORDER BY C.Name, 
		 ReportsNumber, 
		 MainStatus;