USE Northwind;
GO

SELECT  Count(OrderID) AS Количество, YEAR(O.OrderDate) AS [По годам]
FROM dbo.Orders AS O
GROUP BY YEAR(O.OrderDate)
ORDER BY [По годам];
GO

SELECT COUNT(*) AS [Всего заказов]
From dbo.Orders AS O;
GO
