USE Northwind;
GO


INSERT INTO dbo.Orders (CustomerID,EmployeeID,OrderDate,RequiredDate,ShippedDate,ShipCountry)
SELECT CustomerID,EmployeeID,OrderDate,RequiredDate,ShippedDate,ShipCountry FROM dbo.Orders AS O2
WHERE O2.CustomerID =N'WARTH' AND O2.EmployeeID=5;
GO
UPDATE dbo.Orders 
SET CustomerID =N'TOMSP'
OUTPUT N'Заменили', deleted.*, inserted.*
WHERE CustomerID =N'WARTH' AND OrderID >11077;
GO

DELETE FROM dbo.Orders
OUTPUT deleted.*
WHERE OrderID > 11077;