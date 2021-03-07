USE Northwind;
GO

SELECT * FROM dbo.Orders AS O
WHERE ShippedDate IS NULL;

UPDATE dbo.Orders 
SET ShippedDate = Null
OUTPUT N'Заменили', deleted.*, inserted.*
WHERE YEAR(ShippedDate) = '2021';
GO
