USE Northwind;
GO

SELECT OD.*
FROM dbo.Orders AS O INNER JOIN dbo.[Order Details] AS OD ON O.OrderID = OD.OrderID
WHERE (OD.Quantity*OD.UnitPrice) < 20;

DELETE O
OUTPUT deleted.*
FROM dbo.Orders AS O
JOIN dbo.[Order Details] AS OD ON O.OrderID = OD.OrderID
WHERE (OD.Quantity*OD.UnitPrice) < 20;
GO




