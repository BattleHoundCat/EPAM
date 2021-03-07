USE Northwind;
GO

CREATE PROCEDURE dbo.ShippedOrdersDiff @SpecDelay INT AS 
BEGIN
	SELECT OrderID,OrderDate,ShippedDate, DATEDIFF(day,OrderDate,ShippedDate ) AS ShippedDelay , @SpecDelay    FROM dbo.Orders
	WHERE DATEDIFF(day,OrderDate,ShippedDate ) > @SpecDelay OR DATEDIFF(day,OrderDate,ShippedDate ) IS NULL
	ORDER BY ShippedDelay ;
END;

EXEC dbo.ShippedOrdersDiff 35
