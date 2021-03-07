USE Northwind;
GO

SELECT * FROM dbo.Employees ;

SELECT  Сотрудник.EmployeeID,Сотрудник.LastName AS [User Name], Руководитель.LastName AS [Boss], Сотрудник.ReportsTo
FROM dbo.Employees AS Сотрудник LEFT JOIN dbo.Employees AS Руководитель ON Сотрудник.ReportsTo = Руководитель.EmployeeID;
GO

CREATE FUNCTION IsBoss(@EmpID INT)
RETURNS BIT
AS
BEGIN
 DECLARE @Final BIT
 SELECT @Final = ReportsTo FROM dbo.Employees WHERE ReportsTo = @EmpID
	RETURN @Final
END ;
GO

SELECT dbo.IsBoss(2);

