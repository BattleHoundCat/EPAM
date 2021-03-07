USE Northwind;
GO

SELECT E.LastName AS LastName, Ter.TerritoryDescription AS TerrDesc
FROM dbo.Employees As E
INNER JOIN dbo.EmployeeTerritories AS ET ON E.EmployeeID = ET.EmployeeID
INNER JOIN dbo.Territories AS Ter ON ET.TerritoryID = Ter.TerritoryID
INNER JOIN dbo.Region AS R ON Ter.RegionID = R.RegionID
WHERE RegionDescription =N'Western';
GO