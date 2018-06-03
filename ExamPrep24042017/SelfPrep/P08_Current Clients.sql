SELECT c.FirstName+' '+c.LastName AS Clients,
		DATEDIFF(DAY,j.IssueDate,'04-24-2017') AS [Days going],
		j.Status
FROM Jobs AS j
JOIN Clients AS c ON c.ClientId=j.ClientId
WHERE j.Status IN ('In Progress','Pending')