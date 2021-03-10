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


CREATE VIEW Top_Rated_games
AS 
WITH CTE_TOP_RATED_GAMES(GameID, totalRating) AS (
    SELECT G.gameID, SUM(RA.RatingNum)
    FROM tblRATING RA
    JOIN tblReview RE ON RA.RatingID = RE.RatingID
    JOIN OrderGame OG ON OG.OrderGameID = RE.OrderGameID
    JOIN tblGAME G ON G.gameID = OG.GameID
    GROUP BY G.gameID
)
SELECT C.ConsoleName, CTRG.GameID, CTRG.totalRating, 
        RANK() OVER(PARTITION BY C.ConsoleName ORDER BY CTRG.totalRating) AS Rank
FROM CTE_TOP_RATED_GAMES AS CTRG
JOIN tblGameConsole GC ON CTRG.GameID = GC.gameID
JOIN tblCONSOLE C ON C.ConsoleID = GC.consoleID
GO
SELECT *
FROM Top_Rated_games
WHERE Rank < 5
