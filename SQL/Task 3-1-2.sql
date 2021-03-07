USE Northwind;
GO

SELECT Count(*) - COUNT(ShippedDate) AS NotNullCount
From dbo.Orders AS Orders;
GO
