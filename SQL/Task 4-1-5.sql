USE Northwind;
GO

SELECT OD.* 
FROM dbo.Orders AS O INNER JOIN dbo.[Order Details] AS OD ON O.OrderID = OD.OrderID
INNER JOIN dbo.Products AS P ON OD.ProductID = P.ProductID
WHERE O.CustomerID = 'GODOS' AND P.ProductName = 'Tarte au sucre' ;

UPDATE dbo.[Order Details]
SET Discount= RAND()*(0.99 - 0.01)
FROM dbo.Orders AS O
INNER JOIN dbo.[Order Details] AS OD ON O.OrderID = OD.OrderID
INNER JOIN dbo.Products AS P ON OD.ProductID = P.ProductID
WHERE O.CustomerID = 'GODOS' AND P.ProductName = 'Tarte au sucre' ;
GO

DELETE FROM dbo.Orders
OUTPUT deleted.*
WHERE YEAR(ShippedDate) = '2021';