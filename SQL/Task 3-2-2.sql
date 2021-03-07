USE Northwind;
GO

SELECT (
SELECT CONCAT(E.LastName, + ' ' ,+ E.FirstName) 
FROM dbo.Employees AS E
WHERE E.EmployeeID = O.EmployeeID
) AS Seller,O.EmployeeID, Count (O.OrderID) AS Amount
FROM dbo.Orders AS O
GROUP BY O.EmployeeID
ORDER BY COUNT(O.OrderID) DESC;
GO

