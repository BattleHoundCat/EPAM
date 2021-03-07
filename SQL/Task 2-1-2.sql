USE Northwind;
GO

SELECT OrderID,
CASE 
WHEN ShippedDate IS NULL THEN N'Not Shipped'
END AS NoShipment
FROM dbo.Orders AS [Orders-Task-2-1-2]
WHERE ShippedDate IS NULL;
GO