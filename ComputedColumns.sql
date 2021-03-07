-- Computed Columun #1 for shourya
-- Computed the total number of units sold for each game

CREATE FUNCTION fn_GameQuanitySold(@GameID INT)
RETURNS INT
AS
BEGIN
    DECLARE @RET INT = (SELECT SUM(Quantity)
    FROM tblGame AS G, orderGame AS OG
    WHERE G.gameID = OG.gameID
        AND G.gameID = @GameID
    GROUP BY G.gameID 
    )
    RETURN @RET
END
GO

ALTER TABLE tblGame
ADD TotalQuantitySold AS (GameQuanitySold(GameID))
GO

-- Computed Columun #2 for shourya
-- Compute the revenue for publishers, i.e. the publishers with the most revenue on our platform
CREATE FUNCTION fn_RevenueForPublisher(@Publish_ID INT)
RETURNS INT
AS
BEGIN
    DECLARE @RET INT = (SELECT SUM(OG.Quantity * G.Price)
    FROM tblGame AS G, orderGame AS OG, Publisher AS P
    WHERE P.PublisherID = @Publish_ID
        AND P.PublisherID = G.PublisherID
        AND G.gameID = OG.gameID
        AND G.gameID = @GameID
    GROUP BY P.PublisherID
    )
    RETURN @RET
END
GO

ALTER TABLE Publisher
ADD TotalRevenueGenerated AS RevenueForPublisher(Publish_ID)