USE Northwind;
GO

SELECT * FROM dbo.Orders;

CREATE TABLE dbo.OrdersHistory
(
    ID INT IDENTITY PRIMARY KEY,
    OrderId INT NOT NULL,
	CustomerId  NVARCHAR(50) NOT NULL,
	EmployeeId INT NOT NULL,
    Operation NVARCHAR(200) NOT NULL,
    CreateAt DATETIME NOT NULL DEFAULT GETDATE(),
);
GO

CREATE TRIGGER Orders_INSERT
ON dbo.Orders
AFTER INSERT
AS
INSERT INTO dbo.OrdersHistory (OrderId,CustomerId,EmployeeId, Operation)
SELECT OrderID, CustomerID, EmployeeID,'Добавлен заказ'
FROM INSERTED;
GO

SELECT * FROM dbo.OrdersHistory;

INSERT INTO dbo.Orders(CustomerID,EmployeeID)
VALUES(N'BONAP',5)
GO

CREATE TRIGGER Orders_DELETE
ON dbo.Orders
AFTER DELETE
AS
INSERT INTO dbo.OrdersHistory (OrderId,CustomerId,EmployeeId, Operation)
SELECT OrderID, CustomerID, EmployeeID,'Удален заказ'
FROM DELETED;
GO

DELETE FROM dbo.Orders
WHERE OrderID >11076;
GO

CREATE TRIGGER Orders_UPDATE
ON dbo.Orders
AFTER UPDATE
AS
INSERT INTO dbo.OrdersHistory (OrderId,CustomerId,EmployeeId, Operation)
SELECT OrderID, CustomerID, EmployeeID,'Обновлен заказ'
FROM INSERTED
 
UPDATE dbo.Orders SET CustomerID = N'PERIC' , EmployeeID =2
WHERE OrderID >11076;