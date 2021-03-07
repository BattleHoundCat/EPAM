USE Northwind;
GO

SELECT OrderID,
CASE 
WHEN ShippedDate IS NULL THEN N'Not Shipped'
END 
FROM dbo.Orders AS [Order-Task-2-1-3]
WHERE ShippedDate > CONVERT(datetime, '19980506') OR ShippedDate IS NULL;
GO