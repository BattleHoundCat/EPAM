USE Northwind;
GO

SELECT Сотрудник.LastName AS [User Name], Руководитель.LastName AS [Boss]
FROM dbo.Employees AS Сотрудник LEFT JOIN dbo.Employees AS Руководитель ON Сотрудник.ReportsTo = Руководитель.EmployeeID;