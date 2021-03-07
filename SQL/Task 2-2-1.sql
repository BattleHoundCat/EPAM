USE Northwind;
GO

SELECT ContactName,Country FROM dbo.Customers AS [Customers-Task-2-2-1]
WHERE Country IN ('USA','Canada')
ORDER BY ContactName,Country ;
GO