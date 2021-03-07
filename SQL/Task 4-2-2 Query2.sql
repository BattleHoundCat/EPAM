
SELECT * FROM ##tblBook AS B INNER JOIN ##tblBookInLibrary AS BL ON B.BookID = BL.BookID
WHERE BL.BookDate > ('20050201') OR BL.BookDate IS NULL; 