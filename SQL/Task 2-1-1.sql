USE Northwind;
GO

SELECT OrderID AS OrderID,ShippedDate AS ShippedDate,ShipVia 
FROM dbo.Orders AS [Orders-Task-2-1-1]
WHERE ShippedDate >= CONVERT(datetime, '19980506') AND ShipVia>=2;
GO