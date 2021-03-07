-- Ranking the most popular genres for games for customers in EACH COUNTRY?


CREATE VIEW Popular_Genres
AS
    SELECT *
    FROM Genre AS G, GameGenre AS GG, tblGame AS GA, orderGame AS OG, tblOrder AS O, tblCustomer AS C, Country AS CO
    WHERE G.GenreID = GG.GenreID
        AND GG.GameID = GA.GameID
        AND GG.GameID = OG.GameID
        AND OG.OrderID = O.OrderID
        AND C.CustomerID = O.CustomerID
        AND C.CountryID = CO.CountryID
    GROUP BY G.GenreID, GG.GenreID
GO
SELECT GenreID, Genre, RANK() OVER(PARTITION BY CountryName ORDER BY SUM(Quantity * Price)) AS RANK
FROM Popular_Genres



