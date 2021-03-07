USE Northwind;
GO

SELECT ISNULL((SELECT E.LastName FROM dbo.Employees AS E WHERE E.EmployeeID = O.EmployeeID),N'ALL') AS Seller, ISNULL(O.CustomerID,N'ALL') AS Customer, COUNT(*) AS Amount 
FROM dbo.Orders AS O INNER JOIN dbo.Employees AS E ON O.EmployeeID = E.EmployeeID
INNER JOIN dbo.Customers AS C ON O.CustomerID = C.CustomerID
WHERE YEAR(O.OrderDate) = '1998'
GROUP BY CUBE (O.EmployeeID, O.CustomerID)
ORDER BY COUNT(*) DESC;
