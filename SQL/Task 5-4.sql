USE Northwind;
GO

CREATE VIEW MyView
AS
SELECT O.OrderID , O.CustomerID , E.FirstName + ' ' + E.LastName AS Fullname , O.OrderDate, O.RequiredDate, P.ProductName, OD.UnitPrice*OD.Discount AS FullPrice
FROM dbo.Orders AS O INNER JOIN dbo.Employees AS E ON O.EmployeeID = E.EmployeeID
INNER JOIN dbo.[Order Details] AS OD ON O.OrderID = OD.OrderID
INNER JOIN dbo.Products AS P ON OD.ProductID = P.ProductID;
GO

SELECT * FROM MyView
ORDER BY FullPrice DESC;
