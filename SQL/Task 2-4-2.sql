USE Northwind;
GO

SELECT DISTINCT SUBSTRING(LastName,1,1) AS [EmpLastNames]
FROM dbo.Employees AS [Employees-Task-2-4-2]
ORDER BY [EmpLastNames] ASC;
GO