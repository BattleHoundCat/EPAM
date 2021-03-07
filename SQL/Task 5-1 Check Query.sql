USE NORTHWIND;
GO

DECLARE @TargetYear INT
SET @TargetYear = 1996

EXEC dbo.GreatestOrders @TargetYear;

SELECT E.FirstName + ' ' + E.LastName AS ФИО,O.OrderID, OD.UnitPrice*OD.Discount*OD.Quantity AS Стоимость,
YEAR(O.OrderDate) AS Год
FROM dbo.Employees AS E INNER JOIN dbo.Orders AS O ON E.EmployeeID = O.EmployeeID
INNER JOIN dbo.[Order Details] AS OD ON O.OrderID = OD.OrderID
WHERE YEAR(O.OrderDate) = @TargetYear 
ORDER BY ФИО,Стоимость DESC;
GO

