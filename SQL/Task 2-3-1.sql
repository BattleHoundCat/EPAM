USE Northwind;
GO

SELECT OrderID
FROM dbo.[Order Details] AS [OrderDetail-Task-2-3-1]
WHERE Quantity BETWEEN 3 AND 10;
GO