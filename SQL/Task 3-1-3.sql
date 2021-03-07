USE Northwind;
GO

SELECT COUNT(DISTINCT O.CustomerID) AS [”никальные клиенты]
From dbo.Orders AS O;
GO