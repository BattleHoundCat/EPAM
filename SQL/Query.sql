USE Northwind;
GO

/*Домашнее задание 1 - Введение в базы данных

Необходимо разработать упрощенную заготовку структуру базы данных для 
информационной системы «Расписание движения пассажирских поездов».  
База данных должна удовлетворять следующим условиям:  
 
• должна быть в третьей нормальной форме;  
• в таблицах должны быть прописаны первичные ключи;  
• в таблицах должны быть прописаны внешние ключи.  

В базе данных должна содержаться следующая информация:  
 
• номер поезда (номер поезда может повторяться);  
• категория поезда (скорый, скоростной, пассажирский, пригородный);  
• маршрут следования поезда:  
o начальная и конечная станция;  
o промежуточные станции, на которых поезд останавливается;  
o время прибытия и отправления по станциям;  
• состав поезда: o номер вагона;  
o категория вагона (сидячий, плацкартный, купейный, СВ).  
 
Название станции не является уникальным.
*/

if exists (select * from sysdatabases where name='Расписание движения пассажирских поездов')
		drop database [Расписание движения пассажирских поездов]

CREATE DATABASE [Расписание движения пассажирских поездов];
GO

USE [Расписание движения пассажирских поездов];
GO

CREATE TABLE "Список поездов" (
"TrainID" INT IDENTITY NOT NULL,
"Train Category" NVARCHAR(15) NOT NULL CHECK ("Train Category" IN ('Скорый','Скоростной','Пассажирский','Пригородный')),
CONSTRAINT "PK_Trains" PRIMARY KEY CLUSTERED( "TrainID")
)
GO

CREATE TABLE "Состав поездов"(
"CarriageID" INT IDENTITY NOT NULL,
"Carriage Category" NVARCHAR(15) NOT NULL CHECK ("Carriage Category" IN ('Сидячий','Плацкартный','Купейный','СВ')),
"TrainID" INT NULL,
CONSTRAINT "PK_Carriages" PRIMARY KEY CLUSTERED("CarriageID"),
CONSTRAINT "FK_Carrieage_Trains" FOREIGN KEY( "TrainID") REFERENCES "dbo"."Список поездов" ( "TrainID")
)
GO

CREATE TABLE "Список маршрутов"(
"RouteID" INT IDENTITY NOT NULL,
"Station Name" NVARCHAR(50) NOT NULL,
"Station Type" NVARCHAR(15) NOT NULL CHECK ("Station Type" IN ('Начальная','Конечная','Промежуточная')),
"Arrival Time" TIME NOT NULL,
"Time of Dispatch" TIME NOT NULL
CONSTRAINT "PK_Routes" PRIMARY KEY ( "RouteID")
)
GO
CREATE TABLE "Маршруты и Поезда"(
"TrainID" INT,
"RouteID" INT,
CONSTRAINT "PK_Trains_Routes" PRIMARY KEY ( "TrainID", "RouteID"),
CONSTRAINT "FK_Trains" FOREIGN KEY( "TrainID") REFERENCES "dbo"."Список поездов" ( "TrainID"),
CONSTRAINT "FK_Routes" FOREIGN KEY( "RouteID") REFERENCES "dbo"."Список маршрутов" ( "RouteID")
)
GO
--
SELECT * FROM dbo.[Список поездов];
SELECT * FROM dbo.[Состав поездов];
SELECT * FROM dbo.[Список маршрутов];
SELECT * FROM dbo.[Маршруты и Поезда];

INSERT INTO dbo.[Список поездов]
VALUES ('Скорый'), ('Скоростной'),('Пассажирский'),('Пригородный');
INSERT INTO dbo.[Состав поездов]
VALUES ('Сидячий',1), ('Плацкартный',1),('Купейный',2),('СВ',2);

/* Домашнее задание 2 -Простые запросы, соединение таблиц, подзапросы

2.1.  Работа с типами данных Date, NULL значениями, трехзначная логика. 
Возвращение определенных значений в результатах запроса в зависимости от 
полученных первоначальных значений результата запроса. Высветка в результатах 
запроса только определенных колонок.

2.1.1.   Выбрать в таблице Orders заказы, которые одновременно удовлетворяют 
условиям: 
•  были доставлены после 6 мая 1998 года (колонка ShippedDate) включительно; 
•  доставлены с ShipVia >= 2.  
 
Формат указания даты должен быть верным при любых региональных настройках, 
согласно требованиям статьи “Writing International Transact-SQL Statements” в Books 
Online раздел “Accessing and Changing Relational Data Overview”.  
Этот метод использовать далее для всех заданий.  
 
Запрос должен высвечивать только колонки: 
•  OrderID; 
•  ShippedDate; 
•  ShipVia.  
 
Пояснить почему сюда не попали заказы с NULL-ом в колонке ShippedDate. 

Ответ: "A NULL value is different from a zero value or a field that contains spaces. 
A field with a NULL value is one that has been left blank during record creation.
Без специального оператора null не вернет."
*/

USE Northwind;
GO

SELECT OrderID AS OrderID,ShippedDate AS ShippedDate,ShipVia 
FROM dbo.Orders AS [Orders-Task-2-1-1]
WHERE ShippedDate >= CONVERT(datetime, '19980506') AND ShipVia>=2;
GO

/*
2.1.2.   Написать запрос, который выводит только недоставленные заказы из таблицы 
Orders (т.е. в колонке ShippedDate нет значения даты доставки).  
 
Запрос должен высвечивать только колонки: 
•  OrderID; 
•  ShippedDate. 
 
Для колонки ShippedDate вместо значений NULL выводить строку ‘Not Shipped’ – для 
этого использовать системную функцию CASЕ.  
*/
USE Northwind;
GO

SELECT OrderID,
CASE 
WHEN ShippedDate IS NULL THEN N'Not Shipped'
END AS NoShipment
FROM dbo.Orders AS [Orders-Task-2-1-2]
WHERE ShippedDate IS NULL;
GO

/*
2.1.3.  Выбрать в таблице Orders заказы, которые удовлетворяют хотя бы одному из 
условий:  
•  были доставлены после 6 мая 1998 года (колонка ShippedDate) не включая эту 
дату;  
•  еще не доставлены.  
 
Запрос должен высвечивать только колонки: 
•  OrderID (переименовать в Order Number); 
•  ShippedDate (переименовать в Shipped Date). 
 
Для колонки ShippedDate вместо значений NULL выводить строку ‘Not Shipped’, для 
остальных значений высвечивать дату в формате по умолчанию.
*/

USE Northwind;
GO

SELECT OrderID,
CASE 
WHEN ShippedDate IS NULL THEN N'Not Shipped'
END 
FROM dbo.Orders AS [Order-Task-2-1-3]
WHERE ShippedDate > CONVERT(datetime, '19980506') OR ShippedDate IS NULL;
GO

/*
2.2.  Использование операторов IN, DISTINCT, ORDER BY, NOT 
 
2.2.1.   Выбрать из таблицы Customers всех заказчиков, проживающих в USA и Canada. 
Запрос сделать с только помощью оператора IN.  
Высвечивать колонки с именем пользователя и названием страны в результатах запроса.  
Упорядочить результаты запроса по имени заказчиков и по месту проживания. 
*/

USE Northwind;
GO

SELECT ContactName,Country FROM dbo.Customers AS [Customers-Task-2-2-1]
WHERE Country IN ('USA','Canada')
ORDER BY ContactName,Country ;
GO

/*
2.2.2.   Выбрать из таблицы Customers всех заказчиков, не проживающих в USA и Canada. 
Запрос сделать с помощью оператора IN.  
Высвечивать колонки с именем пользователя и названием страны в результатах запроса.  
Упорядочить результаты запроса по имени заказчиков. 
*/
USE Northwind;
GO

SELECT ContactName,Country FROM dbo.Customers AS [Customers-Task-2-2-2]
WHERE Country NOT IN ('USA','Canada')
ORDER BY ContactName ;
GO


/* 
2.2.3.   Выбрать из таблицы Customers все страны, в которых проживают заказчики.  
Страна должна быть упомянута только один раз.  
Cписок стран должен быть отсортирован по убыванию.  
Не использовать предложение GROUP BY.  
Высвечивать только одну колонку в результатах запроса. 
*/
USE Northwind;
GO

SELECT DISTINCT Country 
FROM dbo.Customers AS [Customers-Task-2-2-3]
ORDER BY Country DESC;
GO

/*
2.3.  Использование оператора BETWEEN, DISTINCT 
 
2.3.1.   Выбрать все заказы (OrderID) из таблицы Order Details (заказы не должны 
повторяться), где встречаются продукты с количеством от 3 до 10 включительно – это 
колонка Quantity в таблице Order Details.  
Использовать оператор BETWEEN.  
Запрос должен высвечивать только колонку OrderID. 
*/

USE Northwind;
GO

SELECT OrderID
FROM dbo.[Order Details] AS [OrderDetail-Task-2-3-1]
WHERE Quantity BETWEEN 3 AND 10;
GO

/*
2.3.2.   Выбрать всех заказчиков из таблицы Customers, у которых название страны 
начинается на буквы из диапазона b и g.  
Использовать оператор BETWEEN.  
Проверить, что в результаты запроса попадает Germany.  
 
Запрос должен высвечивать только колонки 
•  CustomerID;  
•  Country. 
 
Результат запроса должен быть отсортирован по Country. 
*/
USE Northwind;
GO

SELECT CustomerID,Country
FROM dbo.Customers AS [Customers-Task-2-3-2]
WHERE Country BETWEEN 'b' AND 'gf'
ORDER BY Country;
GO
--сравнение двух скриптов Task 2-3-2 и Task 2-3-3 вообще не дали никаких различий. 
--Одинаково по всем параметрам выполняются

/*
2.3.3.   Выбрать всех заказчиков из таблицы Customers, у которых название страны 
начинается на буквы из диапазона b и g.  
Не используя оператор BETWEEN.  
 
Запрос должен высвечивать только колонки 
• CustomerID;  
• Country. 
 
Результат запроса должен быть отсортирован по Country. 
 
С помощью опции “Execution Plan” определить какой запрос предпочтительнее 2.3.2 или 
2.3.3. Для этого надо ввести в скрипт выполнение текстового Execution Plan-a для двух 
этих запросов. Результаты выполнения Execution Plan надо ввести в скрипт в виде 
комментария и по их результатам дать ответ на вопрос – по какому параметру было 
проведено сравнение.  
Запрос должен высвечивать только колонки CustomerID и Country и отсортирован по 
Country. 
*/

USE Northwind;
GO

SELECT CustomerID,Country
FROM dbo.Customers AS [Customers-Task-2-3-3]
WHERE Country >='b' AND Country <= 'gf'
ORDER BY Country;
GO
--сравнение двух скриптов Task 2-3-2 и Task 2-3-3 вообще не дали никаких различий. 
--Одинаково по всем параметрам выполняются

/*
2.4.  Использование оператора LIKE, строковых функций 
 
2.4.1.   В таблице Products найти все продукты (колонка ProductName), где встречается 
подстрока 'chocolade'. Известно, что в подстроке 'chocolade' может быть изменена одна 
буква 'c' в середине - найти все продукты, которые удовлетворяют этому условию.  
Подсказка: результаты запроса должны высвечивать 2 строки. 
*/

USE Northwind;
GO

SELECT ProductID,ProductName
FROM dbo.Products AS [Products-Task-2-4-1]
WHERE ProductName LIKE N'%ho_olade' ;
GO

/*
2.4.2.   Для формирования алфавитного указателя Employees высветить из таблицы 
Employees список только тех букв алфавита, с которых начинаются фамилии Employees 
(колонка LastName ) из этой таблицы.  
Алфавитный список должен быть отсортирован по возрастанию. 
*/
USE Northwind;
GO

SELECT DISTINCT SUBSTRING(LastName,1,1) AS [EmpLastNames]
FROM dbo.Employees AS [Employees-Task-2-4-2]
ORDER BY [EmpLastNames] ASC;
GO

/*
2.5.  Join tables, subqueries 
 
2.5.1.  Определить продавцов, которые обслуживают регион 'Western' (таблица Region). 
Результаты запроса должны высвечивать поля:  
• 'LastName' продавца; 
• название обслуживаемой территории ('TerritoryDescription' из таблицы 
Territories). 
 
Запрос должен использовать JOIN в предложении FROM.  
 
Для определения связей между таблицами Employees и Territories надо использовать 
графические диаграммы для базы Northwind. 
*/
USE Northwind;
GO

SELECT E.LastName AS LastName, Ter.TerritoryDescription AS TerrDesc
FROM dbo.Employees As E
INNER JOIN dbo.EmployeeTerritories AS ET ON E.EmployeeID = ET.EmployeeID
INNER JOIN dbo.Territories AS Ter ON ET.TerritoryID = Ter.TerritoryID
INNER JOIN dbo.Region AS R ON Ter.RegionID = R.RegionID
WHERE RegionDescription =N'Western';
GO

/*
2.5.2.  Высветить в результатах запроса имена всех заказчиков из таблицы Customers и 
суммарное количество их заказов из таблицы Orders.  
 
Принять во внимание, что у некоторых заказчиков нет заказов, но они также должны 
быть выведены в результатах запроса.  
 
Упорядочить результаты запроса по возрастанию количества заказов. 
*/
USE Northwind;
GO

SELECT C.ContactName AS ContactName, Count(O.OrderID) AS [Всего заказов]
FROM dbo.Orders AS O FULL OUTER JOIN dbo.Customers AS C ON O.CustomerID = C.CustomerID
GROUP BY C.ContactName
ORDER BY [Всего заказов] ASC;
GO

/*
2.5.3.  Высветить всех поставщиков колонка CompanyName в таблице Suppliers, у 
которых нет хотя бы одного продукта на складе (UnitsInStock в таблице Products равно 0). 
*/
USE Northwind;
GO

SELECT S.CompanyName AS CompanyName, P.UnitsInStock AS UnitsInStock
FROM dbo.Suppliers AS S INNER JOIN dbo.Products AS P ON S.SupplierID = P.SupplierID
WHERE P.UnitsInStock =0;
GO

/*Домашнее задание 3 - Группировка данных, агрегатные функции

3.1.  Использование агрегатных функций (SUM, COUNT) 
 
3.1.1.  Найти общую сумму всех заказов из таблицы Order Details с учетом 
количества закупленных товаров и скидок по ним.  
Результат округлить до сотых и высветить в стиле 1 для типа данных money.   
Скидка (колонка Discount) составляет процент из стоимости для данного товара.  
Для определения действительной цены на проданный продукт надо вычесть 
скидку из указанной в колонке UnitPrice цены.  
Результатом запроса должна быть одна запись с одной колонкой с названием 
колонки 'Totals'. 
*/
USE Northwind;
GO

SELECT Convert(money,ROUND(SUM((OD.UnitPrice*(1-OD.Discount))*OD.Quantity),2),1) AS Totals
FROM dbo.[Order Details] AS OD;
GO
/*
3.1.2.  По таблице Orders найти количество заказов, которые еще не были 
доставлены (т.е. в колонке ShippedDate нет значения даты доставки).  
Использовать при этом запросе только оператор COUNT.  
Не использовать предложения WHERE и GROUP. 
*/
USE Northwind;
GO

SELECT Count(*) - COUNT(ShippedDate) AS NotNullCount
From dbo.Orders AS Orders;
GO
/*
3.1.3.  По таблице Orders найти количество различных покупателей (CustomerID), 
сделавших заказы.  
Использовать функцию COUNT и не использовать предложения WHERE и GROUP.
*/
USE Northwind;
GO

SELECT COUNT(DISTINCT O.CustomerID) AS [Уникальные клиенты]
From dbo.Orders AS O;
GO
/*
3.2.  Явное соединение таблиц, самосоединения, использование агрегатных 
функций и предложений GROUP BY и HAVING 
 
3.2.1.  По таблице Orders найти количество заказов с группировкой по годам.  
В результатах запроса надо высвечивать две колонки c названиями Year и Total.  
 
Написать проверочный запрос, который вычисляет количество всех заказов. 
*/
USE Northwind;
GO
--основной запрос
SELECT  Count(OrderID) AS Количество, YEAR(O.OrderDate) AS [По годам]
FROM dbo.Orders AS O
GROUP BY YEAR(O.OrderDate)
ORDER BY [По годам];
GO
--проверочный запрос
SELECT COUNT(*) AS [Всего заказов]
From dbo.Orders AS O;
GO

/*
3.2.2.  По таблице Orders найти количество заказов, оформленных каждым 
продавцом.  
Заказ для указанного продавца – это любая запись в таблице Orders, где в колонке 
EmployeeID задано значение для данного продавца.

В результатах запроса надо высвечивать колонку с именем продавца (Должно 
высвечиваться имя полученное конкатенацией LastName & FirstName. Эта строка 
LastName & FirstName должна быть получена отдельным запросом в колонке 
основного запроса. Также основной запрос должен использовать группировку 
по EmployeeID.) с названием колонки ‘Seller’ и колонку c количеством заказов 
высвечивать с названием 'Amount'.  
Результаты запроса должны быть упорядочены по убыванию количества заказов. 
*/

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

/*
3.2.3  По таблице Orders найти количество заказов 
 Условия: 
•  Заказы сделаны каждым продавцом и для каждого покупателя; 
•  Заказы сделаны в 1998 году. 
 
 В результатах запроса надо высвечивать: 
•  Колонку с именем продавца (название колонки ‘Seller’); 
•  Колонку с именем покупателя (название колонки ‘Customer’);  
•  Колонку c количеством заказов высвечивать с названием 'Amount'. 
 
В запросе необходимо использовать специальный оператор языка T-SQL для 
работы с выражением GROUP (Этот же оператор поможет выводить строку “ALL” 
в результатах запроса).   
 
Группировки должны быть сделаны по ID продавца и покупателя.  
 
Результаты запроса должны быть упорядочены по:  
•  Продавцу; 
•  Покупателю; 
•  убыванию количества продаж.   
 
В результатах должна быть сводная информация по продажам.: 
 
Seller  Customer  Amount 
 
ALL                 ALL   <общее число продаж> 
<имя>   ALL   <число продаж для данного продавца> 
ALL               <имя>  <число продаж для данного покупателя> 
<имя>  <имя>  <число продаж данного продавца для даннного покупателя> 
*/
USE Northwind;
GO

SELECT ISNULL((SELECT E.LastName FROM dbo.Employees AS E WHERE E.EmployeeID = O.EmployeeID),N'ALL') AS Seller, ISNULL(O.CustomerID,N'ALL') AS Customer, COUNT(*) AS Amount 
FROM dbo.Orders AS O INNER JOIN dbo.Employees AS E ON O.EmployeeID = E.EmployeeID
INNER JOIN dbo.Customers AS C ON O.CustomerID = C.CustomerID
WHERE YEAR(O.OrderDate) = '1998'
GROUP BY CUBE (O.EmployeeID, O.CustomerID)
ORDER BY COUNT(*) DESC;

/*
3.2.4.  Найти покупателей и продавцов, которые живут в одном городе.  
Если в городе живут только продавцы или только покупатели, то информация о 
таких покупателя и продавцах не должна попадать в результирующий набор.  
  
В результатах запроса необходимо вывести следующие заголовки для результатов 
запроса:  
•  ‘Person’; 
•  ‘Type’ (здесь надо выводить строку ‘Customer’ или  ‘Seller’ в завимости от 
типа записи); 
•  ‘City’.  
Отсортировать результаты запроса по колонке ‘City’ и по ‘Person’. 
*/
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

/*
3.2.5.  Найти всех покупателей, которые живут в одном городе.  
В запросе использовать соединение таблицы Customers c собой - 
самосоединение. Высветить колонки CustomerID и City.  
Запрос не должен высвечивать дублируемые записи.  
Для проверки написать запрос, который высвечивает города, которые 
встречаются более одного раза в таблице Customers. Это позволит проверить 
правильность запроса. 
*/
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
/*
3.2.6.  По таблице Employees найти для каждого продавца его руководителя, т.е. 
кому он делает репорты.  
Высветить колонки с именами 'User Name' (LastName) и 'Boss'. В колонках должны 
быть высвечены имена из колонки LastName.  
 
Высвечены ли все продавцы в этом запросе?
Ответ: "Да"
*/
USE Northwind;
GO

SELECT Сотрудник.LastName AS [User Name], Руководитель.LastName AS [Boss]
FROM dbo.Employees AS Сотрудник LEFT JOIN dbo.Employees AS Руководитель ON Сотрудник.ReportsTo = Руководитель.EmployeeID;

/*
Домашнее задание 4 - CRUD операции, временные таблицы
4.1. CRUD operations

4.1.1. Написать запрос, который добавляет новый заказ в таблицу dbo.Orders 
Необходимо написать два запроса 
• первый с использованием Values; 
• второй с использованием Select. 
*/
USE Northwind;
GO


INSERT INTO dbo.Orders (ShipCountry)
VALUES (N'Russia');

INSERT INTO dbo.Orders (ShipCountry)
SELECT ShipCountry FROM dbo.Orders AS O2
WHERE O2.OrderID = 10248;

DELETE FROM dbo.Orders
OUTPUT deleted.*
WHERE OrderID > 11077;

/*
4.1.2. Написать запрос, который добавляет 5 новых заказов в таблицу dbo.Orders 
Необходимо написать два запроса 
• первый с использованием Values; 
• второй с использованием Select. 
*/
USE Northwind;
GO

SELECT * FROM dbo.Orders AS O;

INSERT INTO dbo.Orders (ShipCountry)
VALUES (N'Russia1'),(N'Russia2'),(N'Russia3'),(N'Russia4'),(N'Russia5');

INSERT INTO dbo.Orders (ShipCountry)
SELECT ShipCountry FROM dbo.Orders AS O2
WHERE O2.OrderID BETWEEN 10248 AND 10252;

DELETE FROM dbo.Orders
OUTPUT deleted.*
WHERE OrderID > 11077;

/*
4.1.3. Написать запрос, который добавляет в таблицу dbo.Orders дублирующие 
заказы по CustomerID = ‘WARTH’ и продавцу EmployeeID = 5 (заменить 
CustomerID на ‘TOMSP’). 
*/

USE Northwind;
GO


INSERT INTO dbo.Orders (CustomerID,EmployeeID,OrderDate,RequiredDate,ShippedDate,ShipCountry)
SELECT CustomerID,EmployeeID,OrderDate,RequiredDate,ShippedDate,ShipCountry FROM dbo.Orders AS O2
WHERE O2.CustomerID =N'WARTH' AND O2.EmployeeID=5;
GO
UPDATE dbo.Orders 
SET CustomerID =N'TOMSP'
OUTPUT N'Заменили', deleted.*, inserted.*
WHERE CustomerID =N'WARTH' AND OrderID >11077;
GO

DELETE FROM dbo.Orders
OUTPUT deleted.*
WHERE OrderID > 11077;

/*
4.1.4. Написать запрос, который обновит по всем заказам дату ShippedDate 
(которые еще не доставлены) на текущую дату. 
*/
USE Northwind;
GO

SELECT * FROM dbo.Orders AS O
WHERE ShippedDate IS NULL;

UPDATE dbo.Orders 
SET ShippedDate = Null
OUTPUT N'Заменили', deleted.*, inserted.*
WHERE YEAR(ShippedDate) = '2021';
GO

/*
4.1.5. Написать запрос, который обновит скидку на произвольное значение (поле 
Discount таблицы dbo.[Order Details]) по заказам, где CustomerID = ‘GODOS’ 
по продукту ‘Tarte au sucre’. 
*/
USE Northwind;
GO

SELECT OD.* 
FROM dbo.Orders AS O INNER JOIN dbo.[Order Details] AS OD ON O.OrderID = OD.OrderID
INNER JOIN dbo.Products AS P ON OD.ProductID = P.ProductID
WHERE O.CustomerID = 'GODOS' AND P.ProductName = 'Tarte au sucre' ;

UPDATE dbo.[Order Details]
SET Discount= RAND()*(0.99 - 0.01)
FROM dbo.Orders AS O
INNER JOIN dbo.[Order Details] AS OD ON O.OrderID = OD.OrderID
INNER JOIN dbo.Products AS P ON OD.ProductID = P.ProductID
WHERE O.CustomerID = 'GODOS' AND P.ProductName = 'Tarte au sucre' ;
GO

DELETE FROM dbo.Orders
OUTPUT deleted.*
WHERE YEAR(ShippedDate) = '2021';

/*
4.1.6. Написать запрос, который удалит заказы, по которым сумма заказа меньше 
20.
*/

USE Northwind;
GO

SELECT OD.*
FROM dbo.Orders AS O INNER JOIN dbo.[Order Details] AS OD ON O.OrderID = OD.OrderID
WHERE (OD.Quantity*OD.UnitPrice) < 20;

DELETE O
OUTPUT deleted.*
FROM dbo.Orders AS O
JOIN dbo.[Order Details] AS OD ON O.OrderID = OD.OrderID
WHERE (OD.Quantity*OD.UnitPrice) < 20;
GO

/*
4.2. Temporary tables 
 
4.2.1. Необходимо создать и заполнить две временные таблицы: 
 
- #tblBook – содержит информацию о книгах, которые есть в библиотеке
- #tblBookInLibrary – содержит информацию о дате регистрации по 
некоторым книгам в библиотеке 

Используя данные из этих таблиц необходимо написать запросы: 
Запрос 1. Выбрать все книги, а поле дата должно быть заполнено только у 
тех книг,  
у которых дата регистрации больше  01.02.2005 
Запрос 2. Выбрать все книги у которых дата регистрации в библиотеке 
больше  01.02.2005, либо не задана вообще.
*/

USE Northwind;
GO

CREATE TABLE #tblBook (BookID INT NOT NULL,Name NVARCHAR(25) NOT NULL);

INSERT INTO #tblBook VALUES (1,N'Война и Мир'),(2,N'Преступление и наказание'),(3,N'Мастер и Маргарита'),(4,N'Тихий Дон'),(5,N'Властелин колец');

SELECT * FROM #tblBook;

CREATE TABLE #tblBookInLibrary (BookID INT NOT NULL,BookDate Date NULL);

INSERT INTO #tblBookInLibrary VALUES (1,'20060501'),(3,'20040705'),(4,'20010215'),(2,'20071222'),(5, NULL);

SELECT * FROM #tblBookInLibrary;

--Query1
SELECT * FROM #tblBook AS B INNER JOIN #tblBookInLibrary AS BL ON B.BookID = BL.BookID
WHERE BL.BookDate > ('20050201'); 
--Query2
SELECT * FROM #tblBook AS B INNER JOIN #tblBookInLibrary AS BL ON B.BookID = BL.BookID
WHERE BL.BookDate > ('20050201') OR BL.BookDate IS NULL; 

DROP TABLE #tblBook;
DROP TABLE #tblBookInLibrary;

/*
4.2.2. Переделать выполнение задания 4.2.1 таким образом, чтобы 
 
•  создание временных таблиц выполнялось в одном соединении к БД.  
Скрипт запроса записать в файл Query41.sql; 
•  Запрос 1 выполнить в другом соединении к БД. 
Скрипт запроса записать в файл Query42.sql; 
•  Запрос 2 выполнить в третьем соединении к БД. 
Скрипт запроса записать в файл Query43.sql. 
 
Для работы с разыми соединениями к БД достаточно использовать разные 
вкладки Microsoft SQL Server Management Studio. 
 
НЕ ИСПОЛЬЗОВАТЬ ПОСТОЯННЫЕ ТАБЛИЦЫ – ТОЛЬКО ВРЕМЕННЫЕ! 
*/

--Создание временной таблицы в одном соединении
CREATE TABLE ##tblBook (BookID INT NOT NULL,Name NVARCHAR(25) NOT NULL);
INSERT INTO ##tblBook VALUES (1,N'Война и Мир'),(2,N'Преступление и наказание'),(3,N'Мастер и Маргарита'),(4,N'Тихий Дон'),(5,N'Властелин колец');
CREATE TABLE ##tblBookInLibrary (BookID INT NOT NULL,BookDate Date NULL);
INSERT INTO ##tblBookInLibrary VALUES (1,'20060501'),(3,'20040705'),(4,'20010215'),(2,'20071222'),(5, NULL);
GO

--Запрос 1 в другом соединении
SELECT * FROM ##tblBook AS B INNER JOIN ##tblBookInLibrary AS BL ON B.BookID = BL.BookID
WHERE BL.BookDate > ('20050201'); 

--Запрос 2 в третьем соединении
SELECT * FROM ##tblBook AS B INNER JOIN ##tblBookInLibrary AS BL ON B.BookID = BL.BookID
WHERE BL.BookDate > ('20050201') OR BL.BookDate IS NULL; 

/*
Домашнее задание 5 - Хранимые процедуры, функции, триггеры, курсоры, представления.pdf

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

/*
4.  Написать запрос, который должен вывести следующие поля:  
•  OrderID (dbo.Orders),  
•  CustomerID (dbo.Orders),  
•  LastName + FirstName (dbo.Employees),  
•  OrderDate (dbo.Orders),  
•  RequiredDate (dbo.Orders),  
•  ProductName (dbo.Products),  
•  цену товара с учетом скидки.  
•   
Результат запроса необходимо представить в виде представления.  
 
Отсортировать по цене товара. 
*/
USE Northwind;
GO

CREATE VIEW MyView
AS
SELECT O.OrderID , O.CustomerID , E.FirstName + ' ' + E.LastName AS Fullname , O.OrderDate, O.RequiredDate, P.ProductName, OD.UnitPrice*OD.Discount AS FullPrice
FROM dbo.Orders AS O INNER JOIN dbo.Employees AS E ON O.EmployeeID = E.EmployeeID
INNER JOIN dbo.[Order Details] AS OD ON O.OrderID = OD.OrderID
INNER JOIN dbo.Products AS P ON OD.ProductID = P.ProductID;
GO

SELECT * FROM MyView
ORDER BY FullPrice DESC;

/*
5.  Создать таблицу dbo.OrdersHistory, которая будет хранить историю 
изменений по таблице dbo.Orders.  
Необходимо подумать какие бы поля могла бы содержать данная таблица.  
Обосновать свой выбор. Почему именно такой набор полей должен быть в 
таблице dbo.OrdersHistory?  
Затем для таблицы dbo.Orders необходимо создать триггер, который при любом 
изменении данных в таблице dbo.Orders будет записывать значения в новую 
таблицу dbo.OrdersHistory.  
Написать проверочный запрос, который будет изменять/удалять данные из 
таблицы dbo.Orders. 
*/
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