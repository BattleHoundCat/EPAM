USE Northwind;
GO

SELECT * FROM dbo.Orders AS O;

INSERT INTO dbo.Orders (ShipCountry)
VALUES (N'Russia1'),(N'Russia2'),(N'Russia3'),(N'Russia4'),(N'Russia5');

INSERT INTO dbo.Orders (ShipCountry)
SELECT ShipCountry FROM dbo.Orders AS O2
WHERE O2.OrderID BETWEEN 10248 AND 10252;

DELETE FROM dbo.Orders
OUTPUT deleted.*
WHERE OrderID > 11077;