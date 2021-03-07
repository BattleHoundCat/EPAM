USE NORTHWIND;
GO
CREATE PROCEDURE dbo.GreatestOrders @TargetYear INT AS 
BEGIN
	CREATE TABLE #tempTable (ФИО NVARCHAR(25) NULL,OrderID INT NOT NULL , Стоимость MONEY NOT NULL, Год INT NOT NULL);

	INSERT INTO #tempTable
	SELECT E.FirstName + ' ' + E.LastName AS ФИО,O.OrderID, OD.UnitPrice*OD.Discount*OD.Quantity AS Стоимость,
	YEAR(O.OrderDate) AS Год
	FROM dbo.Employees AS E INNER JOIN dbo.Orders AS O ON E.EmployeeID = O.EmployeeID
	INNER JOIN dbo.[Order Details] AS OD ON O.OrderID = OD.OrderID
	WHERE YEAR(O.OrderDate) = @TargetYear 
	ORDER BY ФИО,Стоимость DESC;

	--SELECT * FROM #tempTable;

	CREATE TABLE #tempEmpAndMax (ФИО NVARCHAR(25) NULL,Стоимость MONEY NOT NULL);
	INSERT INTO #tempEmpAndMax
	SELECT DISTINCT ФИО, MAX(Стоимость) AS MyMax FROM #tempTable 
	GROUP BY ФИО;

	--SELECT * FROM #tempEmpAndMax;

	SELECT T.ФИО,T.OrderID,T.Стоимость FROM #tempTable AS T
	WHERE T.Стоимость IN (SELECT EM.Стоимость FROM #tempEmpAndMax AS EM)
	ORDER BY T.Стоимость DESC;
END;

EXEC dbo.GreatestOrders 1996

