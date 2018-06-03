--CTE i snot working and I cannot understand why
WITH CTE_VendorPref
AS
(
SELECT m.MechanicId,		
		v.VendorId,
		SUM(op.Quantity) AS ItemsFromVendor
FROM Mechanics AS m
JOIN Jobs As j ON j.MechanicId=m.MechanicId
JOIN Orders AS o ON o.JobId=j.JobId
JOIN OrderParts AS op ON op.OrderId=o.OrderId
JOIN Parts AS p ON p.PartId=op.PartId
JOIN  Vendors AS v ON v.VendorId=p.VendorId
GROUP BY m.MechanicId, v.VendorId
)

SELECT c.MechanicId,
		v.VendorId	
FROM CTE_VendorPref AS c
JOIN Mechanics As m ON m.MechanicId=c.MechanicId
JOIN  Vendors AS v ON v.VendorId=c.VendorId



--My try
SELECT *
FROM (SELECT m.FirstName +m.LastName AS Mechanic,
		v.Name AS Vendr,
		SUM(op.Quantity) AS Parts
		FROM Mechanics AS m
		RIGHT JOIN Jobs As j ON j.MechanicId=m.MechanicId
		RIGHT JOIN Orders AS o ON o.JobId=j.JobId
		RIGHT JOIN OrderParts AS op ON op.OrderId=o.OrderId
		RIGHT JOIN Parts AS p ON p.PartId=op.PartId
		LEFT JOIN  Vendors AS v ON v.VendorId=p.VendorId
		GROUP BY m.MechanicId,m.FirstName,m.LastName,v.Name)