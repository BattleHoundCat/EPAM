USE Northwind;
GO


INSERT INTO dbo.Orders (ShipCountry)
VALUES (N'Russia');

INSERT INTO dbo.Orders (ShipCountry)
SELECT ShipCountry FROM dbo.Orders AS O2
WHERE O2.OrderID = 10248;

DELETE FROM dbo.Orders
OUTPUT deleted.*
WHERE OrderID > 11077;