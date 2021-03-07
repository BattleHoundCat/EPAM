USE Northwind;
GO


SELECT DISTINCT C.CustomerID AS CustomerID, C.City AS City 
FROM dbo.Customers AS C INNER JOIN dbo.Customers AS CS ON C.City = CS.City
WHERE C.City IN (SELECT CR.City AS TargetCity
FROM dbo.Customers AS CR
GROUP By (CR.City)
HAVING COUNT(CR.City) > 1)
ORDER BY C.City;
GO

