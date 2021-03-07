USE Northwind;
GO

SELECT C.ContactName AS ContactName, Count(O.OrderID) AS [Всего заказов]
FROM dbo.Orders AS O FULL OUTER JOIN dbo.Customers AS C ON O.CustomerID = C.CustomerID
GROUP BY C.ContactName
ORDER BY [Всего заказов] ASC;
GO