
/*
1.  Написать процедуру, которая возвращает самый крупный заказ для 
каждого из продавцов за определенный год.  
В результатах не может быть несколько заказов одного продавца, должен быть 
только один и самый крупный.  
В результатах запроса должны быть выведены следующие колонки: колонка с 
именем и фамилией продавца (FirstName и LastName – пример: Nancy Davolio), 
номер заказа и его стоимость.  
В запросе надо учитывать Discount при продаже товаров.  
Процедуре передается год, за который надо сделать отчет, и количество 
возвращаемых записей.  
Результаты запроса должны быть упорядочены по убыванию суммы заказа.  
Процедура должна быть реализована 2-мя способами с использованием 
оператора SELECT и с использованием курсора.  
Название процедур соответственно GreatestOrders и GreatestOrdersCur.  
Необходимо продемонстрировать использование этих процедур.  
 
Также помимо демонстрации вызовов процедур в скрипте Query.sql надо 
написать отдельный ДОПОЛНИТЕЛЬНЫЙ проверочный запрос для тестирования 
правильности работы процедуры GreatestOrders.  
Проверочный запрос должен выводить в удобном для сравнения с результатами 
работы процедур виде для определенного продавца для всех его заказов за 
определенный указанный год в результатах следующие колонки: имя продавца, 
номер заказа, сумму заказа.  
Проверочный запрос не должен повторять запрос, написанный в процедуре, - он 
должен выполнять только то, что описано в требованиях по нему. 
ВСЕ ЗАПРОСЫ ПО ВЫЗОВУ ПРОЦЕДУР ДОЛЖНЫ БЫТЬ НАПИСАНЫ В ФАЙЛЕ 
Query.sql 
*/

-- процедура GreatestOrders
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


	CREATE TABLE #tempEmpAndMax (ФИО NVARCHAR(25) NULL,Стоимость MONEY NOT NULL);
	INSERT INTO #tempEmpAndMax
	SELECT DISTINCT ФИО, MAX(Стоимость) AS MyMax FROM #tempTable 
	GROUP BY ФИО;


	SELECT T.ФИО,T.OrderID,T.Стоимость FROM #tempTable AS T
	WHERE T.Стоимость IN (SELECT EM.Стоимость FROM #tempEmpAndMax AS EM)
	ORDER BY T.Стоимость DESC;
END;

EXEC dbo.GreatestOrders 1996
GO

--процедура с использование курсора GreatestOrdersCur
CREATE PROCEDURE dbo.GreatestOrdersCur @TargetYear INT AS 
BEGIN
	CREATE TABLE #tempTable (ФИО NVARCHAR(25) NULL,OrderID INT NOT NULL , Стоимость MONEY NOT NULL, Год INT NOT NULL);

	INSERT INTO #tempTable
	SELECT E.FirstName + ' ' + E.LastName AS ФИО,O.OrderID, OD.UnitPrice*OD.Discount*OD.Quantity AS Стоимость,
	YEAR(O.OrderDate) AS Год
	FROM dbo.Employees AS E INNER JOIN dbo.Orders AS O ON E.EmployeeID = O.EmployeeID
	INNER JOIN dbo.[Order Details] AS OD ON O.OrderID = OD.OrderID
	WHERE YEAR(O.OrderDate) = @TargetYear 
	ORDER BY ФИО,Стоимость DESC;


	CREATE TABLE #tempEmpAndMax (ФИО NVARCHAR(25) NULL,Стоимость MONEY NOT NULL);
	INSERT INTO #tempEmpAndMax
	SELECT DISTINCT ФИО, MAX(Стоимость) AS MyMax FROM #tempTable 
	GROUP BY ФИО;

	DECLARE @FullName NVARCHAR(50)
	DECLARE @Order int
	DEClARE @Value MONEY

	DECLARE my_cur CURSOR FOR
	SELECT T.ФИО,T.OrderID,T.Стоимость FROM #tempTable AS T
	WHERE T.Стоимость IN (SELECT EM.Стоимость FROM #tempEmpAndMax AS EM)
	ORDER BY T.Стоимость DESC

	OPEN my_cur

	FETCH NEXT FROM my_cur INTO @FullName, @Order,@Value
	WHILE @@FETCH_STATUS =0
		BEGIN
			--Print @FullName + ' ; '+ @Order + ' ; ' +@Value
			PRINT CONCAT('FullName: ',  @FullName , ' / Order : ', @Order, ' / Value: ', @Value)
			FETCH NEXT FROM my_cur INTO @FullName, @Order,@Value
		END
	CLOSE my_cur
	DEALLOCATE my_cur
END;

EXEC dbo.GreatestOrdersCur 1996
GO

--проверочный запрос
DECLARE @TargetYear INT
SET @TargetYear = 1996

EXEC dbo.GreatestOrders @TargetYear;

SELECT E.FirstName + ' ' + E.LastName AS ФИО,O.OrderID, OD.UnitPrice*OD.Discount*OD.Quantity AS Стоимость,
YEAR(O.OrderDate) AS Год
FROM dbo.Employees AS E INNER JOIN dbo.Orders AS O ON E.EmployeeID = O.EmployeeID
INNER JOIN dbo.[Order Details] AS OD ON O.OrderID = OD.OrderID
WHERE YEAR(O.OrderDate) = @TargetYear 
ORDER BY ФИО,Стоимость DESC;
GO

/*
2.  Написать процедуру, которая возвращает заказы в таблице Orders, 
согласно указанному сроку доставки в днях (разница между OrderDate и 
ShippedDate).   
В результатах должны быть возвращены заказы, срок которых превышает 
переданное значение или еще недоставленные заказы.  
Значению по умолчанию для передаваемого срока 35 дней.  
Название процедуры ShippedOrdersDiff.  
Процедура должна высвечивать следующие колонки: OrderID, OrderDate, 
ShippedDate, ShippedDelay (разность в днях между ShippedDate и OrderDate), 
SpecifiedDelay (переданное в процедуру значение).   
Необходимо продемонстрировать использование этой процедуры.
*/

USE Northwind;
GO

CREATE PROCEDURE dbo.ShippedOrdersDiff @SpecDelay INT AS 
BEGIN
	SELECT OrderID,OrderDate,ShippedDate, DATEDIFF(day,OrderDate,ShippedDate ) AS ShippedDelay , @SpecDelay    FROM dbo.Orders
	WHERE DATEDIFF(day,OrderDate,ShippedDate ) > @SpecDelay OR DATEDIFF(day,OrderDate,ShippedDate ) IS NULL
	ORDER BY ShippedDelay ;
END;

EXEC dbo.ShippedOrdersDiff 35
GO
/*
3.  Написать функцию, которая определяет, есть ли у продавца подчиненные. 
Возвращает тип данных BIT. В качестве входного параметра функции используется 
EmployeeID. Название функции IsBoss.  
Продемонстрировать использование функции для всех продавцов из таблицы 
Employees. 
*/

USE Northwind;
GO

--SELECT  Сотрудник.EmployeeID,Сотрудник.LastName AS [User Name], Руководитель.LastName AS [Boss], Сотрудник.ReportsTo
--FROM dbo.Employees AS Сотрудник LEFT JOIN dbo.Employees AS Руководитель ON Сотрудник.ReportsTo = Руководитель.EmployeeID;
--GO

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