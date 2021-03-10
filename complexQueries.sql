CREATE VIEW Popular_Genres
AS
    SELECT CO.CountryID, G.GenreID, G.GenreName, SUM(OG.Quantity * GA.Price) AS Revenue
    FROM Genre AS G, GameGenre AS GG, tblGame AS GA, orderGame AS OG, tblOrder AS O, tblCustomer AS C, tblCountry AS CO
    WHERE G.GenreID = GG.GenreID
        AND GG.GameID = GA.GameID
        AND GG.GameID = OG.GameID
        AND OG.OrderID = O.OrderID
        AND C.CustomerID = O.CustomerID
        AND C.CountryID = CO.CountryID
    GROUP BY CO.CountryID, G.GenreID, G.GenreName
GO
SELECT *
FROM (
SELECT GenreID, GenreName, RANK() OVER(PARTITION BY CountryID ORDER BY Revenue) AS RANK
    FROM Popular_Genres) as t
WHERE RANK < 5
