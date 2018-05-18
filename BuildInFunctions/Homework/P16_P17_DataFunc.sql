USE Orders

--P16

SELECT ProductName,
	   OrderDate,
	   DATEADD(DAY,3,OrderDate) AS [Pay Due],
	   DATEADD(MONTH,1,OrderDate) AS [Delivery Due]
  FROM Orders

  --P17 Do not have the table