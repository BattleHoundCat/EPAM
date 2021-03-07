USE Northwind;
GO

SELECT ContactName,Country FROM dbo.Customers AS [Customers-Task-2-2-2]
WHERE Country NOT IN ('USA','Canada')
ORDER BY ContactName ;
GO