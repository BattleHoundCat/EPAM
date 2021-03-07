USE Northwind;
GO

SELECT Convert(money,ROUND(SUM((OD.UnitPrice*(1-OD.Discount))*OD.Quantity),2),1) AS Totals
FROM dbo.[Order Details] AS OD;
GO
