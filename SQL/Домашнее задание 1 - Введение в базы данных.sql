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

DROP TABLE dbo.[Список поездов];
DROP TABLE dbo.[Состав поездов];
DROP TABLE dbo.[Список маршрутов];
DROP TABLE dbo.[Маршруты и Поезда];