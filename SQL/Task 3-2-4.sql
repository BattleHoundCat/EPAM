USE Northwind;
GO


SELECT LastName + ' ' + FirstName AS Person, E.City AS City , N'Seller' AS Type
FROM dbo.Employees AS E
WHERE E.City IN (
SELECT E.City FROM dbo.Employees AS E
INTERSECT
SELECT C.City FROM dbo.Customers AS C)
UNION
SELECT ContactName AS Person, C.City  AS City , N'Customer' AS Type
FROM dbo.Customers AS C
WHERE C.City IN (
SELECT E.City FROM dbo.Employees AS E
INTERSECT
SELECT C.City FROM dbo.Customers AS C)
ORDER BY City, Person
