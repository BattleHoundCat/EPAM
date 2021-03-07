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

