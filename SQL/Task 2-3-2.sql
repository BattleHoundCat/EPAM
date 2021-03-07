USE Northwind;
GO

SELECT CustomerID,Country
FROM dbo.Customers AS [Customers-Task-2-3-2]
WHERE Country BETWEEN 'b' AND 'gf'
ORDER BY Country;
GO
--сравнение двух скриптов Task 2-3-2 и Task 2-3-3 вообще не дали никаких различий. 
--Одинаково по всем параметрам выполняются