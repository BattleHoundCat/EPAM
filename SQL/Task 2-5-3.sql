USE Northwind;
GO

SELECT S.CompanyName AS CompanyName, P.UnitsInStock AS UnitsInStock
FROM dbo.Suppliers AS S INNER JOIN dbo.Products AS P ON S.SupplierID = P.SupplierID
WHERE P.UnitsInStock =0;
GO
